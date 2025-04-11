CREATE TABLE users_details
(
    user_id int not null,
    address character varying not null,
    phone_number character varying not null,
    CONSTRAINT pk_users_details primary key (user_id)
);