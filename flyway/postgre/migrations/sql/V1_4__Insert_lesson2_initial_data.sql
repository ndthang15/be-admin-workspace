-- Insert data into sso_organization table
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
		'Tech Innovators Inc.',
		'{"industry": "Technology", "employees": 1200}',
		NOW(),
		NOW(),
		'567 Tech Ave',
		'555-4321',
		'mailto:info@techinnovators.com',
		'USA',
		'California',
		'San Francisco',
		'94101',
		'Tech Innovators West',
		'https://www.techinnovators.com'
	);

-- Insert data into sso_role table
INSERT INTO sso_role (
		role_name,
		role_description,
		organization_id
	)
VALUES (
		'Administrator',
		'Full access to all features',
		2
	);

-- Insert data into sso_user table
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
		'mark_johnson',
		'p@ssw0rd456',
		'mailto:mark_johnson@example.com',
		'{"role": "admin"}',
		NOW(),
		NOW(),
		null,
		NOW(),
		'{"theme": "light"}',
		'active'
	);

-- Insert data into sso_user_organization table
INSERT INTO sso_user_organization (organization_id, user_id)
VALUES (2, 1);

-- Insert data into sso_user_role table
INSERT INTO sso_user_role (user_id, role_id)
VALUES (1, 'ce40b375-f4de-4df8-9848-721573b39ff2');

-- Insert data into sso_user_profile table for Mark Johnson
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
		'1985-07-15',
		'male',
		'Mr.',
		'Mark',
		'Johnson',
		'https://example.com/mark_avatar.jpg',
		38,
		'567 Tech Ave, San Francisco, California, USA',
		NOW()
	);