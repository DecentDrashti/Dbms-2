--lab-4
--Part – A
--1. Write a function to print "hello world".
	create or alter function fn_Helloworld()
	returns varchar(50)
	as
	begin
		return 'Hello World'
	end
	select dbo.fn_Helloworld()

--2. Write a function which returns addition of two numbers.
	 create or alter function fn_addition
	 (@num1 int ,@num2 int)
	 returns int
	 as
	 begin
		return @num1+@num2
	 end
	 select dbo.fn_addition(2,4)

	 --or
	create or alter function fn_addition
	 (@num1 int ,@num2 int)
	 returns int
	 as
	 begin
		declare @sum int
		set @sum=@num1+@num2
		return @sum
	 end
	 select dbo.fn_addition(2,4)

--3. Write a function to check whether the given number is ODD or EVEN.
	create or alter function fn_odd_even(@num int)
	returns varchar(50)
	as
	begin
	declare @msg varchar(50)
	 if @num%2=0
		set @msg='the number is even'
	else 
		set @msg='the number is odd'
	return @msg
	end
	select dbo.fn_odd_even(3)

--4. Write a function which returns a table with details of a person whose first name starts with B.
	create or alter function fn_table1()
	returns table
	as
	return
	(
	select * from Person where FirstName like 'B%'
	);
	select *from dbo.fn_table1()

--5. Write a function which returns a table with unique first names from the person table.
	create or alter function fn_table2()
	returns table
	as
	return
	(
	select distinct firstname from Person
	);
	select *from dbo.fn_table2()

--6. Write a function to print number from 1 to N. (Using while loop)
	create or alter function fn_1ton (@num int)
	returns varchar(200)
	as 
	begin
		declare @msg varchar(200),@count int
		set @msg=' '
		set @count=1
		while(@count<=@num)
		begin
			set @msg=@msg+cast(@count As varchar)+' '
			set @count=@count+1
		end
		return @msg
	end
	select dbo.fn_1ton(10)

--7. Write a function to find the factorial of a given integer.
	create or alter function fn_factorial(@num int)
	returns int
	as 
	begin
		declare @ans int
		set @ans=1
		while(@num!=0)
		     begin
			 set @ans=@ans*@num
			 set @num=@num-1
		end
		return @ans
	end
	select dbo.fn_factorial(5)

--Part – B
--8. Write a function to compare two integers and return the comparison result. (Using Case statement)
	create or alter function fn_compare_int(@num1 int,@num2 int)
	returns varchar(50)
	as
	begin
		return case
					when @num1>@num2 then 'first is greater'
					when @num2>@num1 then 'second is greater'
					else 'both are equal'
				end
	end
	select dbo.fn_compare_int(2,4)

--9. Write a function to print the sum of even numbers between 1 to 20.
	create or alter function fn_even_number()
	returns int
	as
	begin
		declare @ans int,@num int
		set @ans=0
		set @num=2
		while(@num!=20)
			begin
				--set @msg=@msg+cast(@num As varchar)+' '
				set @ans=@ans+@num
				set @num=@num+2
			end
	return @ans
	end
	select dbo.fn_even_number()

--10. Write a function that checks if a given string is a palindrome
	create or alter function fn_palindrome(@str varchar(100))
	returns varchar(50)
	as
	begin
		declare @msg varchar(50),@rev varchar(50)
		set @msg=' '
		set @rev=REVERSE(@str)
		if(@rev=@str)
		    set @msg='the string is palindrome'
		else
		    set @msg='the string is not plaindrome'
	return @msg
	end
	select dbo.fn_palindrome('aba')

--Part – C
--11. Write a function to check whether a given number is prime or not.
	create or alter function fn_prime(@num int)
	returns varchar(50)
	as
	begin
		declare @msg varchar(50),@i int,@count int
		set @i=1
		set @count=0
		set @msg=' '
		while(@i<=@num)
		begin
			if(@num%@i=0)
					@count=@count+1
		@i=@i+1
		end
		if(@count>2)
			set @msg='the number is not prime'
		else 
			set @msg='the number is prime'
	return @msg
	end
	select dbo.fn_prime(2)
--12. Write a function which accepts two parameters start date & end date, and returns a difference in days.
--13. Write a function which accepts two parameters year & month in integer and returns total days each year.
	create or alter function fn_gettotaldays(@year int ,@month int)
	returns int
	as begin
		 declare @ans varchar(50),@date date,@days int
		 set @ans=cast(@year as varchar)+'-'+cast(@month as varchar)+'-1'
		 set @date=cast(@ans as date)
		 set @days=day(eomonth(@date))
		 return @days
	end
	select dbo.fn_gettotaldays(2012,11)
--14. Write a function which accepts departmentID as a parameter & returns a detail of the persons.
--15. Write a function that returns a table with details of all persons who joined after 1-1-1991.