INSERT INTO
    sso_organization (
        org_id,
        org_name,
        kvp,
        address,
        contact_number,
        email,
        country,
        city,
        postal_code,
        website_url
    )
VALUES
    (
        1,
        'org 1',
        '{}',
        '643 Pham Van Dong',
        '0123-456-789',
        'info@nomail.com',
        'Vietnam',
        'Hanoi',
        '10000',
        'org1.com'
    ),
    (
        2,
        'org 2',
        '{}',
        '643 Pham Van Dong',
        '0123-456-789',
        'info@nomail.com',
        'Vietnam',
        'Hanoi',
        '10000',
        'org2.com'
    );

INSERT INTO
    sso_role (role_name, role_description, org_id)
VALUES
    (
        'admin',
        'admin',
        1
    ),
    ('user', 'user', 1),
    ('super-admin', 'super admin', 1);

INSERT INTO
    sso_user (
        username,
        password,
        email,
        kvp,
        modified_by,
        last_logged_in,
        user_settings,
    )
VALUES
    (
        'admin',
        'admin_password',
        'admin@example.com',
        '{}',
        NULL,
        NULL,
        '{}',
    ),
    (
        'super_admin',
        'user_password',
        'user1@example.com',
        '{}',
        NULL,
        NULL,
        '{}',
    ),
    (
        'user',
        'user_password',
        'user2@example.com',
        '{}',
        NULL,
        NULL,
        '{}',
    );

INSERT INTO
    sso_user_profile (
        user_id,
        birth_date,
        sex,
        title,
        first_name,
        last_name,
        avatar,
        age,
        address
    )
VALUES
    (
        (
            SELECT
                user_id
            FROM
                sso_user
            WHERE
                username = 'admin'
        ),
        '1995-01-01',
        'male',
        'Mr.',
        'Admin',
        'User',
        'url',
        33,
        '87 PD'
    ),
    (
        (
            SELECT
                user_id
            FROM
                sso_user
            WHERE
                username = 'super_admin'
        ),
        '1995-01-01',
        'female',
        'Ms.',
        'User',
        'User',
        'url',
        38,
        '87 PD'
    ),
    (
        (
            SELECT
                user_id
            FROM
                sso_user
            WHERE
                username = 'user'
        ),
        '1995-01-01',
        'male',
        'Mr.',
        'User',
        'User',
        'url',
        31,
        '87 PD'
    );

INSERT INTO
    sso_organization_user (org_id, user_id)
VALUES
    (
        (
            SELECT
                org_id
            FROM
                sso_organization
            LIMIT
                1
        ), (
            SELECT
                user_id
            FROM
                sso_user
            WHERE
                username = 'admin'
        )
    ),
    (
        (
            SELECT
                org_id
            FROM
                sso_organization
            LIMIT
                1
        ), (
            SELECT
                user_id
            FROM
                sso_user
            WHERE
                username = 'super_admin'
        )
    ),
    (
        (
            SELECT
                org_id
            FROM
                sso_organization OFFSET 1
            LIMIT
                1
        ), (
            SELECT
                user_id
            FROM
                sso_user
            WHERE
                username = 'user'
        )
    );

INSERT INTO
    sso_user_role (user_id, role_id)
VALUES
    (
        (
            SELECT
                user_id
            FROM
                sso_user
            WHERE
                username = 'admin'
        ),
        (
            SELECT
                role_id
            FROM
                sso_role
            WHERE
                role_name = 'admin'
        )
    ),
    (
        (
            SELECT
                user_id
            FROM
                sso_user
            WHERE
                username = 'super_admin'
        ),
        (
            SELECT
                role_id
            FROM
                sso_role
            WHERE
                role_name = 'user'
        )
    ),
    (
        (
            SELECT
                user_id
            FROM
                sso_user
            WHERE
                username = 'user'
        ),
        (
            SELECT
                role_id
            FROM
                sso_role
            WHERE
                role_name = 'super-admin'
        )
    );