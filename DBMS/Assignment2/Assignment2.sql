/* droping previous tables */
drop table Employee;
drop table Dept;
drop table Project;

/* Table Creatation */
create table Employee(Emp_id int, Dept_id int, fname varchar(20), lname varchar(20), designation varchar(20), salary int, JoinDate date);
create table Dept(Dept_id int, dname varchar(20), dlocation varchar(20));
create table Project(Proj_id int, Dept_id int, Pname varchar(20), Plocation varchar(20), Pcost int, Pyear date);

/* Table Alteration */
alter table Dept add primary key (Dept_id);
alter table Employee add Foreign key (Dept_id) references Dept(Dept_id);
alter table Project add Foreign key (Dept_id) references Dept(Dept_id);

/* Inserting into Dept */
insert into Dept values(0, "FE", "F1");
insert into Dept values(1, "CE", "A1");
insert into Dept values(2, "ENTC", "A3");
insert into Dept values(3, "IT", "A2");
insert into Dept values(4, "MECH", "Pune");
insert into Dept values(5, "CIVIL", "Mumbai");
insert into Dept values(6, "ECE", "Mumbai");
insert into Dept values(7, "AERO", "Nashik");

/* Inserting into Employee Table */
insert into Employee values(1, 0, "Rohan", "Doshi", "PROF", "100000", "2022-06-21");
insert into Employee values(2, 1, "Patya", "Doke", "STAFF", "123000", "2020-07-25");
insert into Employee values(3, 0, "Rutya", "Ghatage", "PROF", "1000000", "2021-05-21");
insert into Employee values(4, 2, "Tanmya", "Karmarkar", "STAFF", "640000", "2020-11-11");
insert into Employee values(5, 3, "Vinayak", "Jamadar", "PROF", "650000", "2014-12-11");
insert into Employee values(6, 1, "Ayush", "Gala", "PROF", "103000", "2020-01-31");
insert into Employee values(7, 2, "ABC", "XYZ", "ASS. PROF", "1230000", "2017-02-26");
insert into Employee values(8, 2, "XYZ", "ABC", "PROF", "1034000", "2022-06-23");
insert into Employee values(9, 3, "Rohan", "Joshi", "ASS. PROF", "50000", "2021-06-11");
insert into Employee values(10, 0, "Rohit", "Doshi", "PROF", "78000", "2019-12-22");
insert into Employee values(11, 0, "Himanshu", "Doshi", "PROF", "78000", "2019-12-22");

/* Inserting into Project Table */
insert into Project values(1, 0, "Cloud Accounting", "Pune", 100000, "2022-06-21");
insert into Project values(2, 2, "Cloud Computing", "Mumbai", 65400, "2020-06-21");
insert into Project values(3, 1, "Cloud Blockchain", "Nashik", 100000, "2022-06-21");
insert into Project values(4, 3, "Accounting", "Pune", 102000, "2012-02-21");
insert into Project values(5, 4, "Bitcoin", "Pune", 102000, "2005-02-21");
insert into Project values(6, 0, "B", "Pune", 102000, "2005-02-21");
insert into Project values(5, 3, "Base", "Mumbai", 102000, "2007-02-21");

/* 2 */
select * from Employee Inner Join Dept on Employee.Dept_id=Dept.Dept_id where dname='CE' or dname='IT' or fname like 'p%' or fname like 'h%';

/* 3 */
select COUNT(DISTINCT designation) from Employee;

/* 4 */
update Employee set salary=(salary*1.10) where JoinDate<'2015-01-01';

/* 5 */
delete from Dept where dlocation='Mumbai';

/* 6 */
select * from Project where Plocation='Pune';

/* 7 */
select * from Project where Pcost between 100000 and 500000;

/* 8 */
select *, avg(Pcost) as 'Average Cost' from Project where Pcost = (select max(Pcost) from Project);

/* 9 */
select * from Employee order by Emp_id DESC, fname DESC;

/* 10 */
select Pname, Plocation, Pcost from Project where year(Pyear)=2007 or year(Pyear)=2005 or year(Pyear)=2004;

/* 2nd Highest Salary */ 
select * from Employee order by salary desc limit 1,1;

