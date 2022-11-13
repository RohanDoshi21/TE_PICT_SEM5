/*
Write a PL/SQL code block to calculate the area of a circle for a value of radius varying from 5 to 9. 
Store the radius and the corresponding values of calculated area in an empty table named areas, consisting of two columns, radius and area.
*/

drop table if exists areas;
drop procedure if exists area;
create table areas(Nos int not null AUTO_INCREMENT primary key,radius float,area float);

delimiter ##
create procedure area()
BEGIN
declare radius float;
set radius =5;


area_loop:LOOP
if radius>9 THEN
leave area_loop;
ELSE
insert into areas(radius,area) values(radius,radius*radius*3.14);
set radius=radius+1;
end if;
END LOOP area_loop;
END
##

delimiter ;

call area();
