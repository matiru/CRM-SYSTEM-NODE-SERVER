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
-- DROP PROCEDURE IF EXISTS GetCustomers;



-- CREATE PROCEDURE GetCustomers
-- AS
-- BEGIN
-- SELECT u.id, u.name,u.gender, u.email, MAX(s.created_at) AS 'Last Purchase', COUNT(s.id) AS 'No Purchases Made'
-- FROM USERS u
-- LEFT JOIN SALES s ON s.customer_id = u.id
-- WHERE u.is_employee = 0
-- GROUP BY u.id, u.name,u.email,u.gender;
-- END;
EXEC GetCustomers;



-- -- Procedure to retrieve product information
-- CREATE PROCEDURE GetProducts
-- AS
-- BEGIN
-- SELECT id, name, category, price, status, quantity, description, created_at
-- FROM PRODUCTS;
-- END;
EXEC GetProducts;


-- DROP PROCEDURE IF EXISTS GetSaleInfo;
-- Procedure to retrieve sales information

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
-- DROP PROCEDURE IF EXISTS GetDailyRefundedSalesProducts;



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






--  CREATE PROCEDURE AddNewEmployee
--     @email VARCHAR(255),
--     @password VARCHAR(255),
--     @gender VARCHAR(10),
--     @image_link VARCHAR(255),
--     @phone_number VARCHAR(20),
--     @name VARCHAR(255)
-- AS
-- BEGIN
--     SET NOCOUNT ON;

--     INSERT INTO USERS (
--         email,
--         role,
--         is_employee,
--         is_active,
--         gender,
--         password,
--         image_link,
--         phone_number,
--         name,
--         created_at
--     )
--     VALUES (
--         @email,
--         'employee',
--         1,
--         1,
--         @gender,
--         @password,
--         @image_link,
--         @phone_number,
--         @name,
--         GETDATE()
--     )
-- END




-- CREATE PROCEDURE AddNewCustomer
--     @email VARCHAR(255),
--     @gender VARCHAR(10),
--     @phone_number VARCHAR(20),
--     @name VARCHAR(255)
-- AS
-- BEGIN
--     SET NOCOUNT ON;

--     INSERT INTO USERS (
--         email,
--         role,
--         is_employee,
--         is_active,
--         gender,
--         phone_number,
--         name,
--         created_at
--     )
--     VALUES (
--         @email,
--         'customer',
--         0,
--         1,
--         @gender,
--         @phone_number,
--         @name,
--         GETDATE()
--     )
-- END



-- CREATE PROCEDURE AddNewProduct
--     @sale_id CHAR(8),
--     @product_id CHAR(8),
--     @status CHAR(8),
--     @price FLOAT
-- AS
-- BEGIN
--     SET NOCOUNT ON;

--     INSERT INTO SALE_PRODUCTS (
--         sale_id,
--         product_id,
--         status,
--         price,
--         created_at
--     )
--     VALUES (
--         @sale_id,
--         @product_id,
--         @status,
--         @price,
--         GETDATE()
--     )
-- END


-- CREATE PROCEDURE UpdateProductDetails
--     @id CHAR(8),
--     @status CHAR(8) = NULL,
--     @price FLOAT = NULL
-- AS
-- BEGIN
--     SET NOCOUNT ON;

--     UPDATE SALE_PRODUCTS
--     SET
--         status = ISNULL(@status, status),
--         price = ISNULL(@price, price)
--     WHERE
--         id = @id
-- END
