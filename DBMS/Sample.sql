/* employees with highest salary in their department */
select * from Employee where (Dept_id, salary) in (select Dept_id, max(salary) from Employee group by Dept_id); 

select * from Employee outE where salary > (select avg(salary) from Employee inE where outE.Dept_id = inE.Dept_id);

select Dept_id, sum(Pcost) from Project group by Dept_id having sum(Pcost) > (select avg(Pcost) from Project);

select * from Project P1 join (select avg(Pcost) as avg from Project ) P2 on P1.Pcost >= P2.avg where P1.Pcost = (select max(Pcost) from Project);

select * from Dept where Dept_id not in (select distinct Dept_id from Employee);

select * from (select sum(Pcost) as total from Project) P1 join (select avg(Pcost) as avg from Project ) P2 on P1.total > P2.avg;
