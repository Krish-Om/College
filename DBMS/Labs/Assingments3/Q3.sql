-- Active: 1755364395954@@127.0.0.1@3306@assingment3_q3
-- 3. Consider the following relational data model
-- drop DATABASE assingment3_q3;
CREATE DATABASE assingment3_q3;

USE assingment3_q3;

-- a. Write the SQL statements required to create above relations, including appropriate versions of all
-- primary and foreign key integrity constraints.
-- Employee( empid, ename, age, salary)
CREATE TABLE
    Employee (
        emp_id INT PRIMARY KEY,
        ename VARCHAR(50),
        age INT,
        salary NUMERIC
    );

-- Department(deptid, dname, budget, managerid)
CREATE TABLE
    Department (
        dept_id INT PRIMARY KEY,
        dname VARCHAR(50),
        budget NUMERIC,
        manager_id INT,
        Foreign Key (manager_id) REFERENCES Employee (emp_id)
    );

-- Works(empid, deptid, hours)
CREATE TABLE
    Works (
        emp_id INT,
        dept_id INT,
        PRIMARY KEY (emp_id, dept_id),
        FOREIGN KEY (emp_id) REFERENCES Employee (emp_id),
        FOREIGN KEY (dept_id) REFERENCES Department (dept_id),
        hours INT
    );

-- Insert data into Employee table
INSERT INTO
    Employee (emp_id, ename, age, salary)
VALUES
    (1, 'John Smith', 48, 75000), -- Will get 20% raise (age between 45-50)
    (2, 'Sarah Johnson', 35, 85000),
    (3, 'Michael Brown', 47, 95000), -- Will get 20% raise (age between 45-50)
    (4, 'Lisa Davis', 52, 120000), -- Highest salary
    (5, 'Robert Wilson', 46, 65000), -- Will get 20% raise (age between 45-50)
    (6, 'Emily Taylor', 39, 70000);

-- Insert data into Department table
INSERT INTO
    Department (dept_id, dname, budget, manager_id)
VALUES
    (1, 'IT', 500000, 1),
    (2, 'HR', 300000, 2),
    (3, 'Finance', 800000, 4),
    (4, 'Marketing', 400000, 3);

-- Insert data into Works table
INSERT INTO
    Works (emp_id, dept_id, hours)
VALUES
    (1, 1, 40), -- IT Department
    (2, 2, 35), -- HR Department
    (3, 3, 45), -- Finance Department
    (4, 3, 50), -- Finance Department (highest paid employee)
    (5, 4, 38), -- Marketing Department
    (6, 1, 42);

-- IT Department
-- b. Write an expression in SQL to find the department whose employee earns the maximum salary.
SELECT
    d.dname
FROM
    Department d
    JOIN Works w ON d.dept_id = w.dept_id
    JOIN Employee e ON w.emp_id = e.emp_id
WHERE
    e.salary = (
        SELECT
            MAX(salary)
        FROM
            Employee
    );

-- c. Write SQL to find the name of employee, department name and no. of hours they work.
SELECT
    `Employee`.ename,
    `Department`.dname,
    `Works`.hours
FROM
    `Employee`
    JOIN `Works` ON `Employee`.emp_id = `Works`.emp_id
    JOIN `Department` ON `Works`.dept_id = `Department`.dept_id;

-- d. Write an expression in SQL to give every employee a 20% raise in salary whose age is in between 45
-- to 50 years
UPDATE `Employee`
SET
    salary = salary + 0.2 * salary
WHERE
    age BETWEEN 45 AND 50;