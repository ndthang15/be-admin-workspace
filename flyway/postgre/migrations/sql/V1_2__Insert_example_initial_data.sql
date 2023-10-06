-- users
INSERT INTO public.test_table (full_name,region,email,created_date)
	VALUES ('Hoc sinh lop 1 A','mien bac','1a@abc.com', CURRENT_TIMESTAMP);
INSERT INTO public.test_table (full_name,region,email,created_date)
	VALUES ('Hoc sinh lop 1 B','mien bac','1b@abc.com',CURRENT_TIMESTAMP);
INSERT INTO public.test_table (full_name,region,email,created_date)
	VALUES ('Hoc sinh lop 2 A','mien nam','2a@abc.com',CURRENT_TIMESTAMP);
INSERT INTO public.test_table (full_name,region,email,created_date)
	VALUES ('Hoc sinh lop 2 B','mien nam','2b@abc.com',CURRENT_TIMESTAMP);
INSERT INTO public.test_table (full_name,region,email,created_date)
	VALUES ('Hoc sinh lop 2 C','mien bac','2c@abc.com',CURRENT_TIMESTAMP);
INSERT INTO public.test_table (full_name,region,email, test_table_type,created_date)
	VALUES ('Giao vien A','mien bac','teacherA@abc.com', 'type2',CURRENT_TIMESTAMP);
INSERT INTO public.test_table (full_name,region,email, test_table_type,created_date)
	VALUES ('Giao vien B','mien bac','teacherB@abc.com', 'type3',CURRENT_TIMESTAMP);
INSERT INTO public.test_table (full_name,region,email, test_table_type,created_date)
	VALUES ('Giao vien C','mien bac','teacherC@abc.com', 'type2',CURRENT_TIMESTAMP);
INSERT INTO public.test_table (full_name,region,email, test_table_type, created_date)
	VALUES ('Admin A','mien bac','adminA@abc.com', 'type3',CURRENT_TIMESTAMP);