/*
	Problem statement :-
		Write a Stored Procedure namely proc_Grade for the categorization of student.
        If marks scored by students in examination is <=1500 and marks>=990 then
        student will be placed in distinction category,
        if marks scored are between 989 and 900 category is first class,
        if marks 899 and 825 category is Higher Second Class.
        Write a PL/SQL block to use procedure created with above requirement.
			Stud_Marks(name, total_marks)
			Result(Roll,Name, Class)
*/

CREATE TABLE Stud_Marks(RollNo INT PRIMARY KEY, Sname VARCHAR(20), Total_Marks INT );
CREATE TABLE Result(RollNo INT REFERENCES Stud_Marks(RollNo), Sname VARCHAR(20), Marks INT, Grade VARCHAR(20) );


INSERT INTO Stud_Marks VALUES
(1, 'Vidyut', 995),
(2, 'Pratap', 828),
(3, 'Kailash', 945),
(4, 'Mukund', 1500),
(5, 'Girish', 900),
(6, 'Neeraj', 850),
(7, 'Prashant', 800),
(8, 'Raj', 899),
(9, 'Hari', 1300),
(10, 'Aditya', 920);

delimiter //
create procedure proc_Grade(IN SRollNo INT)
BEGIN

Declare Student_Name varchar(20);
Declare Student_Marks varchar(20);
Declare Student_Grade varchar(20);

Declare EXIT HANDLER FOR NOT FOUND select 'No Student Record Found' as 'Error';
select Sname, Total_Marks into Student_Name, Student_Marks from Stud_Marks where RollNo = SRollNo;

if Student_Marks >= 990 then
set Student_Grade = 'Distinction';

elseif Student_Marks >= 900 then
set Student_Grade = 'First Class';

elseif Student_Marks >= 825 then
set Student_Grade = 'Higher Second Class';

end if;

insert into Result values (SRollNo, Student_Name, Student_Marks, Student_Grade);

END //
call proc_Grade(1);



-- Creating a function
delimiter //
create function fun_Grade1(Student_Marks INT)
returns varchar(20)
DETERMINISTIC
BEGIN

Declare Student_Grade varchar(20) default 'PASS';

if Student_Marks >= 990 then
set Student_Grade = 'Distinction';

elseif Student_Marks >= 900 then
set Student_Grade = 'First Class';

elseif Student_Marks >= 825 then
set Student_Grade = 'Higher Second Class';

end if;

return Student_Grade;

END //

delimiter ;

-- Calling the function
SELECT RollNo, Sname, Total_Marks, fun_Grade1(Total_Marks) AS GRADE  FROM Stud_marks ORDER BY RollNo;
