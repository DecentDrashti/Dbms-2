--nava ma 5 th ma khali insert j che
--Part – A
-- Creating PersonInfo Table
CREATE TABLE PersonInfo (
 PersonID INT PRIMARY KEY,
 PersonName VARCHAR(100) NOT NULL,
 Salary DECIMAL(8,2) NOT NULL,
 JoiningDate DATETIME NULL,
 City VARCHAR(100) NOT NULL,
 Age INT NULL,
 BirthDate DATETIME NOT NULL
);
-- Creating PersonLog Table
CREATE TABLE PersonLog (
 PLogID INT PRIMARY KEY IDENTITY(1,1),
 PersonID INT NOT NULL,
 PersonName VARCHAR(250) NOT NULL,
 Operation VARCHAR(50) NOT NULL,
 UpdateDate DATETIME NOT NULL)

 select *from PersonLog
 select *from PersonInfo
--1. Create a trigger that fires on INSERT, UPDATE and DELETE operation on the PersonInfo table to display a message “Record is Affected.”  
	create trigger tr_Person_after_Insert_update_delete
	on PersonInfo
	After insert,update,delete
	as
	begin
	print('record is affected')
	END

--2. Create a trigger that fires on INSERT, UPDATE and DELETE operation on the PersonInfo table. For that,log all operations performed on the person table into PersonLog.
	create trigger tr_Person_after_Insert
	on PersonInfo
	After insert
	as
	begin
		declare @personId int,
				@personName varchar(100);
		select @personId=PersonID,@personName=PersonName from inserted
		insert into PersonLog
		values(@personId,@personName,'insert',GETDATE());
	END
	insert into PersonInfo values(105,'drashti','80000',null,'rajkot',2,'1975-10-8');

	Update PersonInfo
	set BirthDate='2005-08-23'
	where PersonID=101

	Delete from PersonInfo
	where PersonID=102

--3. Create an INSTEAD OF trigger that fires on INSERT, UPDATE and DELETE operation on the PersonInfo table. For that, log all operations performed on the person table into PersonLog.
	create or alter trigger tr_insteadof_person_Insert_update_delete
	on PersonLog
	instead of insert
	as
	begin
		declare @personId int,
				@personName varchar(100);
		select @personId=PersonID,@personName=PersonName from inserted
		insert into PersonLog
		values(@personId,@personName,'insert',GETDATE());
	END
	Update Personlog
	set BirthDate='2005-08-25'
	where PersonID=101

	Delete from PersonInfo
	where PersonID=102

--4. Create a trigger that fires on INSERT operation on the PersonInfo table to convert person name into uppercase whenever the record is inserted.
	create or alter trigger tr_person_insert_upper
	on PersonInfo
	after insert
	as
	begin
		declare @pname varchar(50),
				@pid int
		select @pname =PersonName,@pid=PersonID from inserted
		update PersonInfo
		set PersonName=upper(@pname)
		where PersonID=@pid
	END

--5. Create trigger that prevent duplicate entries of person name on PersonInfo table.
	create or alter trigger tr_insteadof_person_Insert_update
	on PersonInfo
	instead of insert
	as
	begin
		declare @personId int,
				@personName varchar(100),
				@salary int,
				@jd date,
				@city varchar(50),
				@Age int,
				@birthdate date

		insert into PersonInfo values(@personId ,
				@personName ,
				@salary ,
				@jd ,
				@city ,
				@Age ,
				@birthdate)

		select @personId=PersonID,@personName=PersonName,@salary=Salary,@jd=JoiningDate,@city=city,@Age=Age,@birthdate=BirthDate from inserted 
		where PersonName not in (select PersonName from PersonInfo);
	end
--6. Create trigger that prevent Age below 18 years.
	create or alter trigger tr_insteadof_person_Insert_update
	on PersonInfo
	instead of insert
	as
	begin
		declare @personId int,
				@personName varchar(100),
				@salary int,
				@jd date,
				@city varchar(50),
				@Age int,
				@birthdate date

		select @personId=PersonID,@personName=PersonName,@salary=Salary,@jd=JoiningDate,@city=city,@Age=Age,@birthdate=BirthDate from inserted
		if @Age>=18
			insert into PersonInfo values(@personId ,
				@personName ,
				@salary ,
				@jd ,
				@city ,
				@Age ,
				@birthdate)
			end

--Part – B
--7. Create a trigger that fires on INSERT operation on person table, which calculates the age and update that age in Person table.
	create or alter trigger tr_Person_after_Insert_update
	on PersonInfo
	After insert
	as
	begin
		declare @personId int,
				@personName varchar(100),
				@birthdate date,
				@age int
		select @personId=PersonID,@personName=PersonName,@birthdate=birthdate,@age=Age from inserted
		update PersonInfo
			set @age=DATEDIFF(year,@birthdate,getdate())
			where BirthDate=@birthdate
	END
--8. Create a Trigger to Limit Salary Decrease by a 10%.
--e 10% thi jaju decrement karse to aa trigger fire thase ne pachi original salary muki dese
	create or alter trigger tr_person_LimitSalarydecreases
	on PersonInfo
	After Update
	As
	Begin
	Declare @oldsalary decimal(8,2) ,@newSalary decimal(8,2),@id int;
	select @oldsalary=salary from deleted
	select @newSalary=salary from inserted

	if @newSalary<@oldsalary*0.9 --aa equation che 10% no
	begin
		Update PersonInfo
		SET salary =@oldsalary
		where PersonID=@id
	end
end
--Part – C 
--9. Create Trigger to Automatically Update JoiningDate to Current Date on INSERT if JoiningDate is NULL during an INSERT.
	create or alter Trigger tr_After_insert_JoiningDate
	on personinfo
	After Insert
	As
	begin
	declare @jd date,@id int
	select @jd=JoiningDate from inserted 
	if @jd=null
	begin
		Update PersonInfo
		SET JoiningDate =GETDATE()
		where PersonID=@id
	end
end
--10. Create DELETE trigger on PersonLog table, when we delete any record of PersonLog table it prints ‘Record deleted successfully from PersonLog’.
create or alter trigger tr_