CREATE DATABASE shard_database_2;

CREATE TABLE users_shard2
(
    user_id int PRIMARY KEY,
    password character varying not null
);
