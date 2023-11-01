-- Database: admindb

-- DROP DATABASE IF EXISTS admindb;

CREATE TYPE sex AS ENUM ('female', 'male');
CREATE TYPE status AS ENUM ('active', 'deactived', 'deleted');

DROP TABLE IF EXISTS sso_organization;
CREATE TABLE sso_organization (
	organization_id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	organization_name TEXT,
	kvp json,
	date_created TIMESTAMP,
	date_modified TIMESTAMP,
	status status DEFAULT 'active' NOT NULL,
	address TEXT,
	contact_number TEXT,
	email TEXT,
	country TEXT,
	city TEXT,
	postal_code TEXT,
	organization_sub_name TEXT,
	website_url TEXT
);

DROP TABLE IF EXISTS sso_role;
CREATE TABLE  sso_role(
	role_id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
	role_name TEXT,
	rele_description TEXT,
	organization_id INT NOT NULL,
	CONSTRAINT fk_organization FOREIGN KEY(organization_id) REFERENCES sso_organization(organization_id)
	
);
DROP TABLE IF EXISTS sso_user;
CREATE TABLE sso_user(
	user_id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	password TEXT,
	email TEXT,
	kvp json,
	date_created TIMESTAMP,
	date_modified TIMESTAMP,
	modified_by uuid,
	last_logged_in TIMESTAMP,
	user_settings jsonb DEFAULT '{}'::jsonb,
	status status DEFAULT 'active'
	
);

DROP TABLE IF EXISTS sso_user_profile;
CREATE TABLE sso_user_profile (
	profile_id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
	user_id INT,
	birth_date DATE,
	sex sex,
	title TEXT,
	fristname TEXT NOT NULL,
	lastname TEXT NOT NULL,
	avatar TEXT,
	age INT,
	address TEXT,
	date_created TIMESTAMP,
	CONSTRAINT fk_user FOREIGN KEY(user_id) REFERENCES sso_user(user_id)
);



DROP TABLE IF EXISTS sso_organization_user;
CREATE TABLE sso_organization_user(
	organization_id INT,
	user_id INT,
	PRIMARY KEY (organization_id, user_id),
  	CONSTRAINT fk_organization_id FOREIGN KEY(organization_id) REFERENCES sso_organization(organization_id),
  	CONSTRAINT fk_user_id FOREIGN KEY(user_id) REFERENCES sso_user(user_id)
);
DROP TABLE IF EXISTS sso_user_role;
CREATE TABLE sso_user_role(
	user_id INT,
	role_id uuid,
	PRIMARY KEY (user_id, role_id),
  	CONSTRAINT fk_role_id FOREIGN KEY(role_id) REFERENCES sso_role(role_id),
	CONSTRAINT fk_user_id FOREIGN KEY(user_id) REFERENCES sso_user(user_id)
);

	
