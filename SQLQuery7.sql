-- Create the Customers table
CREATE TABLE Customers (
 Customer_id INT PRIMARY KEY, 
 Customer_Name VARCHAR(250) NOT NULL, 
 Email VARCHAR(50) UNIQUE 
);
-- Create the Orders table
CREATE TABLE Orders (
 Order_id INT PRIMARY KEY, 
 Customer_id INT, 
 Order_date DATE NOT NULL, 
 FOREIGN KEY (Customer_id) REFERENCES Customers(Customer_id) 
);
--Part – A
--1. Handle Divide by Zero Error and Print message like: Error occurs that is - Divide by zero error.
	begin try
			Declare @num1 int =10 ,@num2 int=0,@ans int
			SET @ans=@num1/@num2
	End Try
	begin catch
			print 'Error ocurred that is divide by zero'
	end catch

--2. Try to convert string to integer and handle the error using try…catch block.
	Begin Try
			declare @s1 varchar='Drashti',@n1 int
			set @n1=cast(@s1 as int)
	end try
	begin catch
			print 'error occured type cast string to integer'
	end catch

--3. Create a procedure that prints the sum of two numbers: take both numbers as integer & handle exception with all error functions if any one enters string value in numbers otherwise print result.
	create or alter procedure pr_calculation_SumWithErrorHandling
		@num1 nvarchar(50),
		@num2 nvarchar(50)
		--aiya jo hu int lais to mane string nakhva j nai de syntax error apse to exception handling no case j nai bane etle aiya varchar lidhu che
	as
	begin
		begin try
				declare @intNum1 int =cast(@num1 as Int),
				@intNum2 int =cast(@num2 as Int)
				print 'Sum is:'+cast(@intNum1+@intNum2 as varchar(50));
		end try
		begin catch
				print 'error number '+cast(Error_Number() as varchar(10))
				print 'error severity '+cast(Error_Severity() as varchar(10))
				print 'error state '+cast(Error_State() as varchar(10))
				print 'error message '+cast(Error_Message() as varchar(10))
		end catch
	end
	pr_calculation_SumWithErrorHandling 'a',10

--4. Handle a Primary Key Violation while inserting data into customers table and print the error details such as the error message, error number, severity, and state.
	begin try
			insert into Customers values(null,'dr','sr@gmail.com')
	end try
	begin catch
				print 'error number '+cast(Error_Number() as varchar(10))
				print 'error severity '+cast(Error_Severity() as varchar(10))
				print 'error state '+cast(Error_State() as varchar(10))
				print 'error message '+cast(Error_Message() as varchar(10))
	end catch

--5. Throw custom exception using stored procedure which accepts Customer_id as input & that throws Error like no Customer_id is available in database.
	create procedure pr_customer_checkcustomerid
	    @cid int
	as 
	begin
		if not exists(select 1 from customers where Customer_id=@cid)
			begin
				THROW 50001,'no customer_id is available in database',1;
			end 
		else 
			begin
				print'customer id not exists'
			end
	end
pr_customer_checkcustomerid 1

--Part – B
--6. Handle a Foreign Key Violation while inserting data into Orders table and print appropriate error message.
	begin try
			insert into orders values(101,102,'2005-08-23')
	end try
	begin catch
			print 'foreign key violation'
	end catch

--7. Throw custom exception that throws error if the data is invalid.
	create or alter procedure pr_customer_checkcustomerdata
	   @value int
	as 
	begin 
		if @value<0
			begin 
				THROW 50001,'invalid data',1;
			end
		else
			begin
				print'data is valid'
			end
	end;
pr_customer_checkcustomerdata -2

--8. Create a Procedure to Update Customer’s Email with Error Handling
	create or alter procedure pr_customer_emailUpdate
	  @cid int,
	  @email nvarchar(50)
	as
	begin
		begin try
			update Customers
			set Email=@email
			where Customer_id=@cid
		end try
		begin catch
			print'email exception'
		end catch
	end
pr_customer_emailUpdate 101,'dr'

--Part – C 
--9. Create a procedure which prints the error message that “The Customer_id is already taken. Try another one”.
insert into customers values(101,'drashti','dr')
	Create or alter procedure pr_customerid
	@cid int
	as
	begin
		begin try 
				insert into customers values(@cid,'abc','abc@gmail.com')
		end try
	    begin catch
			print'the cid is already taken ,try another one'
		end catch
	end
pr_customerid 101

--10. Handle Duplicate Email Insertion in Customers Table
create procedure pr_email_duplication
	@email varchar(25)
as
begin
	if exists(select 1 from Customers where Email=@email)
	begin
		throw 50001,'not insert duplicate email',1
	end
	else 
	begin
	  print'you can insert'
	 end
end
pr_email_duplication dr