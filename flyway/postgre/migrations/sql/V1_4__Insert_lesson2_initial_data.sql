insert into sso_organization (organization_name, email, date_created, date_modified )
values ('Org 1','email1@.gmail.com', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

insert into sso_organization (organization_name, email, date_created, date_modified )
values ('Org 2','email2@.gmail.com', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

insert into sso_user (user_name, password, date_created, date_modified,last_logged_in )
values ('user_2','seta@123', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP,CURRENT_TIMESTAMP);

insert into sso_user (user_name, password, date_created, date_modified,last_logged_in )
values ('user_1','seta@123', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP,CURRENT_TIMESTAMP);


insert into sso_role ( role_name, organization_id )
values ('Admin Org 1',1);
insert into sso_role ( role_name, organization_id )
values ('Admin Org 2',2);
insert into sso_role ( role_name, organization_id )
values ('User Org 1',1);

insert into sso_user_profile ( user_id, firstname, lastname, date_created )
values (1,'User1', 'Profile 1 ',CURRENT_TIMESTAMP);
insert into sso_user_profile ( user_id, firstname, lastname, date_created )
values (1,'User1', 'Profile 2',CURRENT_TIMESTAMP);
insert into sso_user_profile ( user_id, firstname, lastname, date_created )
values (2,'User2', 'Profile 1 ',CURRENT_TIMESTAMP);
insert into sso_user_profile ( user_id, firstname, lastname, date_created )
values (2,'User2', 'Profile 2',CURRENT_TIMESTAMP);

insert into sso_profile_to_role ( profile_id, role_id)
values (1,1);
insert into sso_profile_to_role ( profile_id, role_id)
values (2,2);
insert into sso_profile_to_role ( profile_id, role_id)
values (3,3);