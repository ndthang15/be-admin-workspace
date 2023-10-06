DROP TYPE IF EXISTS test_table_type;
CREATE TYPE test_table_type AS ENUM ('type1', 'type2', 'type3');

CREATE TABLE IF NOT EXISTS public."test_table"
(
    test_table_id bigint NOT NULL GENERATED ALWAYS AS identity,
    full_name text,
    region text,
    email text,
    phone_number text,
    image_preview_path text,
    test_table_type test_table_type not null default 'type1',
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT user_pk PRIMARY KEY (test_table_id)
);