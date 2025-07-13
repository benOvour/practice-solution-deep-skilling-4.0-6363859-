CREATE DATABASE OnlineRetailDB;

USE OnlineRetailDB;

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);

INSERT INTO Products VALUES
(1, 'Laptop', 'Electronics', 1200.00),
(2, 'Smartphone', 'Electronics', 800.00),
(3, 'Tablet', 'Electronics', 800.00),
(4, 'Headphones', 'Electronics', 150.00),
(5, 'Jeans', 'Clothing', 60.00),
(6, 'T-Shirt', 'Clothing', 25.00),
(7, 'Jacket', 'Clothing', 120.00),
(8, 'Blender', 'Home Appliances', 90.00),
(9, 'Microwave', 'Home Appliances', 150.00),
(10, 'Vacuum Cleaner', 'Home Appliances', 150.00);


SELECT 
    Category,
    ProductName,
    Price,
    ROW_NUMBER() OVER (PARTITION BY Category ORDER BY Price DESC) AS RowNum
FROM Products;

SELECT 
    Category,
    ProductName,
    Price,
    RANK() OVER (PARTITION BY Category ORDER BY Price DESC) AS RankPos
FROM Products;


SELECT 
    Category,
    ProductName,
    Price,
    DENSE_RANK() OVER (PARTITION BY Category ORDER BY Price DESC) AS DenseRankPos
FROM Products;



WITH RankedProducts AS (
    SELECT 
        *,
        ROW_NUMBER() OVER (PARTITION BY Category ORDER BY Price DESC) AS RowNum
    FROM Products
)
SELECT * FROM RankedProducts
WHERE RowNum <= 3;
