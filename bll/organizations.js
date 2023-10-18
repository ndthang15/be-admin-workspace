module.exports = (app) => {
    const organizationDAL = app.dal.organizations;

    async function getOrganizations(options) {
        const organizations = await organizationDAL.getOrganizations(options);
        return organizations;
    }

    async function getOrganization(organizationId) {
        const organization = await organizationDAL.getOrganization(organizationId);
        return organization;
    }

    async function createOrganization(organizationData) {
        const organization = await organizationDAL.createOrganization(organizationData);
        return organization;
    }

    async function updateOrganization(organizationId, organizationData) {
        const organization = await organizationDAL.updateOrganization(organizationId, organizationData);
        return organization;
    }

    async function deleteOrganization(organizationId) {
        await organizationDAL.deleteOrganization(organizationId);
    }

    return {
        getOrganizations,
        getOrganization,
        createOrganization,
        updateOrganization,
        deleteOrganization,
    };
};
