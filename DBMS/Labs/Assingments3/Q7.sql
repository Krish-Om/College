-- 7. Consider the following relational schema:
-- Employee(Ename, street, city)
-- Works(Ename, company_name, salary)
-- Company(Company_name, city)
-- Manages(Ename, manager_name)
CREATE DATABASE IF NOT EXISTS EmployeeManagement;

USE EmployeeManagement;

-- a) i. Create Employee and Works relation with primary key and foreign key constraints.
CREATE TABLE
    Employee (
        Ename VARCHAR(50) PRIMARY KEY,
        street VARCHAR(100),
        city VARCHAR(50)
    );

CREATE TABLE
    Company (
        Company_name VARCHAR(50) PRIMARY KEY,
        city VARCHAR(50)
    );

CREATE TABLE
    Works (
        Ename VARCHAR(50),
        company_name VARCHAR(50),
        salary DECIMAL(10, 2),
        PRIMARY KEY (Ename),
        FOREIGN KEY (Ename) REFERENCES Employee (Ename),
        FOREIGN KEY (company_name) REFERENCES Company (Company_name)
    );

CREATE TABLE
    Manages (
        Ename VARCHAR(50),
        manager_name VARCHAR(50),
        PRIMARY KEY (Ename),
        FOREIGN KEY (Ename) REFERENCES Employee (Ename),
        FOREIGN KEY (manager_name) REFERENCES Employee (Ename)
    );

-- Insert sample data into Employee table
INSERT INTO
    Employee (Ename, street, city)
VALUES
    ('John Smith', 'Lazimpat', 'Ktm'),
    ('Sara Jones', 'Baluwatar', 'Ktm'),
    ('Michael Brown', 'Thamel', 'Ktm'),
    ('Emily Davis', 'New Road', 'Ktm'),
    ('Ram Sharma', 'Lakeside', 'Pokhara'),
    ('Sita Thapa', 'Chitwan Road', 'Bharatpur'),
    ('Hari KC', 'Main Road', 'Birgunj'),
    ('Gita Rai', 'Center Road', 'Biratnagar'),
    ('Bikash Shrestha', 'Station Road', 'Janakpur'),
    ('Mina Gurung', 'Hill Road', 'Butwal'),
    ('Raj Kumar', 'Temple Street', 'Hetauda'),
    ('Anita Singh', 'Market Area', 'Dhankuta'),
    ('Suresh Thapa', 'Ring Road', 'Nepalgunj');

-- Insert sample data into Company table
INSERT INTO
    Company (Company_name, city)
VALUES
    ('NMB Bank', 'Ktm'),
    ('Nepal Telecom', 'Ktm'),
    ('Himalayan Airlines', 'Ktm'),
    ('Pokhara University', 'Pokhara'),
    ('Chitwan Medical College', 'Bharatpur'),
    ('Birgunj Sugar Factory', 'Birgunj'),
    ('Biratnagar Jute Mills', 'Biratnagar'),
    ('Janakpur Cigarette Factory', 'Janakpur'),
    ('Butwal Power Company', 'Butwal'),
    ('Hetauda Cement', 'Hetauda'),
    ('Dhankuta Food Corp', 'Dhankuta'),
    ('Nepalgunj Oil Depot', 'Nepalgunj');

-- Insert sample data into Works table
INSERT INTO
    Works (Ename, company_name, salary)
VALUES
    ('John Smith', 'NMB Bank', 35000),
    ('Sara Jones', 'NMB Bank', 28000),
    ('Michael Brown', 'Nepal Telecom', 42000),
    ('Emily Davis', 'Himalayan Airlines', 32000),
    ('Ram Sharma', 'Pokhara University', 31000),
    ('Sita Thapa', 'Chitwan Medical College', 36000),
    ('Hari KC', 'Birgunj Sugar Factory', 25000),
    ('Gita Rai', 'Biratnagar Jute Mills', 27000),
    (
        'Bikash Shrestha',
        'Janakpur Cigarette Factory',
        29000
    ),
    ('Mina Gurung', 'Butwal Power Company', 34000),
    ('Raj Kumar', 'Hetauda Cement', 26000),
    ('Anita Singh', 'Dhankuta Food Corp', 24000),
    ('Suresh Thapa', 'Nepalgunj Oil Depot', 23000);

-- Insert sample data into Manages table
INSERT INTO
    Manages (Ename, manager_name)
VALUES
    ('Sara Jones', 'John Smith'),
    ('Michael Brown', 'John Smith'),
    ('Emily Davis', 'John Smith'),
    ('Sita Thapa', 'Ram Sharma'),
    ('Gita Rai', 'Bikash Shrestha'),
    ('Mina Gurung', 'Bikash Shrestha'),
    ('Raj Kumar', 'Bikash Shrestha'),
    ('Anita Singh', 'Suresh Thapa'),
    ('Hari KC', 'Suresh Thapa');

-- a) Write relational algebra queries to:
-- i. Find the employee name who work in 'NMB bank'
-- Relational Algebra: π Ename (σ company_name='NMB bank' (Works))
-- SQL Query
SELECT
    Ename
FROM
    Works
WHERE
    company_name = 'NMB Bank';

-- ii. Find all the employee names who live in the same city as their company is located
-- Relational Algebra: π Employee.Ename (Employee ⋈ Works ⋈ Company WHERE Employee.city = Company.city)
-- SQL Query
SELECT
    e.Ename
FROM
    Employee e
    JOIN Works w ON e.Ename = w.Ename
    JOIN Company c ON w.company_name = c.Company_name
WHERE
    e.city = c.city;

-- iii. Find the name and city of those employees whose salary is greater than 30000 and lives in 'Ktm' city
-- Relational Algebra: π Ename, city (σ salary > 30000 ∧ city = 'Ktm' (Employee ⋈ Works))
-- SQL Query
SELECT
    e.Ename,
    e.city
FROM
    Employee e
    JOIN Works w ON e.Ename = w.Ename
WHERE
    w.salary > 30000
    AND e.city = 'Ktm';

-- b) Write SQL queries for the following:
-- i. Create Employee and Works relation with primary key and foreign key constraints.
-- (Already done at the beginning of the script)
-- ii. Find the employee_name, their company name and city name which ends with 'pur' as substring
SELECT
    e.Ename,
    w.company_name,
    e.city
FROM
    Employee e
    JOIN Works w ON e.Ename = w.Ename
WHERE
    e.city LIKE '%pur';

-- iii. Increase the salary of each employee by 25% whose salary is less than 30000
UPDATE Works
SET
    salary = salary * 1.25
WHERE
    salary < 30000;