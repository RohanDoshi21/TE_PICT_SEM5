/* 1 */
select * from Employee natural join Dept;

/* 2 */
select fname, designation, dlocation, JoinDate from Employee natural join Dept;

/* 3 */
select Emp_id, fname, salary, Proj_id, Pcost from Employee natural join Project where Plocation != 'Pune';

/* 4 */
select dname, fname, lname, designation from Employee natural join Project natural join Dept where year(Pyear)=2020;

/* 5 */
select designation, Dept_id from Employee natural join Project natural join Dept where Pcost>30000;

/* 6 */
select Pname from Project where year(Pyear)=2015;

/* 7 */
select dname, Count(*) from Dept natural join Employee group by Dept_id;

/* 8 */
select year(JoinDate), Count(*) from Employee group by JoinDate;

/* 9 */
create view EMP_DEP as select * from Employee natural join Dept;
select * from EMP_DEP;

/* 10 */
create view EMP_DETAILS as select Emp_id, fname, lname from Employee;
select * from EMP_DETAILS;
insert into EMP_DETAILS values (20, 'Sanika', 'Inamdar');
drop view EMP_DETAILS;
