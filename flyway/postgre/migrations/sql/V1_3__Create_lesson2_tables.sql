CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TYPE organization_status_type AS ENUM ('active', 'suspend', 'deleted');
CREATE TYPE user_status_type AS ENUM ('active', 'deactivated', 'deleted');
CREATE TYPE gender_type AS ENUM ('male', 'female');

CREATE TABLE IF NOT EXISTS sso_organization (
    organization_id SERIAL PRIMARY KEY NOT NULL GENERATED ALWAYS AS identity,
    organization_name VARCHAR(255) NOT NULL,
    status organization_status_type DEFAULT 'active'::organization_status_type NOT NULL,
    address VARCHAR(255),
    contact_number VARCHAR(255),
    email VARCHAR(255),
    country VARCHAR(255),
    state VARCHAR(255),
    city VARCHAR(255),
    postal_code VARCHAR(255),
    website_url VARCHAR(255),
    kvp JSONB,
    date_created TIMESTAMPTZ DEFAULT now(),
    date_modified TIMESTAMPTZ DEFAULT now(),
);

CREATE TABLE IF NOT EXISTS sso_role (
    role_id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    role_name VARCHAR(255) NOT NULL,
    role_description VARCHAR(255),
    organization_id INT NOT NULL,
    FOREIGN KEY (organization_id) REFERENCES sso_organization(organization_id)
);

CREATE TABLE IF NOT EXISTS sso_user (
    user_id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    username VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    kvp JSONB,
    date_created TIMESTAMPTZ DEFAULT now(),
    date_modified TIMESTAMPTZ DEFAULT now(),
    modified_by BIGINT,
    last_logged_in TIMESTAMPTZ,
    user_settings JSONB DEFAULT '{}' :: JSONB,
    status user_status_type DEFAULT 'active' :: user_status_type
);

CREATE TABLE IF NOT EXISTS sso_user_profile (
    profile_id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    user_id UUID NOT NULL,
    birth_date DATE,
    sex gender_type,
    title VARCHAR(255),
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    avatar VARCHAR(255),
    age INT,
    address VARCHAR(255),
    date_created TIMESTAMPTZ DEFAULT now(),
    date_modified TIMESTAMPTZ DEFAULT now(),
    FOREIGN KEY (user_id) REFERENCES sso_user(user_id)
);

CREATE TABLE IF NOT EXISTS sso_organization_user (
    organization_id BIGINT,
    user_id UUID,
    PRIMARY KEY (organization_id, user_id),
    FOREIGN KEY (organization_id) REFERENCES sso_organization(organization_id),
    FOREIGN KEY (user_id) REFERENCES sso_user(user_id)
);

CREATE TABLE IF NOT EXISTS sso_user_role (
    user_id UUID,
    role_id UUID,
    PRIMARY KEY (user_id, role_id),
    FOREIGN KEY (user_id) REFERENCES sso_user(user_id),
    FOREIGN KEY (role_id) REFERENCES sso_role(role_id)
);
