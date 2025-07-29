CREATE DATABASE lab5_q3;

-- DROP DATABASE lab5_q3;
USE lab5_q3;

CREATE Table
    Employee (
        person_name VARCHAR(30) PRIMARY KEY,
        street VARCHAR(50),
        city VARCHAR(30)
    );

CREATE TABLE
    Works (
        person_name VARCHAR(30) PRIMARY KEY,
        company_name VARCHAR(50),
        salary numeric
    );

CREATE Table
    Company (
        company_name VARCHAR(50) PRIMARY KEY,
        city VARCHAR(50)
    );

CREATE TABLE
    Manages (
        person_name VARCHAR(30) PRIMARY KEY,
        manager_name VARCHAR(30)
    );

-- Insert into Employee
insert into
    Employee
values
    ('Alice', 'Maple St', 'Springfield');

insert into
    Employee
values
    ('Bob', 'Oak Ave', 'Metropolis');

insert into
    Employee
values
    ('Charlie', 'Pine Rd', 'Springfield');

insert into
    Employee
values
    ('Diana', 'Elm St', 'Gotham');

insert into
    Employee
values
    ('Eve', 'Maple St', 'Springfield');

-- Manager of Alice
-- Insert into Works
insert into
    Works
values
    ('Alice', 'First Bank Corporation', 12000);

insert into
    Works
values
    ('Bob', 'Small Bank Corporation', 9500);

insert into
    Works
values
    ('Charlie', 'First Bank Corporation', 11000);

insert into
    Works
values
    ('Diana', 'First Bank Corporation', 9000);

insert into
    Works
values
    ('Eve', 'Tech Corp', 15000);

-- Insert into Company
insert into
    Company
values
    ('First Bank Corporation', 'Springfield');

insert into
    Company
values
    ('Small Bank Corporation', 'Metropolis');

insert into
    Company
values
    ('Tech Corp', 'Gotham');

-- Insert into Manages
insert into
    Manages
values
    ('Alice', 'Eve');

-- Alice managed by Eve (same address)
insert into
    Manages
values
    ('Bob', 'Charlie');

-- Bob managed by Charlie (different address)
insert into
    Manages
values
    ('Charlie', 'Eve');

-- Charlie managed by Eve (different address)
insert into
    Manages
values
    ('Diana', 'Bob');

-- Diana managed by Bob (different address)
-- INSERT INTO Employee VALUES
-- ('John Smith', '123 Main St', 'New York'),
-- ('Sarah Johnson', '456 Oak Ave', 'Boston'),
-- ('Michael Brown', '789 Pine Rd', 'Chicago'),
-- ('Emily Davis', '321 Maple Dr', 'Boston'),
-- ('James Wilson', '654 Cedar Ln', 'New York'),
-- ('Lisa Anderson', '987 Birch St', 'Chicago'),
-- ('David Taylor', '147 Elm St', 'New York'),
-- ('Jennifer Lee', '258 Pine St', 'Boston'),
-- ('Robert Martin', '369 Oak Dr', 'Chicago'),
-- ('Amy White', '741 Cedar Ave', 'New York');
-- INSERT INTO Works VALUES
-- ('John Smith', 'First Bank Corporation', 75000),
-- ('Sarah Johnson', 'Small Bank Corporation', 65000),
-- ('Michael Brown', 'First Bank Corporation', 85000),
-- ('Emily Davis', 'Small Bank Corporation', 60000),
-- ('James Wilson', 'First Bank Corporation', 90000),
-- ('Lisa Anderson', 'Big Bank Corporation', 70000),
-- ('David Taylor', 'First Bank Corporation', 80000),
-- ('Jennifer Lee', 'Small Bank Corporation', 62000),
-- ('Robert Martin', 'Big Bank Corporation', 72000),
-- ('Amy White', 'First Bank Corporation', 68000);
-- INSERT INTO Company VALUES
-- ('First Bank Corporation', 'New York'),
-- ('Small Bank Corporation', 'Boston'),
-- ('Big Bank Corporation', 'Chicago'),
-- ('Tech Corp', 'New York'),
-- ('Digital Solutions', 'Boston'),
-- ('Global Systems', 'Chicago'),
-- ('Data Inc', 'New York'),
-- ('Software Corp', 'Boston'),
-- ('Tech Solutions', 'Chicago'),
-- ('Systems Inc', 'New York');
-- INSERT INTO Manages VALUES
-- ('John Smith', 'James Wilson'),
-- ('Sarah Johnson', 'Jennifer Lee'),
-- ('Michael Brown', 'John Smith'),
-- ('Emily Davis', 'Sarah Johnson'),
-- ('James Wilson', 'Robert Martin'),
-- ('Lisa Anderson', 'Michael Brown'),
-- ('David Taylor', 'James Wilson'),
-- ('Jennifer Lee', 'Emily Davis'),
-- ('Robert Martin', 'Lisa Anderson'),
-- ('Amy White', 'David Taylor');
SELECT
    person_name
FROM
    Works
where
    company_name = 'First Bank Corporation';

SELECT
    E1.person_name
FROM
    Employee as E1,
    Employee as E2,
    Manages as M
WHERE
    E1.person_name = M.person_name
    and E2.person_name = M.manager_name
    and E1.street = E2.street
    and E1.city = E2.city;

SELECT
    *
FROM
    `Employee`
    INNER JOIN `Works` ON `Employee`.person_name = `Works`.person_name
WHERE
    `Works`.company_name = 'First Bank Corporation'
    and `Works`.salary > 10000;

UPDATE `Works`
SET
    salary = 1.1 * salary
WHERE
    company_name = 'First Bank Corporation';

DELETE FROM `Works`
WHERE
    company_name = 'Small Bank Corporation';