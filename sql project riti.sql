CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

CREATE TABLE customers (
    customerid INT PRIMARY KEY,
    customername VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    age INT
);

CREATE TABLE products (
    productid INT PRIMARY KEY,
    productname VARCHAR(100),
    category VARCHAR(50),
    subcategory VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE orders (
    orderid INT PRIMARY KEY,
    customerid INT,
    productid INT,
    quantity INT,
    orderdate DATE,
    paymentmode VARCHAR(30),
    FOREIGN KEY (customerid) REFERENCES customers(customerid),
    FOREIGN KEY (productid) REFERENCES products(productid)
);

INSERT INTO customers VALUES
(1, 'Aarav Sharma', 'Mumbai', 'Maharashtra', 24),
(2, 'Priya Patel', 'Pune', 'Maharashtra', 29),
(3, 'Rahul Verma', 'Delhi', 'Delhi', 32),
(4, 'Sneha Iyer', 'Bengaluru', 'Karnataka', 26),
(5, 'Arjun Mehta', 'Ahmedabad', 'Gujarat', 35),
(6, 'Ananya Rao', 'Hyderabad', 'Telangana', 23),
(7, 'Karan Singh', 'Jaipur', 'Rajasthan', 31),
(8, 'Neha Gupta', 'Lucknow', 'Uttar Pradesh', 27),
(9, 'Rohan Desai', 'Nagpur', 'Maharashtra', 28),
(10, 'Isha Nair', 'Kochi', 'Kerala', 25),
(11, 'Vikram Joshi', 'Indore', 'Madhya Pradesh', 34),
(12, 'Meera Shah', 'Surat', 'Gujarat', 30);

INSERT INTO products VALUES
(101, 'Laptop', 'Electronics', 'Computers', 55000),
(102, 'Smartphone', 'Electronics', 'Mobiles', 25000),
(103, 'Headphones', 'Electronics', 'Accessories', 2000),
(104, 'Office Chair', 'Furniture', 'Chairs', 8500),
(105, 'Study Table', 'Furniture', 'Tables', 12000),
(106, 'Running Shoes', 'Fashion', 'Footwear', 3500),
(107, 'Backpack', 'Fashion', 'Bags', 1800),
(108, 'Smart Watch', 'Electronics', 'Wearables', 7000),
(109, 'Water Bottle', 'Lifestyle', 'Accessories', 800),
(110, 'Desk Lamp', 'Lifestyle', 'Home Decor', 1500);

INSERT INTO orders VALUES
(1001, 1, 101, 1, '2026-01-05', 'Credit Card'),
(1002, 2, 103, 2, '2026-01-12', 'UPI'),
(1003, 3, 102, 1, '2026-01-18', 'Debit Card'),
(1004, 4, 106, 2, '2026-02-03', 'UPI'),
(1005, 5, 104, 1, '2026-02-15', 'Credit Card'),
(1006, 1, 108, 1, '2026-02-20', 'UPI'),
(1007, 6, 105, 1, '2026-03-02', 'Debit Card'),
(1008, 7, 107, 3, '2026-03-11', 'Cash'),
(1009, 8, 103, 1, '2026-03-21', 'UPI'),
(1010, 9, 102, 2, '2026-04-04', 'Credit Card'),
(1011, 10, 109, 4, '2026-04-10', 'Cash'),
(1012, 2, 101, 1, '2026-04-22', 'Debit Card'),
(1013, 11, 104, 2, '2026-05-06', 'UPI'),
(1014, 12, 106, 1, '2026-05-14', 'Credit Card'),
(1015, 3, 108, 2, '2026-05-25', 'UPI'),
(1016, 4, 102, 1, '2026-06-03', 'Debit Card'),
(1017, 5, 105, 2, '2026-06-12', 'Credit Card'),
(1018, 6, 103, 3, '2026-06-19', 'UPI'),
(1019, 7, 110, 2, '2026-06-28', 'Cash'),
(1020, 8, 101, 1, '2026-07-05', 'Credit Card'),
(1021, 9, 107, 2, '2026-07-13', 'UPI'),
(1022, 10, 106, 2, '2026-07-20', 'Debit Card'),
(1023, 11, 102, 1, '2026-07-25', 'Credit Card'),
(1024, 12, 108, 1, '2026-08-02', 'UPI'),
(1025, 1, 104, 1, '2026-08-09', 'Debit Card'),
(1026, 2, 109, 3, '2026-08-14', 'Cash'),
(1027, 3, 101, 1, '2026-08-19', 'Credit Card'),
(1028, 4, 107, 2, '2026-08-23', 'UPI'),
(1029, 5, 103, 2, '2026-08-27', 'Debit Card'),
(1030, 6, 110, 1, '2026-08-30', 'Cash');

SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;

SELECT
    COUNT(DISTINCT orderid) AS totalorders,
    COUNT(DISTINCT customerid) AS uniquecustomers,
    SUM(quantity) AS unitssold
FROM orders;

SELECT
    ROUND(SUM(o.quantity * p.price), 2) AS totalrevenue
FROM orders o
JOIN products p ON o.productid = p.productid;

SELECT
    DATE_FORMAT(o.orderdate, '%Y-%m') AS month,
    ROUND(SUM(o.quantity * p.price), 2) AS revenue
FROM orders o
JOIN products p ON o.productid = p.productid
GROUP BY DATE_FORMAT(o.orderdate, '%Y-%m')
ORDER BY month;

SELECT
    p.category,
    SUM(o.quantity) AS unitssold,
    ROUND(SUM(o.quantity * p.price), 2) AS revenue
FROM orders o
JOIN products p ON o.productid = p.productid
GROUP BY p.category
ORDER BY revenue DESC;

SELECT
    p.productname,
    SUM(o.quantity) AS unitssold,
    ROUND(SUM(o.quantity * p.price), 2) AS revenue
FROM orders o
JOIN products p ON o.productid = p.productid
GROUP BY p.productid, p.productname
ORDER BY revenue DESC
LIMIT 5;

SELECT
    c.customername,
    c.city,
    COUNT(DISTINCT o.orderid) AS totalorders,
    ROUND(SUM(o.quantity * p.price), 2) AS totalspent
FROM customers c
JOIN orders o ON c.customerid = o.customerid
JOIN products p ON o.productid = p.productid
GROUP BY c.customerid, c.customername, c.city
ORDER BY totalspent DESC;

SELECT
    c.customerid,
    c.customername
FROM customers c
LEFT JOIN orders o ON c.customerid = o.customerid
WHERE o.orderid IS NULL;
