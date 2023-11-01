create type type_status as enum ('active','deactived','deleted')

CREATE EXTENSION IF NOT EXISTS "uuid-ossp"


create table if not exists sso_user (
	user_id int generated always as identity not null,
	user_name text not null,
	password text not null,
	email text,
	kvp json,
	date_created timestamp,
	date_modified timestamp,
	modified_by uuid DEFAULT uuid_generate_v4 (),
	last_logged_in timestamp,
	user_settings json default '{}'::json,
	status type_status default 'active',
	primary key (user_id)
)

create table if not exists sso_organization (
	organization_id int generated always as identity not null,
	organization_name text not null,
	kvp json,
	date_created timestamp,
	date_modified timestamp,
	status type_status default 'active' not null,
	address text,
	contact_number text,
	email text,
	country text,
	state text,
	city text,
	postal_code text,
	organization_sub_name text,
	website_url text,
	primary key (organization_id)	
)

create table if not exists sso_role (
	role_id uuid DEFAULT uuid_generate_v4 (),
	role_name text not null,
	role_description text,
	organization_id int,
	primary key (role_id)
)

alter table sso_role 
add constraint fk_organization 
foreign key (organization_id)
references sso_organization(organization_id)

create table if not exists sso_user_organization (
	organization_id int not null,
	user_id int not null,
	constraint user_org primary key (organization_id,user_id),
	constraint fk_user foreign key (user_id) references sso_user(user_id),
	constraint fk_org foreign key (organization_id) references sso_organization(organization_id)
)

create table if not exists sso_user_role (
	user_id int not null,
	role_id uuid not null,
	constraint user_role primary key (user_id, role_id),
	constraint fk_user foreign key (user_id) references sso_user(user_id),
	constraint fk_role foreign key (role_id) references sso_role(role_id)
)

create type type_sex as enum ('male','female')

create table if not exists sso_user_profile (
	profile_id uuid default uuid_generate_v4 () not null,
	user_id int not null,
	birth_date date,
	sex type_sex,
	title text,
	firstname text not null,
	lastname text not null,
	avatar text,
	age int,
	address text,
	date_created timestamp,
	constraint fk_user_profiles foreign key (user_id) references sso_user(user_id)
)
