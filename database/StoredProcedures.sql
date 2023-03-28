CREATE PROCEDURE AddNewCustomer
    @email VARCHAR(255),
    @gender VARCHAR(10),
    @phone_number VARCHAR(20),
    @name VARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO USERS (email, role, is_employee, is_Active, gender, password, image_link, phone_number, name, created_at, loyalty_points)
    VALUES (@email, 'customer', 0, 1, @gender, NULL, NULL, @phone_number, @name, GETDATE(), 0);
    
END
GO


CREATE PROCEDURE AddNewEmployee
    @email VARCHAR(255),
    @role VARCHAR(20),
    @gender VARCHAR(10),
    @password VARCHAR(255),
    @phone_number VARCHAR(20),
    @name VARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO USERS (email, role, is_employee, is_Active, gender, password, image_link, phone_number, name, created_at, loyalty_points)
    VALUES (@email, @role, 1, 1, @gender, @password, NULL, @phone_number, @name, GETDATE(), NULL);
    
END
GO












CREATE PROCEDURE UpdateCustomer
@customer_id CHAR(4),
@name varchar(255),
@email varchar(255),
@phone_number varchar(255)
 AS
BEGIN
 UPDATE USERS
  SET name = @name, 
      email = @email, 
      phone_number = @phone_number

  WHERE id = @customer_id;
END



CREATE PROCEDURE UpdateEmployee
@user_id CHAR(4),
@name varchar(255),
@phone_number varchar(255),
@image_link varchar(255)
AS
BEGIN
UPDATE USERS
SET name = @name, phone_number = @phone_number, image_link = @image_link
WHERE id = @user_id
END














--3. Getting single user
-- CREATE PROCEDURE get_single_users
--   @email VARCHAR(255)
-- AS
-- BEGIN
--   SELECT *
--   FROM users
--   WHERE email = @email
-- END
-- GO

-- CREATE PROCEDURE GetEmployees
-- AS
-- BEGIN
-- SELECT u.id, u.name, u.email, u.gender, COUNT(s.id) AS 'No Sales Made', u.is_Active, u.created_at
-- FROM USERS u
-- LEFT JOIN SALES s ON s.employee_id = u.id
-- WHERE u.is_employee = 1
-- GROUP BY u.id, u.name, u.email, u.gender, u.is_Active, u.created_at;
-- END;
EXEC GetEmployees;

-- CREATE PROCEDURE GetEmployeeUsers
-- AS
-- BEGIN
--     SELECT * FROM USERS WHERE is_employee = 1
-- END
EXEC GetEmployeeUsers;

-- CREATE PROCEDURE GetCustomers
-- AS
-- BEGIN
-- SELECT u.id, u.name,u.gender, u.email,u.loyalty_points, MAX(s.created_at) AS 'Last Purchase', COUNT(s.id) AS 'No Purchases Made'
-- FROM USERS u
-- LEFT JOIN SALES s ON s.customer_id = u.id
-- WHERE u.is_employee = 0
-- GROUP BY u.id, u.name,u.email,u.gender,u.loyalty_points;
-- END;

EXEC GetCustomers;

-- CREATE PROCEDURE GetProducts
-- AS
-- BEGIN
-- SELECT id, name, category, price, status, quantity, description, created_at
-- FROM PRODUCTS;
-- END;
EXEC GetProducts;

-- CREATE PROCEDURE GetSalesInformation
-- @customerId CHAR(4) = NULL,
-- @employeeId CHAR(4) = NULL
-- AS
-- BEGIN
-- SELECT s.id, s.created_at AS 'Sale Date', c.name AS 'Customer Name', e.name AS 'Employee Name',
-- s.total_amount AS 'Total Amount', s.state AS 'Status',
-- STRING_AGG(p.name, ', ') WITHIN GROUP (ORDER BY p.name) AS 'Products'
-- FROM SALES s
-- INNER JOIN USERS c ON s.customer_id = c.id
-- INNER JOIN USERS e ON s.employee_id = e.id
-- INNER JOIN SALE_PRODUCTS sp ON s.id = sp.sale_id
-- INNER JOIN PRODUCTS p ON sp.product_id = p.id
-- WHERE (@customerId IS NULL OR s.customer_id = @customerId)
-- AND (@employeeId IS NULL OR s.employee_id = @employeeId)
-- GROUP BY s.id, s.created_at, c.name, e.name, s.total_amount, s.state;
-- END;
EXEC GetSalesInformation;


-- CREATE PROCEDURE MakeSale
--   @payment_method VARCHAR(255),
--   @customer_id CHAR(8),
--   @employee_id CHAR(8),
--   @products_json NVARCHAR(MAX)
-- AS
-- BEGIN
--   SET NOCOUNT ON;

--   DECLARE @sale_id CHAR(8)
--   SET @sale_id = SUBSTRING(CONVERT(VARCHAR(40), NEWID()), 1, 8)

--   DECLARE @total_amount FLOAT
--   SET @total_amount = 0

--   BEGIN TRANSACTION

--   INSERT INTO SALES (id, payment_method, customer_id, employee_id, created_at, updated_at, state, total_amount, payment_status)
--   VALUES (@sale_id, @payment_method, @customer_id, @employee_id, GETDATE(), GETDATE(), 'completed', @total_amount, 'paid')

--   DECLARE @product_id CHAR(8)
--   DECLARE @product_price FLOAT
--   DECLARE @product_quantity INT
--   DECLARE @product_total FLOAT
--   DECLARE @product_status CHAR(8)

--   DECLARE @json NVARCHAR(MAX) = @products_json
--   DECLARE @table TABLE (product_id CHAR(8), product_price FLOAT, product_quantity INT)

--   INSERT INTO @table
--   SELECT product_id, price, quantity
--   FROM OPENJSON(@json)
--   WITH (
--     product_id CHAR(8),
--     price FLOAT,
--     quantity INT
--   )

--   DECLARE product_cursor CURSOR FOR
--   SELECT product_id, product_price, product_quantity
--   FROM @table

--   OPEN product_cursor

--   FETCH NEXT FROM product_cursor INTO @product_id, @product_price, @product_quantity

--   WHILE @@FETCH_STATUS = 0
--   BEGIN
--     SET @product_total = @product_price * @product_quantity
--     SET @product_status = 'sold'
--     SET @total_amount = @total_amount + @product_total

--     INSERT INTO SALE_PRODUCTS (id, sale_id, product_id, status, price, created_at)
--     VALUES (SUBSTRING(CONVERT(VARCHAR(40), NEWID()), 1, 8), @sale_id, @product_id, @product_status, @product_price, GETDATE())

--     FETCH NEXT FROM product_cursor INTO @product_id, @product_price, @product_quantity
--   END

--   CLOSE product_cursor
--   DEALLOCATE product_cursor

--   UPDATE SALES
--   SET total_amount = @total_amount, updated_at = GETDATE()
--   WHERE id = @sale_id

--   COMMIT TRANSACTION

--   SELECT * FROM SALES WHERE id = @sale_id

-- END





-- CREATE PROCEDURE GetDailySales
-- AS
-- BEGIN
-- DECLARE @today_sales FLOAT;
-- DECLARE @yesterday_sales FLOAT;
-- DECLARE @percent_change FLOAT;

-- -- Calculate today's sales
-- SET @today_sales = (
-- SELECT ISNULL(SUM(total_amount), 0)
-- FROM SALES
-- WHERE CONVERT(DATE, created_at) = CONVERT(DATE, GETDATE())
-- );

-- -- Calculate yesterday's sales
-- SET @yesterday_sales = (
-- SELECT ISNULL(SUM(total_amount), 0)
-- FROM SALES
-- WHERE CONVERT(DATE, created_at) = CONVERT(DATE, GETDATE() - 1)
-- );

-- -- Calculate percent change
-- IF @yesterday_sales <> 0
-- SET @percent_change = ((@today_sales - @yesterday_sales) / @yesterday_sales) * 100;
-- ELSE
-- SET @percent_change = 100.0;

-- -- Return results
-- SELECT @today_sales AS [Today's Sales], @percent_change AS [% Change Compared to Yesterday];

-- END

 EXEC GetDailySales;







-- CREATE PROCEDURE get_new_users_today
-- AS
-- BEGIN
--     DECLARE @today DATE
--     DECLARE @yesterday DATE
--     DECLARE @new_users_today INT
--     DECLARE @new_users_yesterday INT
--     DECLARE @percentage_difference FLOAT

--     SET @today = CONVERT(DATE, GETDATE())
--     SET @yesterday = DATEADD(day, -1, @today)

--     SELECT @new_users_today = COUNT(*)
--     FROM USERS
--     WHERE CONVERT(DATE, created_at) = @today

--     SELECT @new_users_yesterday = COUNT(*)
--     FROM USERS
--     WHERE CONVERT(DATE, created_at) = @yesterday

--     SET @percentage_difference = ((@new_users_today - @new_users_yesterday) / CAST(@new_users_yesterday AS FLOAT)) * 100

--     SELECT @new_users_today AS 'New Users Today', @percentage_difference AS 'Percentage Difference'
-- END
EXEC  get_new_users_today

-- CREATE PROCEDURE GetDailyRefundedSalesProducts
-- AS
-- BEGIN
--     DECLARE @today_refunded INT
--     DECLARE @yesterday_refunded INT
--     DECLARE @percent_change DECIMAL(5, 2)

--     SELECT @today_refunded = COUNT(*) FROM SALE_PRODUCTS WHERE status = 'refunded' AND CAST(created_at AS DATE) = CAST(GETDATE() AS DATE)

--     SELECT @yesterday_refunded = COUNT(*) FROM SALE_PRODUCTS WHERE status = 'refunded' AND CAST(created_at AS DATE) = CAST(DATEADD(DAY, -1, GETDATE()) AS DATE)

--     SET @percent_change = CASE WHEN @yesterday_refunded = 0 THEN 100 ELSE ((@today_refunded - @yesterday_refunded) / CAST(@yesterday_refunded AS DECIMAL(10, 2))) * 100 END

--     SELECT @today_refunded AS 'Today''s Refunded Sales Products', @percent_change AS '% Change Compared to Yesterday'
-- END
EXEC  GetDailyRefundedSalesProducts






-- CREATE PROCEDURE GetUserById
--     @userId CHAR(4)
-- AS
-- BEGIN
--     SET NOCOUNT ON;
--     SELECT * FROM USERS WHERE id = @userId;
-- END


--   EXEC ;




-- CREATE PROCEDURE GetProductById
--   @productId CHAR(8)
-- AS
-- BEGIN
--   SELECT * FROM PRODUCTS WHERE id = @productId;GetProductById
-- END


=
-- DROP PROCEDURE IF EXISTS  GetAllCategories;

-- CREATE PROCEDURE GetAllCategories
-- AS
-- BEGIN
--   SELECT DISTINCT category FROM PRODUCTS;
-- END

 EXEC GetAllCategories


-- CREATE PROCEDURE AddProduct
-- @quantity INT,
-- @description TEXT,
-- @name VARCHAR(255),
-- @category VARCHAR(255),
-- @status VARCHAR(20),
-- @price FLOAT
-- AS
-- BEGIN
-- INSERT INTO PRODUCTS (quantity, description, name, category, status, price, created_at, updated_at)
-- VALUES (@quantity, @description, @name, @category, @status, @price, GETDATE(), GETDATE());
-- END
EXEC AddProduct

-- CREATE PROCEDURE UpdateProductById
--   @id CHAR(8),
--   @quantity INT,
--   @description TEXT,
--   @name VARCHAR(255),
--   @category VARCHAR(255),
--   @status VARCHAR(20),
--   @price FLOAT
-- AS
-- BEGIN
--   UPDATE PRODUCTS 
--   SET quantity = @quantity, 
--       description = @description, 
--       name = @name, 
--       category = @category, 
--       status = @status, 
--       price = @price, 
--       updated_at = GETDATE() 
--   WHERE id = @id;
-- END







-- CREATE PROCEDURE UpdateProduct
--   @productId CHAR(8),
--   @quantity INT,
--   @description TEXT,
--   @name VARCHAR(255),
--   @category VARCHAR(255),
--   @status VARCHAR(20),
--   @price FLOAT
-- AS
-- BEGIN
--   UPDATE PRODUCTS 
--   SET quantity = @quantity, 
--       description = @description, 
--       name = @name, 
--       category = @category, 
--       status = @status, 
--       price = @price, 
--       updated_at = GETDATE() 
--   WHERE id = @productId;
-- END

EXEC UpdateProduct '5483C01E', @quantity = 20, @description = 'New description', @name = 'New name', @category = 'sports', @status = 'New status', @price = 9.99;



