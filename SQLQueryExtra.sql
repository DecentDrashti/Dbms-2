--Extra
 CREATE TABLE movieDETAILS
(
	movieID Int Primary Key,
	movieName Varchar(100) Not Null,
	ContactNo Varchar(100) Not Null,
	Department Varchar(100) Not Null,
	Salary Decimal(10,2) Not Null,
	JoiningDate DateTime Null
)

--1)	Create a trigger that fires AFTER INSERT, UPDATE, and DELETE operations on the movieDetails table to display the message "movie record inserted", "movie record updated", "movie record deleted"
create trigger tr_movie_after_Insert
	on movieDetail
	After insert
	as
	begin
		declare @movieid int,
				@movieName varchar(100);
		select @movieid=movieID,@movieName=movieName from inserted
		insert into movieLog
		values(@movieid,@movieName,'insert',GETDATE());
	END
	insert into movieInfo values(105,'drashti','80000',null,'rajkot',2,'1975-10-8');

	Update movieInfo
	set BirthDate='2005-08-23'
	where movieID=101

	Delete from movieInfo
	where movieID=102
--2)	Create a trigger that fires AFTER INSERT, UPDATE, and DELETE operations on the movieDetails table to log all operations into the movieLog table.
create trigger tr_movie_after_Insert
	on movieInfo
	After insert
	as
	begin
		declare @movieid int,
				@movieName varchar(100);
		select @movieid=movieID,@movieName=movieName from inserted
		insert into movieLog
		values(@movieid,@movieName,'insert',GETDATE());
	END
	insert into movieInfo values(105,'drashti','80000',null,'rajkot',2,'1975-10-8');

	Update movieInfo
	set BirthDate='2005-08-23'
	where movieID=101

	Delete from movieInfo
	where movieID=102
--3)	Create a trigger that fires AFTER INSERT to automatically calculate the joining bonus (10% of the salary) for new movies and update a bonus column in the movieDetails table.
create trigger tr_movie_after_Insert
	on movieInfo
	After insert
	as
	begin
		declare @movieid int,
				@movieName varchar(100);
		select @movieid=movieID,@movieName=movieName from inserted
		insert into movieLog
		values(@movieid,@movieName,'insert',GETDATE());
	END
	insert into movieInfo values(105,'drashti','80000',null,'rajkot',2,'1975-10-8');

	Update movieInfo
	set BirthDate='2005-08-23'
	where movieID=101

	Delete from movieInfo
	where movieID=102
--4)	Create a trigger to ensure that the JoiningDate is automatically set to the current date if it is NULL during an INSERT operation.
create trigger tr_movie_after_Insert
	on movieInfo
	After insert
	as
	begin
		declare @movieid int,
				@movieName varchar(100);
		select @movieid=movieID,@movieName=movieName from inserted
		insert into movieLog
		values(@movieid,@movieName,'insert',GETDATE());
	END
	insert into movieInfo values(105,'drashti','80000',null,'rajkot',2,'1975-10-8');

	Update movieInfo
	set BirthDate='2005-08-23'
	where movieID=101

	Delete from movieInfo
	where movieID=102
--5)	Create a trigger that ensure that ContactNo is valid during insert and update (Like ContactNo length is 10)
create trigger tr_movie_after_Insert
	on movieInfo
	After insert
	as
	begin
		declare @movieid int,
				@movieName varchar(100);
		select @movieid=movieID,@movieName=movieName from inserted
		insert into movieLog
		values(@movieid,@movieName,'insert',GETDATE());
	END
	insert into movieInfo values(105,'drashti','80000',null,'rajkot',2,'1975-10-8');

	Update movieInfo
	set BirthDate='2005-08-23'
	where movieID=101

	Delete from movieInfo
	where movieID=102


--instead of 
CREATE TABLE movieLogs (
    LogID INT PRIMARY KEY IDENTITY(1,1),
    movieID INT NOT NULL,
    movieName VARCHAR(100) NOT NULL,
    ActionPerformed VARCHAR(100) NOT NULL,
    ActionDate DATETIME NOT NULL
);


--1.	Create an INSTEAD OF trigger that fires on INSERT, UPDATE and DELETE operation on the Movies table. For that, log all operations performed on the Movies table into MoviesLog.
create or alter trigger tr_insteadof_movie_Insert_update
	on movieInfo
	instead of insert
	as
	begin
		declare @movieid int,
				@movieName varchar(100),
				@salary int,
				@jd date,
				@city varchar(50),
				@Age int,
				@birthdate date

		insert into movieInfo values(@movieid ,
				@movieName ,
				@salary ,
				@jd ,
				@city ,
				@Age ,
				@birthdate)

		select @movieid=movieID,@movieName=movieName,@salary=Salary,@jd=JoiningDate,@city=city,@Age=Age,@birthdate=BirthDate from inserted 
		where movieName not in (select movieName from movieInfo);
	end
--2.	Create a trigger that only allows to insert movies for which Rating is greater than 5.5 .
create or alter trigger tr_insteadof_movie_Insert_update
	on movieInfo
	instead of insert
	as
	begin
		declare @movieid int,
				@movieName varchar(100),
				@salary int,
				@jd date,
				@city varchar(50),
				@Age int,
				@birthdate date

		insert into movieInfo values(@movieid ,
				@movieName ,
				@salary ,
				@jd ,
				@city ,
				@Age ,
				@birthdate)

		select @movieid=movieID,@movieName=movieName,@salary=Salary,@jd=JoiningDate,@city=city,@Age=Age,@birthdate=BirthDate from inserted 
		where movieName not in (select movieName from movieInfo);
	end
--3.	Create trigger that prevent duplicate 'MovieTitle' of Movies table and log details of it in MoviesLog table.
create or alter trigger tr_insteadof_movie_Insert_update
	on movieInfo
	instead of insert
	as
	begin
		declare @movieid int,
				@movieName varchar(100),
				@salary int,
				@jd date,
				@city varchar(50),
				@Age int,
				@birthdate date

		insert into movieInfo values(@movieid ,
				@movieName ,
				@salary ,
				@jd ,
				@city ,
				@Age ,
				@birthdate)

		select @movieid=movieID,@movieName=movieName,@salary=Salary,@jd=JoiningDate,@city=city,@Age=Age,@birthdate=BirthDate from inserted 
		where movieName not in (select movieName from movieInfo);
	end
--4.	Create trigger that prevents to insert pre-release movies.
create or alter trigger tr_insteadof_movie_Insert_update
	on movieInfo
	instead of insert
	as
	begin
		declare @movieid int,
				@movieName varchar(100),
				@salary int,
				@jd date,
				@city varchar(50),
				@Age int,
				@birthdate date

		insert into movieInfo values(@movieid ,
				@movieName ,
				@salary ,
				@jd ,
				@city ,
				@Age ,
				@birthdate)

		select @movieid=movieID,@movieName=movieName,@salary=Salary,@jd=JoiningDate,@city=city,@Age=Age,@birthdate=BirthDate from inserted 
		where movieName not in (select movieName from movieInfo);
	end
--5.	Develop a trigger to ensure that the Duration of a movie cannot be updated to a value greater than 120 minutes (2 hours) to prevent unrealistic entries.
create or alter trigger tr_insteadof_movie_Insert_update
	on movieInfo
	instead of insert
	as
	begin
		declare @movieid int,
				@movieName varchar(100),
				@salary int,
				@jd date,
				@city varchar(50),
				@Age int,
				@birthdate date

		insert into movieInfo values(@movieid ,
				@movieName ,
				@salary ,
				@jd ,
				@city ,
				@Age ,
				@birthdate)

		select @movieid=movieID,@movieName=movieName,@salary=Salary,@jd=JoiningDate,@city=city,@Age=Age,@birthdate=BirthDate from inserted 
		where movieName not in (select movieName from movieInfo);
	end