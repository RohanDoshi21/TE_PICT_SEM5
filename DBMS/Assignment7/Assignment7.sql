create table Library_Audit(old_name varchar(50), new_name varchar(50), old_price int, new_price int, old_pages int, new_page int, author varchar(20), status varchar(20), date TIMESTAMP);

drop trigger trigger_book_update;

delimiter ##
create trigger trigger_book_update after update on Book
for each row
	begin
	
		insert into Library_Audit set old_name=OLD.name, new_name=NEW.name, old_price=OLD.price, new_price=NEW.price, old_pages=OLD.pages, new_page=NEW.pages, author=OLD.fk_author, status="UPDATED", date=CURRENT_TIMESTAMP();
		
	end
	##
delimiter ;

drop trigger trigger_book_delete;

delimiter ##
create trigger trigger_book_delete after delete on Book
for each row
	begin
	
		insert into Library_Audit set old_name=OLD.name, new_name=NULL, old_price=OLD.price, new_price=NULL, old_pages=OLD.pages, new_page=NULL, author=OLD.fk_author, status="DELETED", date=CURRENT_TIMESTAMP();
		
	end
	##
delimiter ;
