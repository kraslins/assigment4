create or replace procedure cancel_client_booking(p_booking_id int)
language plpgsql
as $$
declare
    v_exists int;
begin
    select count(*) into v_exists from bookings where booking_id = p_booking_id;
    if v_exists = 0 then
        raise notice 'booking not found';
        return;
    end if;

    update bookings 
    set status = 'cancelled' 
    where booking_id = p_booking_id;
end;
$$;

create or replace function trg_check_class_capacity()
returns trigger
language plpgsql
as $$
declare
    v_max int;
    v_current int;
begin
    select max_people into v_max from classes where class_id = new.class_id;
    select count(*) into v_current from bookings where class_id = new.class_id and status = 'confirmed';
    
    if new.status = 'confirmed' and v_current >= v_max then
        raise exception 'class capacity is full';
    end if;
    
    return new;
end;
$$;

drop trigger if exists trg_bookings_before_insert on bookings;

create trigger trg_bookings_before_insert
before insert on bookings
for each row
execute function trg_check_class_capacity();
