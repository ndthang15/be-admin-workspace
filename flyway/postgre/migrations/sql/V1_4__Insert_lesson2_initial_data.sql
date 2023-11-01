insert
	into
	sso_organization (
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
values (
  'Acme Inc.',
'{"industry": "Manufacturing", "employees": 500}',
NOW(),
NOW(),
'123 Main St',
'555-1234',
'info@acme.com',
'USA',
'California',
'Los Angeles',
'90001',
'Acme West',
'https://www.acme.com'
);

insert
	into
	sso_organization (
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
values (
  'Globex Corp.',
'{"industry": "Technology", "employees": 1000}',
NOW(),
NOW(),
'456 Oak Ave',
'555-5678',
'info@globex.com',
'USA',
'New York',
'New York City',
'10001',
'Globex East',
'https://www.globex.com'
);

insert
	into
	sso_role (
  role_name,
	role_description,
	organization_id
)
values (
  'Admin',
'Full access to all features',
2
);

insert
	into
	sso_role (
  role_name,
	role_description,
	organization_id
)
values (
  'Manager',
'Access to manage users and roles',
2
);

insert
	into
	sso_role (
  role_name,
	role_description,
	organization_id
)
values (
  'User',
'Basic access to view and edit own profile',
2
);

insert
	into
	sso_user (
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
values (
  'john_doe',
'password123',
'john_doe@example.com',
'{"role": "admin"}',
NOW(),
NOW(),
null,
NOW(),
'{"theme": "dark"}',
'active'
);

insert
	into
	sso_user (
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
values (
  'jane_doe',
'password456',
'jane_doe@example.com',
'{"role": "user"}',
NOW(),
NOW(),
null,
NOW(),
'{"theme": "light"}',
'active'
);

insert
	into
	sso_user_organization (
  organization_id,
	user_id
)
values (
  2,
1
);

insert
	into
	sso_user_organization (
  organization_id,
	user_id
)
values (
 3,
2
);

insert
	into
	sso_user_role (
	user_id,
	role_id
)
values (1,
'c5089b76-92e5-42f0-81a3-1317322ad372'),
(1,
'ce40b375-f4de-4df8-9848-721573b39ff2')

INSERT INTO sso_user_profile (
  user_id, birth_date, sex, title, firstname, lastname, avatar, age, address, date_created
) VALUES (
  1, '1990-01-01', 'male', 'Mr.', 'John', 'Doe', 'https://example.com/avatar.jpg', 31, '123 Main St, Los Angeles, California, USA', NOW()
);

INSERT INTO sso_user_profile (
  user_id, birth_date, sex, title, firstname, lastname, avatar, age, address, date_created
) VALUES (
  2, '1995-05-05', 'female', 'Ms.', 'Jane', 'Doe', 'https://example.com/avatar.jpg', 26, '456 Oak Ave, New York City, New York, USA', NOW()
);