INSERT INTO sso_organization (organization_id, organization_name, kvp, status, address, contact_number, email, country, state, city, postal_code, website_url)
VALUES 
(1, 'org 1', '{"key": "value"}', 'active', '82 Duy Tan', '123-456-7890', 'info@example.com', 'Vietnam', 'Hanoi', 'Hanoi', '100000', 'http://example.com'),
(2, 'org 2', '{"key": "value"}', 'active', '83 Duy Tan', '987-654-3210', 'contact@example.com', 'Vietnam', 'Ho Chi Minh', 'Ho Chi Minh City', '700000', 'http://example.org');

INSERT INTO sso_role (role_id, role_name, role_description, organization_id)
VALUES 
(uuid_generate_v4(), 'admin', 'admin', (SELECT organization_id FROM sso_organization LIMIT 1)),
(uuid_generate_v4(), 'user', 'user', (SELECT organization_id FROM sso_organization LIMIT 1)),
(uuid_generate_v4(), 'super-admin', 'super admin', (SELECT organization_id FROM sso_organization OFFSET 1 LIMIT 1));

INSERT INTO sso_user (user_id, username, password, email, kvp, modified_by, last_logged_in, user_settings, status)
VALUES 
(uuid_generate_v4(), 'admin_user', 'admin_password', 'admin@example.com', '{"key": "value"}', NULL, NULL, '{}', 'active'),
(uuid_generate_v4(), 'super_admin_user', 'user_password', 'user1@example.com', '{"key": "value"}', NULL, NULL, '{}', 'active'),
(uuid_generate_v4(), 'user', 'user_password', 'user2@example.com', '{"key": "value"}', NULL, NULL, '{}', 'active');

INSERT INTO sso_user_profile (profile_id, user_id, birth_date, sex, title, first_name, last_name, avatar, age, address)
VALUES 
('6474cefb-6c2e-4a57-9ed3-12cfbd724aaa', (SELECT user_id FROM sso_user WHERE username = 'admin_user'), '1990-01-01', 'male', 'Mr.', 'Admin', 'User', 'url', 33, '87 PD'),
('f5cb458e-dbbc-414a-8c5d-7a9393829e0c', (SELECT user_id FROM sso_user WHERE username = 'super_admin_user'), '1985-05-15', 'female', 'Ms.', 'User', 'User', 'url', 38, '87 PD'),
('cb7acc9e-8ade-4848-9292-eaa5945280a6', (SELECT user_id FROM sso_user WHERE username = 'user'), '1992-08-20', 'male', 'Mr.', 'User', 'User', 'url', 31, '87 PD');

INSERT INTO sso_organization_user (organization_id, user_id)
VALUES 
((SELECT organization_id FROM sso_organization LIMIT 1), (SELECT user_id FROM sso_user WHERE username = 'admin_user')),
((SELECT organization_id FROM sso_organization LIMIT 1), (SELECT user_id FROM sso_user WHERE username = 'super_admin_user')),
((SELECT organization_id FROM sso_organization OFFSET 1 LIMIT 1), (SELECT user_id FROM sso_user WHERE username = 'user'));

INSERT INTO sso_user_role (user_id, role_id)
VALUES 
((SELECT user_id FROM sso_user WHERE username = 'admin_user'), (SELECT role_id FROM sso_role WHERE role_name = 'admin')),
((SELECT user_id FROM sso_user WHERE username = 'super_admin_user'), (SELECT role_id FROM sso_role WHERE role_name = 'user')),
((SELECT user_id FROM sso_user WHERE username = 'user'), (SELECT role_id FROM sso_role WHERE role_name = 'super-admin'));

