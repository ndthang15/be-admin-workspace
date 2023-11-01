-- Create new ENUM type
--
CREATE TYPE SEX_ENUM AS ENUM ('male', 'female');
CREATE TYPE USER_STATUS_ENUM AS ENUM ('active', 'deactivated', 'deleted');
CREATE TYPE ORGANIZATION_STATUS_ENUM AS ENUM ('active', 'suspended', 'deleted');

-- Allow generate UUID
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create table
--
CREATE TABLE IF NOT EXISTS sso_user_profile (
	profile_id UUID NOT NULL PRIMARY KEY,
	birth_date DATE,
	sex SEX_ENUM,
	title TEXT,
	firstname TEXT NOT NULL,
	lastname TEXT NOT NULL,
	avatar TEXT NOT NULL,
	age TEXT,
	address TEXT,
	date_created TIMESTAMP
);

CREATE TABLE IF NOT EXISTS sso_user (
	user_id INT NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	user_name TEXT NOT NULL,
	password TEXT NOT NULL,
	email TEXT,
	kvp JSON,
	date_created TIMESTAMP,
	date_modified TIMESTAMP,
	modified_by UUID,
	last_logged_in TIMESTAMP,
	user_settings JSON DEFAULT '{}'::json,
	status USER_STATUS_ENUM DEFAULT 'active'
);

CREATE TABLE IF NOT EXISTS sso_organization (
	organization_id INT NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	organization_name TEXT NOT NULL,
	kvp JSON,
	date_created TIMESTAMP,
	date_modified TIMESTAMP,
	status ORGANIZATION_STATUS_ENUM DEFAULT 'active',
	address TEXT,
	contact_number TEXT,
	email TEXT,
	state TEXT,
	city TEXT,
	postal_code TEXT,
	organization_sub_name TEXT,
	website_url TEXT
);

CREATE TABLE IF NOT EXISTS sso_role (
	role_id UUID NOT NULL PRIMARY KEY,
	role_name TEXT NOT NULL,
	role_description TEXT
);

-- Alter table
--
-- organization <-> role : 1-to-many
ALTER TABLE sso_role ADD COLUMN organization_id INT;
ALTER TABLE sso_role ADD CONSTRAINT fk_role_organization FOREIGN KEY (organization_id) REFERENCES sso_organization(organization_id);

-- organization <-> user : many-to-many
CREATE TABLE organization_user (
	userId INT REFERENCES sso_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE,
	organizationId INT REFERENCES sso_organization(organization_id) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT organization_user_pk PRIMARY KEY (userId, organizationId)
);

-- user <-> user profile : 1-to-many
ALTER TABLE sso_user_profile ADD COLUMN user_id INT;
ALTER TABLE sso_user_profile ADD CONSTRAINT fk_userprofile_user FOREIGN KEY (user_id) REFERENCES sso_user(user_id);

-- roles <-> user: many-to-many
CREATE TABLE role_user (
	roleId UUID REFERENCES sso_role(role_id) ON UPDATE CASCADE ON DELETE CASCADE,
	userId INT REFERENCES sso_user(user_id) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT role_user_pk PRIMARY KEY (roleId, userId)
);


