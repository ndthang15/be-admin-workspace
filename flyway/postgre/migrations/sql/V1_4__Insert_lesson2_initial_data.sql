INSERT INTO sso_organization (
		organization_name,
		kvp,
		date_created,
		date_modified,
		address,
		contact_number,
		email,
		country,
		state,
		city,
		postal_code,
		organization_sub_name,
		website_url
	)
VALUES (
		'XYZ Corporation',
		'{"industry": "Technology", "employees": 750}',
		NOW(),
		NOW(),
		'456 Elm St',
		'555-1234',
		'info@xyzcorp.com',
		'USA',
		'California',
		'Los Angeles',
		'90001',
		'XYZ West',
		'https://www.xyzcorp.com'
	),
	(
		'ABC Ltd.',
		'{"industry": "Finance", "employees": 200}',
		NOW(),
		NOW(),
		'789 Oak Ave',
		'555-5678',
		'info@abcltd.com',
		'USA',
		'New York',
		'New York City',
		'10001',
		'ABC East',
		'https://www.abcltd.com'
	);
INSERT INTO sso_role (role_name, role_description, organization_id)
VALUES (
		'Administrator',
		'Full access to all features',
		2
	),
	('Manager', 'Access to manage users and roles', 2),
	(
		'Employee',
		'Basic access to view and edit own profile',
		2
	);
INSERT INTO sso_user (
		user_name,
		password,
		email,
		kvp,
		date_created,
		date_modified,
		modified_by,
		last_logged_in,
		user_settings,
		status
	)
VALUES (
		'user123',
		'pass456',
		'user123@example.com',
		'{"role": "admin"}',
		NOW(),
		NOW(),
		NULL,
		NOW(),
		'{"theme": "dark"}',
		'active'
	),
	(
		'user456',
		'pass789',
		'user456@example.com',
		'{"role": "user"}',
		NOW(),
		NOW(),
		NULL,
		NOW(),
		'{"theme": "light"}',
		'active'
	);
INSERT INTO sso_user_organization (organization_id, user_id)
VALUES (2, 1),
	(3, 2);
INSERT INTO sso_user_role (user_id, role_id)
VALUES (1, 'c5089b76-92e5-42f0-81a3-1317322ad372'),
	(1, 'ce40b375-f4de-4df8-9848-721573b39ff2');
INSERT INTO sso_user_profile (
		user_id,
		birth_date,
		sex,
		title,
		firstname,
		lastname,
		avatar,
		age,
		address,
		date_created
	)
VALUES (
		1,
		'1988-07-15',
		'male',
		'Mr.',
		'John',
		'Doe',
		'https://example.com/johndoe.jpg',
		35,
		'456 Elm St, Los Angeles, California, USA',
		NOW()
	),
	(
		2,
		'1992-03-20',
		'female',
		'Ms.',
		'Jane',
		'Smith',
		'https://example.com/janesmith.jpg',
		29,
		'789 Oak Ave, New York City, New York, USA',
		NOW()
	);