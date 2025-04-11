CREATE EXTENSION postgres_fdw;

/* SHARD 1 */
CREATE SERVER users_1_server
    FOREIGN DATA WRAPPER postgres_fdw
    OPTIONS (host 'postgres_users1', port '5432', dbname 'users');

CREATE USER MAPPING FOR "balanetskiyvv"
    SERVER users_1_server
    OPTIONS (user 'balanetskiyvv', password 'vasiliy');

CREATE FOREIGN TABLE users_common
(
    user_id int not null,
    name character varying not null,
    email character varying not null
) SERVER users_1_server
  OPTIONS (schema_name 'public', table_name 'users');


/* SHARD 2 */
CREATE SERVER users_2_server
    FOREIGN DATA WRAPPER postgres_fdw
    OPTIONS (host 'postgres_users2', port '5432', dbname 'users');

CREATE USER MAPPING FOR "balanetskiyvv"
    SERVER users_2_server
    OPTIONS (user 'balanetskiyvv', password 'vasiliy');

CREATE FOREIGN TABLE users_details
(
    user_id int not null,
    address character varying not null,
    phone_number character varying not null
) SERVER users_2_server
  OPTIONS (schema_name 'public', table_name 'users');

CREATE VIEW users AS
SELECT *
FROM users_common
UNION ALL
SELECT *
FROM users_details;

CREATE RULE users_insert AS ON INSERT TO users
    DO INSTEAD NOTHING;
CREATE RULE users_update AS ON UPDATE TO users
    DO INSTEAD NOTHING;
CREATE RULE users_delete AS ON DELETE TO users
    DO INSTEAD NOTHING;
