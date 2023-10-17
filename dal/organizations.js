const _ = require('lodash');
const camelcaseKeys = require('camelcase-keys');

module.exports = (app) => {
    const db = app.pg;

    async function getOrganization(organizationId, dbClient = db) {
        if (!organizationId) {
            throw new Error('organizationId is required.');
        }

        const resultQuery = await getOrganizations({ organizationId }, dbClient);

        if (_.isEmpty(resultQuery.results)) {
            throw new Error('Organization Not Found');
        }
        return camelcaseKeys(resultQuery.results[0], { deep: true });
    }

    async function getOrganizations(options, dbClient = db) {
        const sqlWhere = [];
        const sqlParams = [];
        let sql = `
        SELECT so.organization_id,
            so.organization_name,
            so.status,
            so.address,
            so.contact_number,
            so.email,
            so.country,
            so.state,
            so.city,
            so.postal_code,
            so.website_url,
            so.date_created,
            so.date_modified
        FROM public.sso_organization so
    `;

        if (options.organizationId) {
            sqlParams.push(options.organizationId);
            sqlWhere.push(`so.organization_id = $${sqlParams.length}`);
        }

        if (sqlWhere.length) {
            sql += ' WHERE ' + sqlWhere.join(' AND ');
        }

        if (Number.isInteger(options.limit)) {
            sql += ` LIMIT ${options.limit || 30}`;
        }
        if (Number.isInteger(options.offset)) {
            sql += ` OFFSET ${options.offset || 0}`;
        }

        const resultQuery = await dbClient.query(sql, sqlParams);
        return {
            count: resultQuery.rows.length,
            results: camelcaseKeys(resultQuery.rows, { deep: true }),
            limit: options.limit || 30,
            offset: options.offset || 0,
        };
    }
    async function createOrganization(organizationData, dbClient = db) {
        const {
            organization_name,
            status,
            address,
            contact_number,
            email,
            country,
            state,
            city,
            postal_code,
            website_url,
            kvp,
        } = organizationData;

        const sql = `
          INSERT INTO public.sso_organization (
            organization_name, status, address, contact_number, email,
            country, state, city, postal_code, website_url, kvp
          ) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11)
          RETURNING *;
        `;

        const sqlParams = [
            organization_name,
            status,
            address,
            contact_number,
            email,
            country,
            state,
            city,
            postal_code,
            website_url,
            JSON.stringify(kvp),
        ];

        const result = await dbClient.query(sql, sqlParams);
        return camelcaseKeys(result.rows[0], { deep: true });
    }

    async function updateOrganization(organizationId, organizationData, dbClient = db) {
        const {
            organization_name,
            status,
            address,
            contact_number,
            email,
            country,
            state,
            city,
            postal_code,
            website_url,
            kvp,
        } = organizationData;

        const sql = `
            UPDATE public.sso_organization
            SET organization_name = $2,
                status = $3,
                address = $4,
                contact_number = $5,
                email = $6,
                country = $7,
                state = $8,
                city = $9,
                postal_code = $10,
                website_url = $11,
                kvp = $12,
                date_modified = NOW()
            WHERE organization_id = $1
            RETURNING *;
        `;

        const sqlParams = [
            organizationId,
            organization_name,
            status,
            address,
            contact_number,
            email,
            country,
            state,
            city,
            postal_code,
            website_url,
            JSON.stringify(kvp),
        ];

        const result = await dbClient.query(sql, sqlParams);
        if (result.rows.length === 0) {
            throw new Error(`Organization with ID ${organizationId} not found.`);
        }

        return camelcaseKeys(result.rows[0], { deep: true });
    }

    async function deleteOrganization(organizationId, dbClient = db) {
        const sql = `DELETE FROM public.sso_organization WHERE organization_id = $1;`;
        const sqlParams = [organizationId];

        await dbClient.query(sql, sqlParams);
    }

    return { getOrganization, getOrganizations, createOrganization, updateOrganization, deleteOrganization };
};
