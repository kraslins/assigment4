drop user if exists fitness_admin;
drop user if exists fitness_coach;
drop user if exists fitness_reception;

create user fitness_admin with password 'admin_pass123';
grant all privileges on all tables in schema public to fitness_admin;

create user fitness_coach with password 'coach_pass456';
grant select on classes, instructors, bookings to fitness_coach;

create user fitness_reception with password 'recep_pass789';
grant select, insert, update on clients, bookings, client_profiles to fitness_reception;
