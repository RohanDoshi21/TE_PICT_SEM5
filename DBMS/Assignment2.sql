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

/* Inserting into Project Table */
insert into Project values(1, 0, "Cloud Accounting", "Pune", 100000, "2022-06-21");
insert into Project values(2, 2, "Cloud Computing", "Mumbai", 65400, "2020-06-21");
insert into Project values(3, 1, "Cloud Blockchain", "Nashik", 100000, "2022-06-21");
insert into Project values(4, 3, "Accounting", "Pune", 102000, "2012-02-21");