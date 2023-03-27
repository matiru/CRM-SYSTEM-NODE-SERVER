INSERT INTO USERS (email, role, is_employee, is_Active, gender, password, image_link, phone_number, name, created_at, loyalty_points)
VALUES
('johndoe@example.com', 'superAdmin', 1, 1, 'male', 'password123', 'https://example.com/johndoe.jpg', '+1234567890', 'John Doe', GETDATE(), NULL),
('janedoe@example.com', 'admin', 1, 1, 'female', 'password456', 'https://example.com/janedoe.jpg', '+0987654321', 'Jane Doe', GETDATE(), NULL),
('bobsmith@example.com', 'staff', 1, 1, 'male', 'password789', 'https://example.com/bobsmith.jpg', '+1357908642', 'Bob Smith', GETDATE(), NULL),
('alicejones@example.com', 'customer', 0, 1, 'female', NULL, NULL, '+2468013579', 'Alice Jones', GETDATE(), 100),
('davidsmith@example.com', 'customer', 0, 1, 'male', NULL, NULL, '+3698521470', 'David Smith', GETDATE(), 50),
('janedoe2@example.com', 'admin', 1, 1, 'female', 'password123', 'https://example.com/janedoe2.jpg', '+1234567890', 'Jane Doe 2', GETDATE(), NULL),
('bobsmith2@example.com', 'staff', 1, 1, 'male', 'password456', 'https://example.com/bobsmith2.jpg', '+0987654321', 'Bob Smith 2', GETDATE(), NULL),
('alicejones2@example.com', 'customer', 0, 1, 'female', NULL, NULL, '+1357908642', 'Alice Jones 2', GETDATE(), 150),
('davidsmith2@example.com', 'customer', 0, 1, 'male', NULL, NULL, '+3698521470', 'David Smith 2', GETDATE(), 75);


INSERT INTO PRODUCTS (quantity, description, name, category, status, price, created_at, updated_at) VALUES
(10, 'This is a high-quality smartphone with a 6.2-inch display, 12-megapixel camera, and 64GB of storage.', 'Samsung Galaxy S20', 'Electronics', 'In stock', 899.99, '2022-03-20 09:30:00', '2022-03-20 09:30:00'),
(5, 'This is a lightweight and durable laptop with a 14-inch display, Intel Core i5 processor, and 256GB SSD.', 'Dell XPS 13', 'Electronics', 'Low stock', 1299.99, '2022-03-19 11:45:00', '2022-03-19 11:45:00'),
(20, 'This is a high-performance desktop computer with an Intel Core i7 processor, 16GB of RAM, and 1TB hard drive.', 'HP Pavilion', 'Electronics', 'In stock', 999.99, '2022-03-18 14:20:00', '2022-03-20 09:30:00'),
(15, 'This is a comfortable and stylish sofa made from high-quality materials.', 'Modern Sofa', 'Furniture', 'In stock', 1499.99, '2022-03-17 16:30:00', '2022-03-20 09:30:00'),
(7, 'This is a durable and spacious backpack with multiple compartments for organization.', 'Hiking Backpack', 'Outdoor Gear', 'Low stock', 79.99, '2022-03-16 18:15:00', '2022-03-19 11:45:00');


SELECT* FROM USERS
SELECT * FROM PRODUCTS

INSERT INTO SALES (payment_method, customer_id, employee_id, created_at, updated_at, state, total_amount, payment_status) VALUES
('Credit Card', '389E', '3A07', '2022-03-20 10:00:00', '2022-03-20 10:00:00', 'Completed', 1299.99, 'Paid'),
('Debit Card', '4C5F', '48EF', '2022-03-19 12:00:00', '2022-03-19 12:00:00', 'Refunded', 899.99, 'Paid'),
('Cash', '8401', 'B6DC', '2022-03-18 15:00:00', '2022-03-18 15:00:00', 'Completed', 1499.99, 'Paid');

SELECT * FROM SALES



INSERT INTO SALE_PRODUCTS (sale_id, product_id, status, price,created_at) VALUES
('355E44A3', '1135A563', 'complete', 799.99, '2022-03-20 10:00:00' ),
('355E44A3', '2E032182', 'complete', 499.99, '2022-03-20 10:00:00'),
('55B47551', '6DF02ACD', 'refunded', 999.99, '2023-03-21 10:00:00'),
('55B47551', '429F7C40', 'complete', 199.99,'2023-03-21 15:00:00'),
('55B47551', '89703FB4', 'refunded', 699.99,'2023-03-21 15:00:00'),
('CD7511E9', '31AD3B41', 'complete', 149.99,'2023-03-22 15:00:00'),
('CD7511E9', '4FF9B21B','refunded', 599.99,'2023-03-22 15:00:00');

SELECT * FROM SALE_PRODUCTS