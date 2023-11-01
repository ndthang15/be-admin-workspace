CREATE TYPE enum AS ENUM ('active', 'suspend', 'deleted');
CREATE TYPE enum_org AS ENUM ('active', 'deactivated', 'deleted');
CREATE TYPE enum_sex AS ENUM ('male', 'female');
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE public.sso_organization (
	organization_id int4 NOT NULL GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE),
	organization_name text NOT NULL,
	date_created timestamp NULL,
	date_modified timestamp NULL,
	address text NULL,
	contact_number text NULL,
	email text NULL,
	country text NULL,
	state text NULL,
	city text NULL,
	postal_code text NULL,
	organization_sub_name text NULL,
	website_url text NULL,
	kvp json NULL,
	status public."enum_org" NOT NULL DEFAULT 'active'::enum_org,
	CONSTRAINT sso_organization_pk PRIMARY KEY (organization_id)
);

CREATE TABLE public.sso_organization_user (
	user_id int4 NULL,
	organization_id int4 NULL
);

-- public.sso_organization_user foreign keys
ALTER TABLE public.sso_organization_user ADD CONSTRAINT sso_org_user_fk FOREIGN KEY (user_id) REFERENCES public.sso_user(user_id);
ALTER TABLE public.sso_organization_user ADD CONSTRAINT sso_org_user_fk_1 FOREIGN KEY (organization_id) REFERENCES public.sso_organization(organization_id);

CREATE TABLE public.sso_role (
	role_id uuid NOT NULL,
	role_name text NOT NULL,
	role_description text NULL,
	organization_id int4 NULL,
	CONSTRAINT sso_role_pk PRIMARY KEY (role_id)
);

-- public.sso_role foreign keys
ALTER TABLE public.sso_role ADD CONSTRAINT sso_role_fk FOREIGN KEY (organization_id) REFERENCES public.sso_organization(organization_id);

CREATE TABLE public.sso_role_user (
	user_id int4 NULL,
	role_id uuid NULL
);

-- public.sso_role_user foreign keys
ALTER TABLE public.sso_role_user ADD CONSTRAINT sso_role_user_fk FOREIGN KEY (user_id) REFERENCES public.sso_user(user_id);
ALTER TABLE public.sso_role_user ADD CONSTRAINT sso_role_user_fk_1 FOREIGN KEY (role_id) REFERENCES public.sso_role(role_id);

CREATE TABLE public.sso_user (
	user_id int4 NOT NULL GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE),
	user_name text NOT NULL,
	"password" text NOT NULL,
	email text NULL,
	kvp json NULL,
	date_created timestamp NULL,
	date_modified timestamp NULL,
	modified_by uuid NULL,
	last_logged_in timestamp NULL,
	user_settings json NULL DEFAULT '{}'::json,
	status public."enum" NULL DEFAULT 'active'::enum,
	CONSTRAINT sso_user_pk PRIMARY KEY (user_id)
);

CREATE TABLE public.sso_user_profile (
	profile_id uuid NOT NULL,
	birth_date date NULL,
	title text NULL,
	firstname text NOT NULL,
	lastname text NOT NULL,
	avatar text NULL,
	age int4 NULL,
	address text NULL,
	date_created timestamp NULL,
	sex public."enum_sex" NULL,
	user_id int4 NULL,
	CONSTRAINT sso_user_profile_pk PRIMARY KEY (profile_id)
);

-- public.sso_user_profile foreign keys
ALTER TABLE public.sso_user_profile ADD CONSTRAINT sso_user_profile_fk FOREIGN KEY (user_id) REFERENCES public.sso_user(user_id);