CREATE DATABASE users_database;

-- DB table
CREATE TABLE users(
    user_id serial PRIMARY KEY,
    username character varying not null,
    password character varying not null
);

CREATE EXTENSION postgres_fdw;

/* SHARD 1 */
CREATE SERVER shard_server_1
    FOREIGN DATA WRAPPER postgres_fdw
    OPTIONS (host 'users_shard1', port '5432', dbname 'shard_database_1');

CREATE USER MAPPING FOR "balanetskiyvv"
    SERVER shard_server_1
    OPTIONS (user 'balanetskiyvv', password 'vasiliy');

CREATE FOREIGN TABLE public.users_shard_1(
    user_id int not null,
    username character varying not null
) SERVER shard_server_1
  OPTIONS (schema_name 'public', table_name 'users_shard1');

/* SHARD 2 */
CREATE SERVER shard_server_2
    FOREIGN DATA WRAPPER postgres_fdw
    OPTIONS (host 'users_shard2', port '5432', dbname 'shard_database_2');

CREATE USER MAPPING FOR "balanetskiyvv"
    SERVER shard_server_2
    OPTIONS (user 'balanetskiyvv', password 'vasiliy');

CREATE FOREIGN TABLE public.users_shard_2(
    user_id int not null,
    password character varying not null
) SERVER shard_server_2
  OPTIONS (schema_name 'public', table_name 'users_shard2');

-- Вьюха, функция и триггер
CREATE VIEW users_view AS
SELECT u1.user_id, u1.username, u2.password
FROM public.users_shard_1 u1
JOIN public.users_shard_2 u2 ON u1.user_id=u2.user_id;

CREATE OR REPLACE FUNCTION distribute_user()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO public.users_shard_1(user_id, username) VALUES (NEW.user_id, NEW.username);
    INSERT INTO public.users_shard_2(user_id, password) VALUES (NEW.user_id, NEW.password);
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER distribute_user_trigger
    AFTER INSERT ON users_view
    FOR EACH ROW
    EXECUTE FUNCTION distribute_user();

-- Вставка данных в файле insert_data.sql

