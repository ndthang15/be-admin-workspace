CREATE TYPE type_status AS ENUM ('active', 'deactivated', 'deleted');
CREATE TYPE type_sex AS ENUM ('male', 'female');
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE TABLE IF NOT EXISTS sso_user (
    user_id SERIAL PRIMARY KEY,
    user_name TEXT NOT NULL,
    password TEXT NOT NULL,
    email TEXT,
    kvp JSON,
    date_created TIMESTAMP,
    date_modified TIMESTAMP,
    modified_by UUID DEFAULT uuid_generate_v4(),
    last_logged_in TIMESTAMP,
    user_settings JSON DEFAULT '{}'::JSON,
    status type_status DEFAULT 'active'
);
CREATE TABLE IF NOT EXISTS sso_organization (
    organization_id SERIAL PRIMARY KEY,
    organization_name TEXT NOT NULL,
    kvp JSON,
    date_created TIMESTAMP,
    date_modified TIMESTAMP,
    status type_status DEFAULT 'active' NOT NULL,
    address TEXT,
    contact_number TEXT,
    email TEXT,
    country TEXT,
    state TEXT,
    city TEXT,
    postal_code TEXT,
    organization_sub_name TEXT,
    website_url TEXT
);
CREATE TABLE IF NOT EXISTS sso_role (
    role_id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    role_name TEXT NOT NULL,
    role_description TEXT,
    organization_id INT,
    CONSTRAINT fk_organization FOREIGN KEY (organization_id) REFERENCES sso_organization (organization_id)
);
CREATE TABLE IF NOT EXISTS sso_user_organization (
    organization_id INT NOT NULL,
    user_id INT NOT NULL,
    CONSTRAINT user_org PRIMARY KEY (organization_id, user_id),
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES sso_user (user_id),
    CONSTRAINT fk_org FOREIGN KEY (organization_id) REFERENCES sso_organization (organization_id)
);
CREATE TABLE IF NOT EXISTS sso_user_role (
    user_id INT NOT NULL,
    role_id UUID NOT NULL,
    CONSTRAINT user_role PRIMARY KEY (user_id, role_id),
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES sso_user (user_id),
    CONSTRAINT fk_role FOREIGN KEY (role_id) REFERENCES sso_role (role_id)
);
CREATE TABLE IF NOT EXISTS sso_user_profile (
    profile_id UUID DEFAULT uuid_generate_v4() NOT NULL,
    user_id INT NOT NULL,
    birth_date DATE,
    sex type_sex,
    title TEXT,
    firstname TEXT NOT NULL,
    lastname TEXT NOT NULL,
    avatar TEXT,
    age INT,
    address TEXT,
    date_created TIMESTAMP,
    CONSTRAINT fk_user_profiles FOREIGN KEY (user_id) REFERENCES sso_user (user_id)
);