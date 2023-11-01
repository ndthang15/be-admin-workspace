INSERT INTO public.sso_user (user_id, user_name, password, email, date_created)
	VALUES (1, 'CUONG', 'Seta@123', 'cuong@example.com', CURRENT_TIMESTAMP), (2, 'NAM', 'CMC@123', 'nam@example.com', CURRENT_TIMESTAMP);

INSERT INTO public.sso_user_profile (profile_id, birth_date, sex, first_name, last_name)
	VALUES (1, '1995-10-31', 'male', 'CUONG', 'NGUYEN'), (2, '1995-05-01', 'female', 'NAM', 'HOANG');

INSERT INTO public.sso_organization (organization_id, organization_name, date_created)
	VALUES (1, 'SETA', CURRENT_TIMESTAMP), (2, 'CMC', CURRENT_TIMESTAMP);

INSERT INTO public.sso_role (role_id, role_name, role_description, organization_id)
	VALUES (1, 'ADMIN', 'ADMIN', 1), (2, 'DEV', 'DEV', 1);

INSERT INTO public.user_organization_relation (user_id, organization_id)
	VALUES (1, 1), (1, 2), (2, 2);

INSERT INTO public.user_role_relation (user_id, role_id)
	VALUES (1, 1), (2, 2);