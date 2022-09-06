delimiter $$
drop procedure addnewdata;
create procedure addnewdata(IN empid int)
BEGIN
	DECLARE empid_2 int;
	DECLARE exit_loop BOOLEAN;
	
	DECLARE C1 CURSOR FOR SELECT Emp_id FROM Employee where Emp_id>empid;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET exit_loop = TRUE;
	
	OPEN C1;
	emp_loop: LOOP
	FETCH C1 INTO empid_2;
		IF NOT EXISTS (SELECT * FROM NEW_EMPLOYEE WHERE Emp_id=empid_2) THEN
			INSERT INTO NEW_EMPLOYEE SELECT * FROM Employee WHERE Emp_id=empid_2;
		END IF;
		IF exit_loop THEN 
			CLOSE C1;
			LEAVE emp_loop;
		END IF;
	END LOOP emp_loop;
END
$$
delimiter ;
