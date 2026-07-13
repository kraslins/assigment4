create or replace view v_class_schedule as
select 
    c.class_id,
    c.name as class_name,
    c.c_time,
    i.name as instructor_name,
    c.max_people,
    (select count(*) from bookings b where b.class_id = c.class_id and b.status = 'confirmed') as total_booked
from classes c
join instructors i on c.instructor_id = i.instructor_id;
