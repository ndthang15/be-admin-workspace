INSERT INTO sso_organization(organization_name,kvp,date_created,status,address,contact_number,email,country,city,postal_code,organization_sub_name,website_url)
	VALUES ('seta','{}','2023-10-10 11:30:30','active','Duy Tân, Cầu Giấy, VN','0123456789', 'seta-international@gmail.com','Việt Nam','Hà Nội','000084','seta','https://seta-international.com');
INSERT INTO sso_role(role_name,rele_description, organization_id) 
	VALUES ('member','member',1);
INSERT INTO sso_user(password,email,kvp,date_created, status)
	VALUES('password','hai@gmail.com','{}','2023-10-10 11:30:00', 'active');
INSERT INTO sso_user_profile (user_id,birth_date,sex,title, fristname, lastname, avatar,age,address, date_created) 
	VALUES(1,'1-3-2000','male','Hai','Hai','Nguyen','hai_nguyen',23,'Ha Noi','2023-10-10 11:30:00');
INSERT INTO sso_organization_user(organization_id,user_id)
	SELECT organization_id, user_id
	FROM sso_organization
	CROSS JOIN sso_user;
INSERT INTO sso_user_role(user_id, role_id) 
	SELECT user_id, role_id
	FROM sso_user
	CROSS JOIN sso_role;