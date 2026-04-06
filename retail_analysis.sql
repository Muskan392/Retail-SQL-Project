-- Retail sales analysis project

-- creating database
CREATE DATABASE retail_db;

-- using the database
USE retail_db;

-- customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50)
);

-- products table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    price INT
);

-- orders table (main table for analysis)
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    order_date DATE,

    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- inserting some sample data

INSERT INTO customers VALUES
(1, 'Muskan', 'Delhi'),
(2, 'Aman', 'Mumbai'),
(3, 'Riya', 'Pune');

INSERT INTO products VALUES
(101, 'Laptop', 50000),
(102, 'Phone', 20000),
(103, 'Headphones', 2000);

INSERT INTO orders VALUES
(1, 1, 101, 1, '2024-04-01'),
(2, 2, 102, 2, '2024-04-02'),
(3, 1, 103, 3, '2024-04-03'),
(4, 3, 101, 1, '2024-04-04');

-- just checking if data is inserted properly
SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;

-- joining tables to see who bought what
SELECT c.name, p.product_name, o.quantity
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id;

-- calculating total amount spent by each customer
SELECT c.name,
       SUM(p.price * o.quantity) AS total_spent
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id
GROUP BY c.name;

-- finding the top customer (highest spender)
SELECT c.name,
       SUM(p.price * o.quantity) AS total_spent
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id
GROUP BY c.name
ORDER BY total_spent DESC
LIMIT 1;

-- checking which product is sold the most
SELECT p.product_name,
       SUM(o.quantity) AS total_sold
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_name;

-- end of project