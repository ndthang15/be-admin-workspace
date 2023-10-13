-- DROP TYPE IF EXISTS status_type;
CREATE TYPE status_type AS ENUM ('active', 'suspened', 'deleted');

-- DROP TYPE IF EXISTS gender_type;
CREATE TYPE gender_type AS ENUM ('male', 'female');

create table if not EXISTS sso_organization  (
    organization_id BIGINT not null generated always as identity primary KEY,
    organization_name text not null,
    kvp jsonb,
    date_created TIMESTAMP,
    date_modified TIMESTAMP,
    status status_type not null default 'active',
    address text,
    contact_number text,
    email text,
    country text,
    state text,
    city text,
    postal_code text,
    organization_sub_name text,
    website_url text
);

create table if not EXISTS sso_user  (
user_id BIGINT not null generated always as IDENTITY primary key,
user_name text not null,
password text not null,
kvp json,
date_created TIMESTAMP,
date_modified TIMESTAMP,
modified_by BIGINT,
last_logged_in TIMESTAMP,
user_setting json default '{}'::json,
status status_type default 'active'
);

create table if not EXISTS sso_role  (
 role_id BIGINT not null generated always as IDENTITY primary key, -- UUID
 role_name text not null,
 role_description text,
 organization_id BIGINT references sso_organization(organization_id),
 
);

create table if not EXISTS sso_user_profile  (
profile_id BIGINT not null generated always as IDENTITY primary key,
user_id bigint references sso_user(user_id),
birth_date date,
sex gender_type,
title text,
firstname text not null,
lastname text not null,
avatar text,
age_number int,
address text,
date_created TIMESTAMP
);


CREATE TABLE IF NOT EXISTS sso_profile_to_role (
profile_role_id BIGINT not null generated always as IDENTITY primary key,
profile_id BIGINT references sso_user_profile(profile_id),
role_id BIGINT references sso_role(role_id)
);