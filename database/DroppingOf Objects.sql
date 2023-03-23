-- DROP DATABASE crm_system

CREATE DATABASE crm_system;

USE crm_system;
GO

CREATE TABLE USERS (
  id CHAR(4) PRIMARY KEY DEFAULT SUBSTRING(CONVERT(VARCHAR(40), NEWID()), 1, 4),
  email VARCHAR(255) UNIQUE,
  role VARCHAR(20),
  is_employee BIT,
  is_Active BIT,
  gender VARCHAR(10),
  password VARCHAR(255),
  image_link VARCHAR(255),
  phone_number VARCHAR(20),
  name VARCHAR(255),
  created_at DATETIME
);
go


CREATE TABLE PRODUCTS (
  id CHAR(8) PRIMARY KEY DEFAULT SUBSTRING(CONVERT(VARCHAR(40), NEWID()), 1, 8),
  quantity INT,
  description TEXT,
  name VARCHAR(255),
  category VARCHAR(255),
  status VARCHAR(20),
  price FLOAT,
  created_at DATETIME,
  updated_at DATETIME
);
go


CREATE TABLE SALES (
  id CHAR(8) PRIMARY KEY DEFAULT SUBSTRING(CONVERT(VARCHAR(40), NEWID()), 1, 8),
  payment_method VARCHAR(255),
  customer_id CHAR(4),
  employee_id CHAR(4),
  created_at DATETIME,
  updated_at DATETIME,
  state VARCHAR(20),
  total_amount FLOAT,
  payment_status VARCHAR(20),
  FOREIGN KEY (customer_id) REFERENCES USERS(id),
  FOREIGN KEY (employee_id) REFERENCES USERS(id)
);

CREATE TABLE SALE_PRODUCTS (
  id CHAR(8) PRIMARY KEY DEFAULT SUBSTRING(CONVERT(VARCHAR(40), NEWID()), 1, 8),
  sale_id CHAR(8),
  product_id CHAR(8),
  quantity_approved INT,
  quantity_refunded INT,
  price FLOAT,
  FOREIGN KEY (sale_id) REFERENCES SALES(id),
  FOREIGN KEY (product_id) REFERENCES PRODUCTS(id)
);

