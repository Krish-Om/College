-- 2. Consider an employee database, where the primary keys are underlined.
-- employee (employee_name, street, city)
-- works (employee_name, company_name, salary)
-- company (company_name, city)
-- manages (employee_name, manager_name)
-- Give an expression in SQL for each of the following queries
-- DROP DATABASE employee;
-- CREATE DATABASE employee;
USE employee;

CREATE TABLE
    employee (
        employee_name VARCHAR(50) PRIMARY KEY,
        street INT,
        city VARCHAR(50)
    );

CREATE TABLE
    company (
        company_name VARCHAR(50) PRIMARY KEY,
        city VARCHAR(50)
    );

CREATE TABLE
    works (
        employee_name VARCHAR(50),
        company_name VARCHAR(50),
        salary FLOAT,
        FOREIGN KEY (employee_name) REFERENCES employee (employee_name),
        Foreign Key (company_name) REFERENCES company (company_name)
    );

CREATE TABLE
    manages (
        employee_name VARCHAR(50),
        manager_name VARCHAR(50),
        Foreign Key (employee_name) REFERENCES employee (employee_name)
    );

-- Insert sample data into the employee table
INSERT INTO
    employee (employee_name, street, city)
VALUES
    ('John Smith', 101, 'New York'),
    ('Emily Johnson', 202, 'Chicago'),
    ('Michael Brown', 303, 'New York'),
    ('Sarah Davis', 404, 'Boston'),
    ('David Wilson', 505, 'Chicago'),
    ('Jessica Lee', 101, 'New York'),
    ('Robert Taylor', 606, 'Boston'),
    ('Jennifer White', 707, 'Chicago'),
    ('James Anderson', 808, 'New York'),
    ('Lisa Martinez', 909, 'Boston');

-- Insert sample data into the company table
INSERT INTO
    company (company_name, city)
VALUES
    ('ABC Bank', 'New York'),
    ('XYZ Corp', 'Chicago'),
    ('Tech Solutions', 'Boston'),
    ('Global Finance', 'New York'),
    ('Innovative Systems', 'Chicago');

-- Insert sample data into the works table
INSERT INTO
    works (employee_name, company_name, salary)
VALUES
    ('John Smith', 'ABC Bank', 75000),
    ('Emily Johnson', 'XYZ Corp', 82000),
    ('Michael Brown', 'ABC Bank', 65000),
    ('Sarah Davis', 'Tech Solutions', 90000),
    ('David Wilson', 'XYZ Corp', 78000),
    ('Jessica Lee', 'ABC Bank', 67000),
    ('Robert Taylor', 'Tech Solutions', 95000),
    ('Jennifer White', 'Global Finance', 85000),
    ('James Anderson', 'ABC Bank', 72000),
    ('Lisa Martinez', 'Innovative Systems', 88000);

-- Insert sample data into the manages table
INSERT INTO
    manages (employee_name, manager_name)
VALUES
    ('Michael Brown', 'John Smith'),
    ('Jessica Lee', 'John Smith'),
    ('James Anderson', 'John Smith'),
    ('Emily Johnson', 'David Wilson'),
    ('Sarah Davis', 'Robert Taylor'),
    ('Jennifer White', 'Lisa Martinez');

-- a. Find the names of all employees who work for ABC Bank.
SELECT
    employee_name
FROM
    works
WHERE
    company_name = "ABC Bank";

-- b. Find the name and cities of residence of all employees who work for ABC Bank.
select
    *
from
    works
    join company on works.company_name = company.company_name
WHERE
    works.company_name = 'ABC Bank';

-- c. Find all employees in the database who live in the same cities and on the same street as do their
-- managers.
SELECT
    e.employee_name
FROM
    employee e
    JOIN manages m ON e.employee_name = m.employee_name
    JOIN employee mgr ON m.manager_name = mgr.employee_name
WHERE
    e.city = mgr.city
    AND e.street = mgr.street;

-- d. Give all employees of ABC Bank a 10% raise.
UPDATE works
SET
    salary = salary + 0.10 * salary
WHERE
    company_name = 'ABC Bank';

SELECT
    *
FROM
    works;