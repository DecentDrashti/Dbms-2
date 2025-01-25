-- Create the Products table
CREATE TABLE Products (
 Product_id INT PRIMARY KEY,
 Product_Name VARCHAR(250) NOT NULL,
 Price DECIMAL(10, 2) NOT NULL
);
-- Insert data into the Products table
INSERT INTO Products (Product_id, Product_Name, Price) VALUES
(1, 'Smartphone', 35000),
(2, 'Laptop', 65000),
(3, 'Headphones', 5500),
(4, 'Television', 85000),
(5, 'Gaming Console', 32000);
select *from Products

--Part - A
--1. Create a cursor Product_Cursor to fetch all the rows from a products table.
	Declare @pid int,
			@pname varchar(50),
			@pp int
	Declare Product_Cursor cursor
	for
		select *from Products
	Open Product_Cursor
	Fetch next from product_cursor
	into @pid,@pname,@pp
	while @@FETCH_STATUS=0
		begin
			select @pid as product_id,@pname as product_name,@pp as price

			Fetch next from product_cursor
			into @pid,@pname,@pp
		End
	close product_cursor
	deallocate product_cursor

--2. Create a cursor Product_Cursor_Fetch to fetch the records in form of ProductID_ProductName.(Example: 1_Smartphone)
	Declare @id int,
			@name varchar(50)
	Declare Product_Cursor_fetch cursor
	for 
	select product_id,product_name from Products

	Open Product_Cursor_fetch
	Fetch next from product_cursor_fetch
	into @id,@name
	while @@FETCH_STATUS=0
		begin
			print cast(@id as varchar)+'_'+@name
			Fetch next from product_cursor_fetch
			into @id,@name
		End
	close product_cursor_fetch
	deallocate product_cursor_fetch

--3. Create a Cursor to Find and Display Products Above Price 30,000.
	Declare @nme varchar(50),
			@price int
	Declare Product_Cursor_display cursor
	for 
	select product_name,price from Products 
	where price > 30000

	Open Product_Cursor_display
	Fetch next from product_cursor_display
	into @nme,@price
	while @@FETCH_STATUS=0
		begin
			select @nme as product_name,@price as price

			Fetch next from product_cursor_display
			into @nme,@price
		End
	close product_cursor_display
	deallocate product_cursor_display

--4. Create a cursor Product_CursorDelete that deletes all the data from the Products table.
	Declare @p_id int
	Declare Product_Cursor_delete cursor
	for
		select product_id from products
	Open Product_Cursor_delete
	Fetch next from product_cursor_delete
	into @p_id
	while @@FETCH_STATUS=0
		begin
			Delete from products
			where product_id=@p_id

			Fetch next from product_cursor_delete
			into @p_id
		End
	close product_cursor_delete
	deallocate product_cursor_delete

--Part – B
--5. Create a cursor Product_CursorUpdate that retrieves all the data from the products table and increases the price by 10%.
	Declare @prid int,
			@prname varchar(50),
			@prp int
	Declare Product_CursorUpdate cursor
	for
		select *from Products
	Open Product_Cursorupdate
	Fetch next from product_cursorupdate
	into @prid,@prname,@prp
	while @@FETCH_STATUS=0
		begin
			select @prid as product_id,@prname as product_name,(@prp+@prp*0.1) as price

			Fetch next from product_cursorupdate
			into @prid,@prname,@prp
		End
	close product_cursorupdate
	deallocate product_cursorupdate

--6. Create a Cursor to Rounds the price of each product to the nearest whole number.
	Declare @proid int,
			@proname varchar(50),
			@prop decimal(10,2)
	Declare Rounds cursor
	for
		select *from Products
	Open rounds
	Fetch next from rounds
	into @proid,@proname,@prop
	while @@FETCH_STATUS=0
		begin
			select @proid as product_id,@proname as product_name,round(@prop,0) as price

			Fetch next from rounds
			into @proid,@proname,@prop
		End
	close rounds
	deallocate rounds

--Part – C
--7. Create a cursor to insert details of Products into the NewProducts table if the product is “Laptop” (Note: Create NewProducts table first with same fields as Products table)
	Declare @pr_id int,
			@pr_name varchar(50),
			@pr_price int

	Declare insert_products cursor
	for
		select *from Products where product_name='laptop'
	Open insert_products
	Fetch next from insert_products
	into @pr_id,@pr_name,@pr_price
	while @@FETCH_STATUS=0
		begin
			insert into new_products values(@pr_id,@pr_name,@pr_price)

			Fetch next from insert_products
			into @pr_id,@pr_name,@pr_price
		End
	close insert_products
	deallocate insert_products

--8. Create a Cursor to Archive High-Price Products in a New Table (ArchivedProducts), Moves products with a price above 50000 to an archive table, removing them from the original Products table
	