
This repository contains a simple operational PostgreSQL database system designed for managing fitness club memberships, client profiles (1:1 relationship), classes, instructors (1:many), and member bookings (many:many).

The project implements user access control, views, indexes optimization tested on 500,000+ records, stored procedures, and capacity validation triggers.

`create_tables.sql` — Schema definition, constraints, and data generation script (510,000+ records).
`create_view.sql` — View for classes and total bookings schedule tracking.
`create_user.sql` — Database user management and roles allocation (Admin, Coach, Reception).
`logic_and_triggers.sql` — Advanced PL/pgSQL business logic (booking cancellation and capacity trigger).
`explain_analyze.txt` — Performance query analysis before and after indexes.
