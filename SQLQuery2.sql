--lab-2
--PART--A

-- Create Department Table
CREATE TABLE Department (
 DepartmentID INT PRIMARY KEY,
 DepartmentName VARCHAR(100) NOT NULL UNIQUE
);

select *from Department
-- Create Designation Table
CREATE TABLE Designation (
 DesignationID INT PRIMARY KEY,
 DesignationName VARCHAR(100) NOT NULL UNIQUE
);

select *from Designation

-- Create Person Table
CREATE TABLE Person (
 PersonID INT PRIMARY KEY IDENTITY(101,1),
 FirstName VARCHAR(100) NOT NULL,
 LastName VARCHAR(100) NOT NULL,
 Salary DECIMAL(8, 2) NOT NULL,
 JoiningDate DATETIME NOT NULL,
 DepartmentID INT NULL,
 DesignationID INT NULL,
 FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
 FOREIGN KEY (DesignationID) REFERENCES Designation(DesignationID)
);

select *from person 

--1. Department, Designation & Person Table’s INSERT, UPDATE & DELETE Procedures.
	--insert
	--department
     create or alter procedure pr_department_insert
	 @id int,
	 @name varchar(50)
	 as
	 begin
	   insert into department values(@id,@name)
	 end

	 pr_department_insert 4,'Account'
	 select *from Department

	 --designation
	 create or alter procedure pr_designation_insert
	 @id int,
	 @name varchar(50)
	 as
	 begin
	   insert into Designation values(@id,@name)
	 end

	 pr_designation_insert 15,'CEO'
	 select *from designation

	 --persons
	 create or alter procedure pr_person_insert
	 @fname varchar(50),
	 @lname varchar(50),
	 @salary int,
	 @joiningdate datetime,
	 @departmentid int, 
	 @designationid int
	 as
	 begin
	   insert into person(FirstName,LastName,Salary,JoiningDate,DepartmentID,DesignationID)
       values(@fname,@lname,@salary,@joiningdate,@departmentid,@designationid)
	 end
      pr_person_insert 'Hardik','Hinsu',18000,'09-25-1990',2,11
	  pr_person_insert 'Bhavin','Kamani',25000,'05-14-1991',null,11
	  pr_person_insert 'Bhoomi','Patel',39000,'02-20-2014',1,13
	  pr_person_insert 'Rohit','Rajgor',17000,'07-23-1990',2,15
	  pr_person_insert 'Priya','Mehta',18000,'10-18-1990',2,null
	  pr_person_insert 'Neha','Trivedi',18000,'02-20-2014',3,15

	  select *from person
	  select*from designation
	  select *from department

	  --update
	  --department
	  create or alter procedure pr_department_update
	 @id int,
	 @name varchar(50)
	 as
	 begin
	   update department 
	   set departmentname=@name
	   where departmentid=@id
	 end
	 pr_department_update 1,'Admin'

	 --designation
	 create or alter procedure pr_designation_update
	 @id int,
	 @name varchar(50)
	 as
	 begin
	   update designation
	   set designationname=@name
	   where designationid=@id
	 end
	 pr_designation_update 1,'admin'

	 --person 
	  create or alter procedure pr_person_update 
	 @id int,
	 @fname varchar(50),
	 @lname varchar(50),
	 @salary int,
	 @joiningdate datetime,
	 @departmentid int, 
	 @designationid int
	 as
	 begin
	   update person
	   set PersonID=@id,
	   FirstName=@fname,
	   LastName=@lname
	   ,Salary=@salary
	   ,JoiningDate=@joiningdate
	   ,DepartmentID=@departmentid
	   ,designationid=@designationid  
	   where personid=@id
	 end

--2. Department, Designation & Person Table’s SELECTBYPRIMARYKEY
	--designation
	create or alter procedure pr_designation_select_by_id
	 @id int
	 as
	 begin
	   select * from designation
	   where designatioId = @id
	 end
	 pr_designation_select_by_id 11

	 --person
	create or alter procedure pr_person_select_by_id
	 @id int
	 as
	 begin
	   select * from person
	   where personId = @id
	 end
	 pr_person_select_by_id 101

	 --department
	create or alter procedure pr_department_select_by_id
	 @id int
	 as
	 begin
	   select * from department
	   where departmentId = @id
	 end
	 pr_department_select_by_id 1

--3. Department, Designation & Person Table’s (If foreign key is available then do write join and take columns on select list)
	select *from department join person
	on department.departmentid=person.departmentid
	join designation
	on person.designationid=designation.designationid

--4. Create a Procedure that shows details of the first 3 persons
	create or alter procedure pr_top3_person
	as
	begin
	  select top 3* from person
    end
	pr_top3_person

--Part – B
--5. Create a Procedure that takes the department name as input and returns a table with all workers working in that department.
	create or alter procedure pr_department_name
	@nme varchar(50)
	as
	begin
		select * from department
		where DepartmentName=@nme
		
	end
	exec pr_department_name 'HR'

--6. Create Procedure that takes department name & designation name as input and returns a table with worker’s first name, salary, joining date & department name.
	create or alter procedure pr_departmentname_designationname
	@dep_name varchar(50),
	@des_name varchar(50)
	as
	begin
--7. Create a Procedure that takes the first name as an input parameter and display all the details of the worker with their department & designation name.
--8. Create Procedure which displays department wise maximum, minimum & total salaries.
--9. Create Procedure which displays designation wise average & total salaries.
--Part – C
--10. Create Procedure that Accepts Department Name and Returns Person Count.
--11. Create a procedure that takes a salary value as input and returns all workers with a salary greater than input salary value along with their department and designation details.
--12. Create a procedure to find the department(s) with the highest total salary among all departments.
--13. Create a procedure that takes a designation name as input and returns a list of all workers under that designation who joined within the last 10 years, along with their department.
--14. Create a procedure to list the number of workers in each department who do not have a designation assigned.
--15. Create a procedure to retrieve the details of workers in departments where the average salary is above 12000.