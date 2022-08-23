drop table Fine;
drop table Borrower;

create table Borrower(Roll_No int, Name varchar(20), DateOfIssue date, NameOfBook varchar(20), Status varchar(20));
create table Fine(Roll_No int, Curr_Date date, Amt int); 

alter table Borrower add primary key (Roll_No);
alter table Fine add foreign key (Roll_No) references Borrower(Roll_No);

insert into Borrower values(31120, "Rohan",  "2022/08/23", "MySQL", "Issue");
insert into Borrower values(31137, "Rohit",  "2022/07/22", "TOC", "Issue");
insert into Borrower values(31168, "Rutya",  "2022/06/22", "DS", "Issue");
insert into Borrower values(31189, "Tanmya",  "2022/08/22", "LP1", "Issue");
insert into Borrower values(41126, "Dinya",  "2022/08/02", "DBMS", "Issue");
insert into Borrower values(11126, "Bhaloo",  "2022/07/22", "BOOK", "Issue");
insert into Borrower values(21126, "Cherya",  "2022/06/22", "LOTR", "Issue");

drop procedure submit_book;

delimiter @@
create procedure submit_book(in roll_no int, in BookName varchar(20))
begin
	DECLARE days int;
	select DATEDIFF(CURRENT_DATE, DateOfIssue) into days from Borrower where Roll_No=roll_no and NameOfBook=BookName;
	IF days > 15 and days < 30 THEN
	insert into Fine values(roll_no, CURRENT_DATE, (days-15)*5);
	ELSEIF days > 30 THEN
	insert into Fine values(roll_no, CURRENT_DATE, (days-30)*50 + 15*5);
	END IF;
	UPDATE Borrower set Status = "Return" where Roll_No=roll_no and NameOfBook=BookName;
	
end;
@@
delimiter ;


call submit_book(31168, 'DS');
select * from Fine;
select * from Borrower;
