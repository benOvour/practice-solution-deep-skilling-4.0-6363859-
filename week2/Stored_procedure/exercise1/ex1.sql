-- Drop stored procedures if they exist
IF OBJECT_ID('sp_GetEmployeesByDepartment', 'P') IS NOT NULL
    DROP PROCEDURE sp_GetEmployeesByDepartment;
GO

IF OBJECT_ID('sp_InsertEmployee', 'P') IS NOT NULL
    DROP PROCEDURE sp_InsertEmployee;
GO

-- Drop tables if they exist
IF OBJECT_ID('Employees', 'U') IS NOT NULL
    DROP TABLE Employees;
GO

IF OBJECT_ID('Departments', 'U') IS NOT NULL
    DROP TABLE Departments;
GO

-- Drop database if exists
IF DB_ID('EmployeeDB') IS NOT NULL
BEGIN
    ALTER DATABASE EmployeeDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE EmployeeDB;
END
GO

-- Now start fresh
CREATE DATABASE EmployeeDB;
GO

USE EmployeeDB;
GO

-- Departments Table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);

-- Employees Table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1), -- Use IDENTITY to avoid manual insertion
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DepartmentID INT FOREIGN KEY REFERENCES Departments(DepartmentID),
    Salary DECIMAL(10,2),
    JoinDate DATE
);

-- Insert Departments
INSERT INTO Departments (DepartmentID, DepartmentName) VALUES 
(1, 'HR'), 
(2, 'Finance'), 
(3, 'IT'), 
(4, 'Marketing');

-- Insert Employees
INSERT INTO Employees (FirstName, LastName, DepartmentID, Salary, JoinDate) VALUES 
('John', 'Doe', 1, 5000.00, '2020-01-15'), 
('Jane', 'Smith', 2, 6000.00, '2019-03-22'), 
('Michael', 'Johnson', 3, 7000.00, '2018-07-30'), 
('Emily', 'Davis', 4, 5500.00, '2021-11-05');

GO

-- Create sp_GetEmployeesByDepartment
CREATE PROCEDURE sp_GetEmployeesByDepartment
    @DepartmentID INT
AS
BEGIN
    SELECT 
        E.EmployeeID,
        E.FirstName,
        E.LastName,
        E.Salary,
        E.JoinDate,
        D.DepartmentName
    FROM 
        Employees E
    INNER JOIN 
        Departments D ON E.DepartmentID = D.DepartmentID
    WHERE 
        E.DepartmentID = @DepartmentID;
END;
GO

-- Create sp_InsertEmployee
CREATE PROCEDURE sp_InsertEmployee 
    @FirstName VARCHAR(50), 
    @LastName VARCHAR(50), 
    @DepartmentID INT, 
    @Salary DECIMAL(10,2), 
    @JoinDate DATE 
AS 
BEGIN 
    INSERT INTO Employees (FirstName, LastName, DepartmentID, Salary, JoinDate) 
    VALUES (@FirstName, @LastName, @DepartmentID, @Salary, @JoinDate); 
END;
GO

-- Execute Insert
EXEC sp_InsertEmployee 
    @FirstName = 'Alice',
    @LastName = 'Brown',
    @DepartmentID = 2,
    @Salary = 6200.00,
    @JoinDate = '2022-06-10';

-- Execute Select
EXEC sp_GetEmployeesByDepartment @DepartmentID = 3;
