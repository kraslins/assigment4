DROP TABLE IF EXISTS bookings CASCADE;
drop table if exists client_profiles cascade;
DROP TABLE IF EXISTS classes CASCADE;
drop table if exists instructors cascade;
DROP TABLE IF EXISTS clients CASCADE;
drop table if exists types cascade;

CREATE TABLE types (
    type_id SERIAL PRIMARY KEY,
    name varchar(50) not null,
    price decimal(10,2) NOT NULL,
    days int NOT NULL
);

create table clients (
    client_id serial primary key,
    type_id int references types(type_id),
    f_name varchar(100) not null,
    email varchar(100) not null,
    phone varchar(20),
    join_date date not null
);

CREATE TABLE client_profiles (
    client_id INT PRIMARY KEY REFERENCES clients(client_id),
    weight decimal(5,2),
    height int,
    note varchar(255)
);

create table instructors (
    instructor_id serial primary key,
    name varchar(100) not null,
    spec varchar(50)
);

CREATE TABLE classes (
    class_id serial primary key,
    instructor_id int references instructors(instructor_id),
    name varchar(100) not null,
    c_time timestamp not null,
    max_people int not null
);

create table bookings (
    booking_id serial primary key,
    client_id int references clients(client_id),
    class_id int references classes(class_id),
    b_date timestamp default current_timestamp,
    status varchar(20) not null
);

INSERT INTO types (name, price, days) VALUES 
('Base', 1200.00, 30), 
('Pro', 3200.00, 90), 
('VIP', 11000.00, 365);

insert into clients (type_id, f_name, email, phone, join_date)
select 
    floor(1 + random() * 3)::int,
    'User_' || i,
    'user' || i || '@mail.com',
    '+380' || floor(100000000 + random() * 899999999)::bigint,
    '2026-01-01'::date + floor(random() * 100)::int
FROM generate_series(1, 15000) as i;

INSERT INTO client_profiles (client_id, weight, height, note)
SELECT 
    i,
    55 + floor(random() * 40)::decimal,
    160 + floor(random() * 30)::int,
    case floor(random() * 2)::int
        when 0 then 'no notes'
        else 'cardio'
    end
from generate_series(1, 15000) as i;

insert into instructors (name, spec) values
('Ivanov', 'Yoga'),
('Kovalenko', 'Crossfit'),
('Petrenko', 'Gym');

INSERT INTO classes (instructor_id, name, c_time, max_people)
SELECT 
    floor(1 + random() * 3)::int,
    CASE floor(random() * 3)::int
        WHEN 0 THEN 'Yoga morning'
        WHEN 1 THEN 'Crossfit hard'
        ELSE 'Gym training'
    END,
    timestamp '2026-01-01 09:00:00' + random() * (interval '150 days'),
    20
from generate_series(1, 500) as i;

insert into bookings (client_id, class_id, b_date, status)
select 
    floor(1 + random() * 15000)::int,
    floor(1 + random() * 500)::int,
    timestamp '2026-01-01 00:00:00' + random() * (interval '150 days'),
    case floor(random() * 4)::int
        when 0 then 'cancelled'
        else 'confirmed'
    end
from generate_series(1, 520000) as i;
