INSERT INTO sso_organization (organization_id, organization_name, kvp, status, address, contact_number, email, country, state, city, postal_code, organization_sub_name, website_url)
VALUES 
(1, 'TEST 1', '{"key": "value 1"}', 'active', 'active 1', '123456789', 'test@example.com', 'Vietnam', 'Hanoi', 'Hanoi', '100000', 'Sub Organization 1', 'http://example.com'),
(2, 'TEST 2', '{"key": "value 2"}', 'active', 'active 1', '123456789', 'test@example.com', 'Vietnam', 'Ho Chi Minh', 'Ho Chi Minh City', '700000', 'Sub Organization 2', 'http://example.org');

INSERT INTO sso_roles (role_id, role_name, role_description, organization_id, status)
VALUES 
(uuid_generate_v4(), 'role_name_1', 'role_description', 1, 'active'),
(uuid_generate_v4(), 'role_name_2', 'role_description', 2, 'active'),


INSERT INTO sso_user (user_id, username, password, email, kvp, modified_by, last_logged_in, user_settings, status)
VALUES 
(uuid_generate_v4(), 'user_1', 'password1', 'user1@example.com', '{"key": "value1"}', NULL, NULL, '{"setting_key": "value1"}', 'active'),
(uuid_generate_v4(), 'user_2', 'password1', 'user2@example.com', '{"key": "value2"}', NULL, NULL, '{"setting_key": "value2"}', 'active'),

INSERT INTO sso_user_profile (profile_id, user_id, birth_date, sex, title, first_name, last_name, avatar, age, address)
VALUES 
(uuid_generate_v4(), (SELECT user_id FROM sso_user WHERE username = 'user_1'), '1990-01-01', 'first_name_1', 'last_name_1', 'Admin', 'User', 'avatar_1', 100, 'address1'),
(uuid_generate_v4(), (SELECT user_id FROM sso_user WHERE username = 'user_2'), '1985-05-15', 'first_name_2', 'last_name_2', 'User', 'One', 'avatar_2', 100, 'address2'),

INSERT INTO sso_organization_user (organization_id, user_id)
VALUES 
(1, (SELECT user_id FROM sso_user WHERE username = 'user_1')),
(2, (SELECT user_id FROM sso_user WHERE username = 'user_2')),

INSERT INTO sso_user_roles (user_id, role_id)
VALUES 
((SELECT user_id FROM sso_user WHERE username = 'user_1'), (SELECT role_id FROM sso_roles WHERE role_name = 'role_name_1')),
((SELECT user_id FROM sso_user WHERE username = 'user_2'), (SELECT role_id FROM sso_roles WHERE role_name = 'role_name_2')),