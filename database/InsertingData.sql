
INSERT INTO USERS (email, role, is_employee, is_Active, gender, password, image_link, phone_number, name, created_at) VALUES
('johndoe@example.com', 'superAdmin', 1, 1, 'male', 'password123', 'https://example.com/johndoe.jpg', '+1234567890', 'John Doe', GETDATE()),
('janedoe@example.com', 'admin', 1, 1, 'female', 'password456', 'https://example.com/janedoe.jpg', '+0987654321', 'Jane Doe', GETDATE()),
('bobsmith@example.com', 'staff', 1, 1, 'male', 'password789', 'https://example.com/bobsmith.jpg', '+1357908642', 'Bob Smith', GETDATE()),
('alicejones@example.com', 'customer', 0, 1, 'female', NULL, NULL, '+2468013579', 'Alice Jones', GETDATE()),
('davidsmith@example.com', 'customer', 0, 1, 'male', NULL, NULL, '+3698521470', 'David Smith', GETDATE());

INSERT INTO PRODUCTS (quantity, description, name, category, status, price, created_at, updated_at) VALUES
(10, 'This is a high-quality smartphone with a 6.2-inch display, 12-megapixel camera, and 64GB of storage.', 'Samsung Galaxy S20', 'Electronics', 'In stock', 899.99, '2022-03-20 09:30:00', '2022-03-20 09:30:00'),
(5, 'This is a lightweight and durable laptop with a 14-inch display, Intel Core i5 processor, and 256GB SSD.', 'Dell XPS 13', 'Electronics', 'Low stock', 1299.99, '2022-03-19 11:45:00', '2022-03-19 11:45:00'),
(20, 'This is a high-performance desktop computer with an Intel Core i7 processor, 16GB of RAM, and 1TB hard drive.', 'HP Pavilion', 'Electronics', 'In stock', 999.99, '2022-03-18 14:20:00', '2022-03-20 09:30:00'),
(15, 'This is a comfortable and stylish sofa made from high-quality materials.', 'Modern Sofa', 'Furniture', 'In stock', 1499.99, '2022-03-17 16:30:00', '2022-03-20 09:30:00'),
(7, 'This is a durable and spacious backpack with multiple compartments for organization.', 'Hiking Backpack', 'Outdoor Gear', 'Low stock', 79.99, '2022-03-16 18:15:00', '2022-03-19 11:45:00');


SELECT* FROM USERS
SELECT * FROM PRODUCTS

INSERT INTO SALES (payment_method, customer_id, employee_id, created_at, updated_at, state, total_amount, payment_status) VALUES
('Credit Card', 'A46B', 'C6BD', '2022-03-20 10:00:00', '2022-03-20 10:00:00', 'Completed', 1299.99, 'Paid'),
('Debit Card', '3ED1', 'AC92', '2022-03-19 12:00:00', '2022-03-19 12:00:00', 'Refunded', 899.99, 'Paid'),
('Cash', 'A46B', '375F', '2022-03-18 15:00:00', '2022-03-18 15:00:00', 'Completed', 1499.99, 'Paid');

SELECT * FROM SALES



INSERT INTO SALE_PRODUCTS (sale_id, product_id, status, price,created_at) VALUES
('29B37577', '1135A563', 'complete', 799.99, '2022-03-20 10:00:00' ),
('29B37577', '2E032182', 'complete', 499.99, '2022-03-20 10:00:00'),
('29B37577', '6DF02ACD', 'refunded', 999.99, '2023-03-21 10:00:00'),
('52FCE0C4', '429F7C40', 'complete', 199.99,'2023-03-21 15:00:00'),
('52FCE0C4', '89703FB4', 'refunded', 699.99,'2023-03-21 15:00:00'),
('D79E8319', '31AD3B41', 'complete', 149.99,'2023-03-22 15:00:00'),
('D79E8319', '4FF9B21B','refunded', 599.99,'2023-03-22 15:00:00');

SELECT * FROM SALE_PRODUCTS