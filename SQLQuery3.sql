--Lab-3:-
--Part – A:-
CREATE TABLE Departments (
 DepartmentID INT PRIMARY KEY,
 DepartmentName VARCHAR(100) NOT NULL UNIQUE,
 ManagerID INT NOT NULL,
 Location VARCHAR(100) NOT NULL
);
CREATE TABLE Employee (
 EmployeeID INT PRIMARY KEY,
 FirstName VARCHAR(100) NOT NULL,
 LastName VARCHAR(100) NOT NULL,
 DoB DATETIME NOT NULL,
 Gender VARCHAR(50) NOT NULL,
 HireDate DATETIME NOT NULL,
 DepartmentID INT NOT NULL,
 Salary DECIMAL(10, 2) NOT NULL,
 FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);
-- Create Projects Table
CREATE TABLE Projects (
 ProjectID INT PRIMARY KEY,
 ProjectName VARCHAR(100) NOT NULL,
 StartDate DATETIME NOT NULL,
 EndDate DATETIME NOT NULL,
 DepartmentID INT NOT NULL
 FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);
INSERT INTO Departments (DepartmentID, DepartmentName, ManagerID, Location)
VALUES 
 (1, 'IT', 101, 'New York'),
 (2, 'HR', 102, 'San Francisco'),
 (3, 'Finance', 103, 'Los Angeles'),
 (4, 'Admin', 104, 'Chicago'),
 (5, 'Marketing', 105, 'Miami');
 select * from Departments

INSERT INTO Employee (EmployeeID, FirstName, LastName, DoB, Gender, HireDate, DepartmentID, 
Salary)
VALUES 
 (101, 'John', 'Doe', '1985-04-12', 'Male', '2010-06-15', 1, 75000.00),
 (102, 'Jane', 'Smith', '1990-08-24', 'Female', '2015-03-10', 2, 60000.00),
 (103, 'Robert', 'Brown', '1982-12-05', 'Male', '2008-09-25', 3, 82000.00),
 (104, 'Emily', 'Davis', '1988-11-11', 'Female', '2012-07-18', 4, 58000.00),
 (105, 'Michael', 'Wilson', '1992-02-02', 'Male', '2018-11-30', 5, 67000.00);
 select *from Employee

INSERT INTO Projects (ProjectID, ProjectName, StartDate, EndDate, DepartmentID)
VALUES 
 (201, 'Project Alpha', '2022-01-01', '2022-12-31', 1),
 (202, 'Project Beta', '2023-03-15', '2024-03-14', 2),
 (203, 'Project Gamma', '2021-06-01', '2022-05-31', 3),
 (204, 'Project Delta', '2020-10-10', '2021-10-09', 4),
 (205, 'Project Epsilon', '2024-04-01', '2025-03-31', 5);
 select *from Projects

--1. Create Stored Procedure for Employee table As User enters either First Name or Last Name and based on this you must give EmployeeID, DOB, Gender & Hiredate. 
	create or alter procedure pr_employee_detail
	@fname varchar(25)=null,
	@lname varchar(25)=null
	as
	begin
		select employeeid,dob,gender,hiredate from employee
		where firstname=@fname or lastname=@lname
	end
	pr_employee_detail '','smith'
		
		
--2. Create a Procedure that will accept Department Name and based on that gives employees list who belongs to that department.
	create or alter procedure pr_department_employee
	@dname varchar(25)
	as
	begin
		select employee.* from employee join Departments 
		on employee.DepartmentID=Departments.DepartmentID where DepartmentName=@dname
	end
	pr_department_employee 'HR'

--3. Create a Procedure that accepts Project Name & Department Name and based on that you must give all the project related details.
	create or alter procedure  pr_project_department
	@pname varchar(25),
	@dname varchar (25)
	as
	begin
		select projects.* from Projects 
		join Departments
		on Projects.DepartmentID=Departments.DepartmentID
		where ProjectName=@pname and DepartmentName=@dname
	end
	pr_project_department 'Project Alpha','IT'

--4. Create a procedure that will accepts any integer and if salary is between provided integer, then those employee list comes in output. 
	create or alter procedure pr_integer_employee
	@integer1 int,
	@integer2 int
	as 
	begin
		select firstname + lastname  from employee
		where Salary between @integer1 AND @integer2
	end
	pr_integer_employee 20000,50000

--5. Create a Procedure that will accepts a date and gives all the employees who all are hired on that date.
	create procedure pr_date_employee
	@date datetime
	as
	begin
		select * from employee 
		where HireDate=@date
	end
	pr_date_employee '2010-06-15'

--Part – B
--6. Create a Procedure that accepts Gender’s first letter only and based on that employee details will be served. 
	create or alter procedure pr_gender_employee
	@gender varchar(1)
	as--left function
	begin
		select *from employee
		where gender like '@gender%'
	end
	pr_gender_employee 'f'

--7. Create a Procedure that accepts First Name or Department Name as input and based on that employee data will come.
	create or alter procedure pr_fname_employee_dname
	@fname varchar(25)=null,
	@dname varchar(25)=null
	as
	begin
		select employee.* from employee join Departments
		on Employee.DepartmentID=Departments.DepartmentID
		where FirstName=@fname or DepartmentName=@dname
	end
	pr_fname_employee_dname 'john'

--8. Create a procedure that will accepts location, if user enters a location any characters, then he/she will get all the departments with all data. 
	create procedure pr_location
	@location varchar(50)
	as--left--
	begin
	 select *from departments 
	 where Location like %@location%
	end
--Part – C
--9. Create a procedure that will accepts From Date & To Date and based on that he/she will retrieve Project related data.
	create or alter procedure pr_date_project
	@sd datetime,
	@ed datetime
	as
	begin
	 select * from Projects
	 where StartDate=@sd and EndDate=@ed
	end
	pr_date_project '2022-01-01', '2022-12-31'

--10. Create a procedure in which user will enter project name & location and based on that you must provide all data with Department Name, Manager Name with Project Name & Starting Ending Dates.
	create or alter procedure pr_nl_project
	@pname varchar(25),
	@lname varchar(25)
	as
	begin
	  select *from Projects p join Departments d
	  on d.DepartmentID=p.DepartmentID
	  join employee e
	  on e.DepartmentID=d.DepartmentID
	  where ProjectName=@pname and Location=@lname
	end
	pr_nl_project 'Project Alpha','new york'
