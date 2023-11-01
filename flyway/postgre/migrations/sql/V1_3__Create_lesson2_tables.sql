CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

do $$
begin
	if not exists (select 1 from PG_TYPE where TYPNAME = 'organization_status_type') then
		create type organization_status_type
		as enum ('active', 'suspend', 'deleted');
	end if;
	if not exists (select 1 from PG_TYPE where TYPNAME = 'user_status_type') then
		create type user_status_type
		as enum ('active', 'deactivated', 'deleted');
	end if;
	if not exists (select 1 from PG_TYPE where TYPNAME = 'gender_type') then
		create type gender_type
		as enum ('male', 'female');
	end if;
end $$;

CREATE TABLE IF NOT EXISTS sso_organization (
    organization_id SERIAL NOT NULL,
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
    
    constraint sso_organization_pk primary key (organization_id)
);

CREATE TABLE IF NOT EXISTS sso_role (
    role_id uuid NOT NULL,
    role_name VARCHAR(255) NOT NULL,
    role_description VARCHAR(255),
    organization_id INT,
    
    constraint sso_role_pk primary key (role_id),
    constraint sso_role_fk foreign key (organization_id) references sso_organization(organization_id)
);

CREATE TABLE IF NOT EXISTS sso_user (
    user_id UUID NOT NULL,
    username VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    kvp JSONB,
    date_created TIMESTAMPTZ DEFAULT now(),
    date_modified TIMESTAMPTZ DEFAULT now(),
    modified_by UUID,
    last_logged_in TIMESTAMPTZ,
    user_settings JSONB DEFAULT '{}' :: JSONB,
    status user_status_type DEFAULT 'active' :: user_status_type,
    
    constraint sso_user_pk primary key (user_id)
);

CREATE TABLE IF NOT EXISTS sso_user_profile (
    profile_id UUID not NULL,
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
    
    constraint sso_user_profile_pk primary key (profile_id),
    constraint sso_user_profile_fk foreign key (user_id) references sso_user(user_id)
);

CREATE TABLE IF NOT EXISTS sso_organization_user (
    organization_id BIGINT,
    user_id UUID,
    
    constraint sso_organization_user_pk primary key (organization_id, user_id),
    constraint sso_organization_user_fk1 FOREIGN KEY (organization_id) REFERENCES sso_organization(organization_id),
    constraint sso_organization_user_fk2 FOREIGN KEY (user_id) REFERENCES sso_user(user_id)
);

CREATE TABLE IF NOT EXISTS sso_user_role (
    user_id UUID,
    role_id UUID,
    
    constraint sso_user_role_pk PRIMARY KEY (user_id, role_id),
    constraint sso_user_role_fk1 FOREIGN KEY (user_id) REFERENCES sso_user(user_id),
    constraint sso_user_role_fk2 FOREIGN KEY (role_id) REFERENCES sso_role(role_id)
);