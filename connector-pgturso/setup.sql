CREATE EXTENSION pg_turso CASCADE;

CREATE TABLE IF NOT EXISTS menu(
   dish_id int PRIMARY KEY,
   name text,
   price float
);

CREATE MATERIALIZED VIEW assorted_collection_of_dirt_cheap_dishes AS SELECT dish_id, name FROM menu WHERE price <= 2.99;

INSERT INTO menu VALUES (1, 'salami', 2.49);
INSERT INTO menu VALUES (2, 'pastrami', 4.99);
INSERT INTO menu VALUES (3, 'wasabi', 1.99);

CREATE OR REPLACE FUNCTION turso_token() RETURNS text LANGUAGE SQL AS $$ SELECT 'secret-token'; $$;

CREATE OR REPLACE FUNCTION turso_url() RETURNS text LANGUAGE SQL AS $$ SELECT 'https://database-username.turso.io/'; $$;

SELECT turso_schedule_mv_replication('assorted_collection_of_dirt_cheap_dishes', '30 seconds');