CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TYPE org_status_type AS ENUM ('active', 'suspend', 'deleted');

CREATE TYPE user_status_type AS ENUM ('active', 'deactivated', 'deleted');

CREATE TYPE gender_type AS ENUM ('male', 'female');

CREATE TABLE IF NOT EXISTS sso_organization (
    org_id int PRIMARY KEY NOT NULL,
    org_name text NOT NULL,
    kvp JSON,
    created_time timestamp DEFAULT now(),
    updated_time timestamp DEFAULT now(),
    status org_status_type DEFAULT 'active' NOT NULL,
    address text,
    contact_number text,
    email text,
    country text,
    state text,
    city text,
    postal_code text,
    website_url text,
);

CREATE TABLE IF NOT EXISTS sso_user (
    user_id uuid DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    username text NOT NULL,
    password text NOT NULL,
    email text NOT NULL,
    kvp json,
    created_time timestamp DEFAULT now(),
    updated_time timestamp DEFAULT now(),
    modified_by uuid,
    last_logged_in timestamp,
    user_settings json DEFAULT '{}' :: json,
    status user_status_type DEFAULT 'active' NOT NULL,
);

CREATE TABLE IF NOT EXISTS sso_user_profile (
    profile_id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
    user_id uuid NOT NULL REFERENCES sso_user(user_id),
    birth_date date,
    sex gender_type,
    title text,
    first_name text,
    last_name text,
    avatar text,
    age int,
    address text,
    date_created timestamp DEFAULT now(),
    date_modified timestamp DEFAULT now(),
);

CREATE TABLE IF NOT EXISTS sso_role (
    role_id uuid DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    role_name text NOT NULL,
    role_description text,
    organization_id int NOT NULL,
);

CREATE TABLE IF NOT EXISTS sso_organization_user (
    organization_id int REFERENCES sso_user(user_id),
    user_id uuid REFERENCES sso_organization(organization_id),
    CONSTRAINT sso_organization_user_pk PRIMARY KEY (organization_id, user_id),
);

CREATE TABLE IF NOT EXISTS sso_user_role (
    user_id uuid REFERENCES sso_role(role_id),
    role_id uuid REFERENCES sso_user(user_id),
    CONSTRAINT sso_user_role_pk PRIMARY KEY(user_id, role_id),
);