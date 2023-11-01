INSERT INTO sso_organization (organization_id, kvp, status, address, contact_number, email, country, state, city, postal_code, organization_sub_name, website_url)
VALUES 
(1, '{"key": "value"}', 'active', '82 Duy Tan', '123-456-7890', 'info@example.com', 'Vietnam', 'Hanoi', 'Hanoi', '100000', 'Sub Organization', 'http://example.com'),
(2, '{"key": "value"}', 'active', '83 Duy Tan', '987-654-3210', 'contact@example.com', 'Vietnam', 'Ho Chi Minh', 'Ho Chi Minh City', '700000', 'Another Sub Organization', 'http://example.org');

INSERT INTO sso_roles (role_id, role_description, organization_id, status)
VALUES 
(uuid_generate_v4(), 'Admin', (SELECT organization_id FROM sso_organization LIMIT 1), 'active'),
(uuid_generate_v4(), 'User', (SELECT organization_id FROM sso_organization LIMIT 1), 'active'),
(uuid_generate_v4(), 'Moderator', (SELECT organization_id FROM sso_organization OFFSET 1 LIMIT 1), 'active');

INSERT INTO sso_user (user_id, username, password, email, kvp, modified_by, last_logged_in, user_settings, status)
VALUES 
(uuid_generate_v4(), 'admin_user', 'admin_password', 'admin@example.com', '{"key": "value"}', NULL, NULL, '{"setting_key": "setting_value"}', 'active'),
(uuid_generate_v4(), 'user1', 'user_password', 'user1@example.com', '{"key": "value"}', NULL, NULL, '{"setting_key": "setting_value"}', 'active'),
(uuid_generate_v4(), 'user2', 'user_password', 'user2@example.com', '{"key": "value"}', NULL, NULL, '{"setting_key": "setting_value"}', 'active');

INSERT INTO sso_user_profile (profile_id, user_id, birth_date, sex, title, first_name, last_name, avatar, age, address)
VALUES 
(uuid_generate_v4(), (SELECT user_id FROM sso_user WHERE username = 'admin_user'), '1990-01-01', 'male', 'Mr.', 'Admin', 'User', 'avatar_url1', 33, '123 Main St'),
(uuid_generate_v4(), (SELECT user_id FROM sso_user WHERE username = 'user1'), '1985-05-15', 'female', 'Ms.', 'User', 'One', 'avatar_url2', 38, '456 Elm St'),
(uuid_generate_v4(), (SELECT user_id FROM sso_user WHERE username = 'user2'), '1992-08-20', 'male', 'Mr.', 'User', 'Two', 'avatar_url3', 31, '789 Oak St');

INSERT INTO sso_organization_user (organization_id, user_id)
VALUES 
((SELECT organization_id FROM sso_organization LIMIT 1), (SELECT user_id FROM sso_user WHERE username = 'admin_user')),
((SELECT organization_id FROM sso_organization LIMIT 1), (SELECT user_id FROM sso_user WHERE username = 'user1')),
((SELECT organization_id FROM sso_organization OFFSET 1 LIMIT 1), (SELECT user_id FROM sso_user WHERE username = 'user2'));

INSERT INTO sso_user_roles (user_id, role_id)
VALUES 
((SELECT user_id FROM sso_user WHERE username = 'admin_user'), (SELECT role_id FROM sso_roles WHERE role_description = 'Admin')),
((SELECT user_id FROM sso_user WHERE username = 'user1'), (SELECT role_id FROM sso_roles WHERE role_description = 'User')),
((SELECT user_id FROM sso_user WHERE username = 'user2'), (SELECT role_id FROM sso_roles WHERE role_description = 'Moderator'));
