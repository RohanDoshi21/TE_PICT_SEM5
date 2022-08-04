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


/* 7 */

