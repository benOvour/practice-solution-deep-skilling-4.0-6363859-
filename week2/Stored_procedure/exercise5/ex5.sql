USE EmployeeDB;
GO

-- Drop the procedure if it already exists
IF OBJECT_ID('sp_CountEmployeesInDepartment', 'P') IS NOT NULL
    DROP PROCEDURE sp_CountEmployeesInDepartment;
GO

-- Create the new procedure
CREATE PROCEDURE sp_CountEmployeesInDepartment
    @DepartmentID INT
AS
BEGIN
    SELECT 
        COUNT(*) AS TotalEmployees
    FROM 
        Employees
    WHERE 
        DepartmentID = @DepartmentID;
END;
GO

-- Count employees in Finance (DepartmentID = 2)
EXEC sp_CountEmployeesInDepartment @DepartmentID = 2;
