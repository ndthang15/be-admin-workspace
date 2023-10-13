DROP TYPE IF EXISTS organization_status_type;
DROP TYPE IF EXISTS user_status_type;
DROP TYPE IF EXISTS sex_type;

CREATE TYPE organization_status_type AS ENUM ('active', 'suspend', 'deleted');
CREATE TYPE user_status_type AS ENUM ('active', 'deactivated', 'deleted');
CREATE TYPE sex_type AS ENUM ('male', 'female');

DROP TABLE IF EXISTS sso_organization;
DROP TABLE IF EXISTS sso_user;
DROP TABLE IF EXISTS sso_roles;
DROP TABLE IF EXISTS sso_user_profile;
DROP TABLE IF EXISTS sso_organization_user;
DROP TABLE IF EXISTS sso_user_role;



CREATE TABLE IF NOT EXISTS sso_organization (
    organization_id INT NOT NULL,
    organization_name VARCHAR(100) NOT NUll,
    kvp JSON,
    date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    date_modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status organization_status_type DEFAULT 'active',
    address VARCHAR(255),
    contact_number VARCHAR(100),
    email VARCHAR(100),
    country VARCHAR(255),
    state VARCHAR(255),
    city VARCHAR(255),
    postal_code VARCHAR(10),
    organization_sub_name VARCHAR(10),
    website_url VARCHAR(255)
    PRIMARY KEY (organization_id)
);

CREATE TABLE IF NOT EXISTS sso_user (
    user_id UUID DEFAULT uuid_generate_v4(),
    username VARCHAR(100) NOT NULL,
    password VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    kvp JSON,
    date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    date_modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified_by UUID DEFAULT uuid_generate_v4(),
    last_logged_in TIMESTAMP,
    user_settings JSON DEFAULT '{}',
    status user_status_type DEFAULT 'active'
    PRIMARY KEY (user_id)
);

CREATE TABLE IF NOT EXISTS sso_organization_user (
    organization_id INT NOT NULL,
    user_id UUID,
    PRIMARY KEY (organization_id, user_id),
    FOREIGN KEY (organization_id) REFERENCES sso_organization(organization_id),
    FOREIGN KEY (user_id) REFERENCES sso_user(user_id)
);

CREATE TABLE IF NOT EXISTS sso_roles (
    role_id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    role_name VARCHAR(255) NOT NULL 
    role_description VARCHAR(255),
    organization_id INT NOT NULL,
    status organization_status_type,
    PRIMARY KEY (role_id)
    FOREIGN KEY (organization_id) REFERENCES sso_organization(organization_id)
);

CREATE TABLE IF NOT EXISTS sso_user_profile (
    profile_id UUID DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL,
    birth_date DATE,
    sex sex_type,
    title VARCHAR(255),
    first_name VARCHAR(10),
    last_name VARCHAR(10),
    avatar VARCHAR(255),
    age INT,
    address VARCHAR(255),
    date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    date_modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(profile_id)
    FOREIGN KEY (user_id) REFERENCES sso_user(user_id)
);

CREATE TABLE IF NOT EXISTS sso_user_role (
    user_id UUID,
    role_id UUID,
    PRIMARY KEY (user_id, role_id),
    FOREIGN KEY (user_id) REFERENCES sso_user(user_id),
    FOREIGN KEY (role_id) REFERENCES sso_roles(role_id)
);