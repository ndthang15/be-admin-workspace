INSERT INTO sso_organization (organization_id, organization_name, kvp, status, address, contact_number, email, country, state, city, postal_code, website_url)
VALUES 
(1, 'org id 1', '{"key": "value"}', 'active', '123 Street', '012345678', 'a@example.com', 'Vietnam', 'Hanoi', 'Hanoi', '100000', 'http://test.com'),
(2, 'org id 2', '{"key": "value"}', 'suspended', '456 Street', '0123456789', 'b@example.com', 'America', 'Los Angeles', 'Los AngelesCity', '700000', 'http://test1.com');

INSERT INTO sso_role (role_id, role_name, role_description, organization_id)
VALUES 
(uuid_generate_v4(), 'Admin', 'admin', (SELECT organization_id FROM sso_organization LIMIT 1)),
(uuid_generate_v4(), 'User', 'user', (SELECT organization_id FROM sso_organization LIMIT 1)),
(uuid_generate_v4(), 'Manage', 'manage', (SELECT organization_id FROM sso_organization OFFSET 1 LIMIT 1));

INSERT INTO sso_user (user_id, username, password, email, kvp, modified_by, last_logged_in, user_settings, status)
VALUES 
(uuid_generate_v4(), 'Bob', 'admin_password', 'admin@example.com', '{"key": "value"}', NULL, NULL, '{}', 'active'),
(uuid_generate_v4(), 'Minh', 'user_password', 'superadmin@example.com', '{"key": "value"}', NULL, NULL, '{}', 'active'),
(uuid_generate_v4(), 'David', 'user_password', 'user2@example.com', '{"key": "value"}', NULL, NULL, '{}', 'active');

INSERT INTO sso_user_profile (profile_id, user_id, birth_date, sex, title, first_name, last_name, avatar, age, address)
VALUES 
(uuid_generate_v4(), (SELECT user_id FROM sso_user WHERE username = 'Bob'), '1997-13-01', 'male', 'Mr.', 'Admin', 'User', 'avatar_url1', 33, '123 Test St'),
(uuid_generate_v4(), (SELECT user_id FROM sso_user WHERE username = 'Minh'), '1992-06-24', 'male', 'Mr.', 'User', 'One', 'avatar_url2', 38, '456 Test St'),
(uuid_generate_v4(), (SELECT user_id FROM sso_user WHERE username = 'David'), '1995-08-21', 'male', 'Mr.', 'User', 'Two', 'avatar_url3', 31, '789 Test St');


INSERT INTO sso_organization_user (organization_id, user_id)
VALUES 
((SELECT organization_id FROM sso_organization LIMIT 1), (SELECT user_id FROM sso_user WHERE username = 'Bob')),
((SELECT organization_id FROM sso_organization LIMIT 1), (SELECT user_id FROM sso_user WHERE username = 'Minh')),
((SELECT organization_id FROM sso_organization OFFSET 1 LIMIT 1), (SELECT user_id FROM sso_user WHERE username = 'David'));

INSERT INTO sso_user_role (user_id, role_id)
VALUES 
((SELECT user_id FROM sso_user WHERE username = 'Bob'), (SELECT role_id FROM sso_role WHERE role_name = 'Admin')),
((SELECT user_id FROM sso_user WHERE username = 'Minh'), (SELECT role_id FROM sso_role WHERE role_name = 'User')),
((SELECT user_id FROM sso_user WHERE username = 'David'), (SELECT role_id FROM sso_role WHERE role_name = 'Manage'));
