CREATE DATABASE shard_database_1;

CREATE TABLE users_shard1
(
    user_id int PRIMARY KEY,
    username character varying not null
);
