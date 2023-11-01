INSERT INTO sso_organization ( organization_name, kvp, status, address, contact_number, email, country, state, city, postal_code, website_url)
VALUES
('org id 1', '{"key": "value"}', 'active', '123 Street', '012345678', 'a@example.com', 'Vietnam', 'Hanoi', 'Hanoi', '100000', 'http://test.com'),
('org id 2', '{"key": "value"}', 'suspended', '456 Street', '0123456789', 'b@example.com', 'America', 'Los Angeles', 'Los AngelesCity', '700000', 'http://test1.com');

INSERT INTO sso_role (role_id, role_name, role_description, organization_id)
VALUES
(uuid_generate_v4(), 'Admin', 'admin', (SELECT organization_id FROM sso_organization LIMIT 1)),
(uuid_generate_v4(), 'User', 'user', (SELECT organization_id FROM sso_organization LIMIT 1)),
(uuid_generate_v4(), 'Manage', 'manage', (SELECT organization_id FROM sso_organization OFFSET 1 LIMIT 1));

INSERT INTO sso_user ( user_name, password, email, kvp, modified_by, last_logged_in, user_settings, status)
VALUES
( 'Bob', 'admin_password', 'admin@example.com', '{"key": "value"}', NULL, NULL, '{}', 'active'),
( 'Minh', 'user_password', 'superadmin@example.com', '{"key": "value"}', NULL, NULL, '{}', 'active'),
( 'David', 'user_password', 'user2@example.com', '{"key": "value"}', NULL, NULL, '{}', 'active');

INSERT INTO sso_user_profile (profile_id, user_id, birth_date, sex, title, firstname, lastname, avatar, age, address)
VALUES
(uuid_generate_v4(), (SELECT user_id FROM sso_user WHERE user_id  = 1), '1997-01-13', 'male', 'Mr.', 'Admin', 'User', 'avatar_url1', 33, '123 Test St'),
(uuid_generate_v4(), (SELECT user_id FROM sso_user WHERE user_id = 2), '1992-06-24', 'male', 'Mr.', 'User', 'One', 'avatar_url2', 38, '456 Test St'),
(uuid_generate_v4(), (SELECT user_id FROM sso_user WHERE user_id = 3), '1995-08-21', 'male', 'Mr.', 'User', 'Two', 'avatar_url3', 31, '789 Test St');


INSERT INTO sso_organization_user (organization_id, user_id)
VALUES
((SELECT organization_id FROM sso_organization LIMIT 1), (SELECT user_id FROM sso_user WHERE user_id = 1)),
((SELECT organization_id FROM sso_organization LIMIT 1), (SELECT user_id FROM sso_user WHERE user_id = 2)),
((SELECT organization_id FROM sso_organization OFFSET 1 LIMIT 1), (SELECT user_id FROM sso_user WHERE user_id = 3));

INSERT INTO sso_role_user (user_id, role_id)
VALUES
((SELECT user_id FROM sso_user WHERE user_id = 1), (SELECT role_id FROM sso_role WHERE role_id = '20c8f6a7-d1db-4c82-8101-afdd44765da8')),
((SELECT user_id FROM sso_user WHERE user_id = 2), (SELECT role_id FROM sso_role WHERE role_id = '771a6dee-2d88-47ca-a928-599bae9b09b5')),
((SELECT user_id FROM sso_user WHERE user_id = 3), (SELECT role_id FROM sso_role WHERE role_id = '75076631-15cb-4bf9-b01c-09d587f8c060'));

