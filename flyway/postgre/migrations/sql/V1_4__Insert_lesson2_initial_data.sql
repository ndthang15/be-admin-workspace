INSERT INTO sso_organization (organization_name, city, organization_sub_name) 
	VALUES ('SETA International', 'Hanoi', 'SETA');

INSERT INTO sso_user (user_name, password) 
	VALUES ('nhatminh', 'nhatminh');

INSERT INTO organization_user (userId, organizationId) 
    VALUES (1, 1);

INSERT INTO sso_user_profile (profile_id, firstname, lastname, avatar, birth_date, sex, user_id)
	VALUES (uuid_generate_v4(), 'Nhat Minh', 'Dang', 'avatar', '1997-07-12', 'male', 1);

INSERT INTO sso_role (role_id, role_name)
	VALUES (uuid_generate_v4(), 'admin');

INSERT INTO role_user (roleId, userId)
SELECT t1.role_id AS roleId, t2.user_id AS userId
FROM sso_role AS t1
CROSS JOIN sso_user AS t2;

INSERT INTO sso_role (role_id, role_name, organization_id)
	VALUES (uuid_generate_v4(), 'user', 1);