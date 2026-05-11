DROP DATABASE IF EXISTS hackathon_007;
CREATE DATABASE IF NOT EXISTS hackathon_007;
USE hackathon_007;

CREATE TABLE Customers (
    customer_id VARCHAR(5) PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15) NOT NULL UNIQUE
);

CREATE TABLE Brands (
    brand_id VARCHAR(5) PRIMARY KEY,
    brand_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Products (
    product_id VARCHAR(5) PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL UNIQUE,
    brand_id VARCHAR(5) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL,
    FOREIGN KEY (brand_id) REFERENCES Brands(brand_id)
);

CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id VARCHAR(5) NOT NULL,
    product_id VARCHAR(5) NOT NULL,
    status VARCHAR(20) NOT NULL,
    order_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO Customers (customer_id, full_name, email, phone) VALUES
('C01', 'Nguyễn Văn An', 'an.nv@gmail.com', '0911111111'),
('C02', 'Nguyễn Thị Mai', 'mai.nt@gmail.com', '0922222222'),
('C03', 'Trần Quang Hải', 'hai.tq@gmail.com', '0933333333'),
('C04', 'Phạm Bảo Ngọc', 'ngoc.pb@gmail.com', '0944444444'),
('C05', 'Vũ Đức Đam', 'dam.vd@gmail.com', '0955555555');

INSERT INTO Brands (brand_id, brand_name) VALUES
('B01', 'Apple'),
('B02', 'Samsung'),
('B03', 'Sony'),
('B04', 'Dell');

INSERT INTO Products (product_id, product_name, brand_id, price, stock) VALUES
('P01', 'iPhone 15 Pro Max', 'B01', 30000000.00, 10),
('P02', 'MacBook Pro M3', 'B01', 45000000.00, 5),
('P03', 'Galaxy S24 Ultra', 'B02', 25000000.00, 20),
('P04', 'PlayStation 5', 'B03', 15000000.00, 8),
('P05', 'Dell XPS 15', 'B04', 35000000.00, 15);

INSERT INTO Orders (order_id, customer_id, product_id, status, order_date) VALUES
(1, 'C01', 'P01', 'Pending', '2025-10-01'),
(2, 'C02', 'P03', 'Completed', '2025-10-02'),
(3, 'C01', 'P02', 'Completed', '2025-10-03'),
(4, 'C04', 'P05', 'Cancelled', '2025-10-04'),
(5, 'C05', 'P01', 'Pending', '2025-10-05');

SET SQL_SAFE_UPDATES = 0;

UPDATE Products 
SET stock = stock + 10, 
    price = price * 1.05 
WHERE product_name = 'Dell XPS 15';

UPDATE Customers 
SET phone = '0999999999' 
WHERE customer_id = 'C03';

DELETE FROM Orders 
WHERE status = 'Completed' 
  AND order_date < '2025-10-03';

SET SQL_SAFE_UPDATES = 1;

SELECT product_id, product_name, price 
FROM Products 
WHERE price BETWEEN 15000000 AND 30000000 
  AND stock > 0;

SELECT full_name, email 
FROM Customers 
WHERE full_name LIKE 'Nguyễn%';

SELECT order_id, customer_id, order_date 
FROM Orders 
ORDER BY order_date DESC;

SELECT product_id, product_name, price 
FROM Products 
ORDER BY price DESC 
LIMIT 3;

SELECT product_name, stock 
FROM Products 
LIMIT 2 OFFSET 2;

SELECT o.order_id, c.full_name, p.product_name, o.order_date
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN Products p ON o.product_id = p.product_id
WHERE o.status = 'Pending';

SELECT b.brand_name, p.product_name
FROM Brands b
LEFT JOIN Products p ON b.brand_id = p.brand_id
ORDER BY b.brand_name;

SELECT status, COUNT(*) AS total_orders
FROM Orders 
GROUP BY status;

SELECT c.full_name, COUNT(o.order_id) AS so_don_hang
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.full_name
HAVING COUNT(o.order_id) >= 2;

SELECT product_id, product_name, price
FROM Products
WHERE price < (SELECT AVG(price) FROM Products);

SELECT DISTINCT c.full_name, c.phone
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Products p ON o.product_id = p.product_id
WHERE p.product_name = 'iPhone 15 Pro Max';