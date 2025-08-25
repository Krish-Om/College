-- 9. Consider the following relational schema:
-- tblSalesman(s-id, name, city, commission)
-- tblOrders(ord-no, prch-amt, ord-date, c-id,s-id)
-- tblCustomer(c-id, name, city, grade, s-id)
CREATE DATABASE IF NOT EXISTS SalesManagement;

USE SalesManagement;

-- Create the tables with appropriate constraints
CREATE TABLE
    tblSalesman (
        s_id INT PRIMARY KEY,
        name VARCHAR(50),
        city VARCHAR(50),
        commission DECIMAL(4, 2)
    );

CREATE TABLE
    tblCustomer (
        c_id INT PRIMARY KEY,
        name VARCHAR(50),
        city VARCHAR(50),
        grade INT,
        s_id INT,
        FOREIGN KEY (s_id) REFERENCES tblSalesman (s_id)
    );

CREATE TABLE
    tblOrders (
        ord_no INT PRIMARY KEY,
        prch_amt DECIMAL(10, 2),
        ord_date DATE,
        c_id INT,
        s_id INT,
        FOREIGN KEY (c_id) REFERENCES tblCustomer (c_id),
        FOREIGN KEY (s_id) REFERENCES tblSalesman (s_id)
    );

-- Insert sample data into tblSalesman table
INSERT INTO
    tblSalesman (s_id, name, city, commission)
VALUES
    (1, 'Nabin Rana', 'Kathmandu', 0.15),
    (2, 'Mohan Thapa', 'Pokhara', 0.13),
    (3, 'Ram Sharma', 'Kathmandu', 0.12),
    (4, 'Neer Khatri', 'Humla', 0.10),
    (5, 'Sita Ghimire', 'Kathmandu', 0.14),
    (6, 'Gita Karki', 'Humla', 0.11),
    (7, 'Naya Gurung', 'Pokhara', 0.15);

-- Insert sample data into tblCustomer table
INSERT INTO
    tblCustomer (c_id, name, city, grade, s_id)
VALUES
    (101, 'Raj Kumar', 'Kathmandu', 3, 1),
    (102, 'Anita Tamang', 'Pokhara', 2, 2),
    (103, 'Bikash KC', 'Kathmandu', 4, 1),
    (104, 'Sarita Rai', 'Humla', 1, 4),
    (105, 'Kamal Thapa', 'Kathmandu', 3, 3),
    (106, 'Binod Shrestha', 'Pokhara', 2, 2),
    (107, 'Sunita Magar', 'Kathmandu', 4, 5),
    (108, 'Dipesh Gurung', 'Humla', 2, 6),
    (109, 'Raju Lama', 'Kathmandu', 3, 3),
    (110, 'Kabita Poudel', 'Pokhara', 3, 7);

-- Insert sample data into tblOrders table
INSERT INTO
    tblOrders (ord_no, prch_amt, ord_date, c_id, s_id)
VALUES
    (1001, 15000.00, '2017-07-17', 101, 1),
    (1002, 25000.00, '2017-07-17', 102, 2),
    (1003, 10000.00, '2017-07-18', 103, 1),
    (1004, 5000.00, '2017-07-19', 104, 4),
    (1005, 18000.00, '2017-07-17', 105, 3),
    (1006, 9000.00, '2017-07-20', 106, 2),
    (1007, 20000.00, '2017-07-17', 107, 5),
    (1008, 15000.00, '2017-07-21', 108, 6),
    (1009, 12000.00, '2017-07-17', 109, 3),
    (1010, 30000.00, '2017-07-17', 110, 7);

-- i. Find those salesman with all information whose name containing the 1st character is 'N' and the 4th
-- character is 'R' and rests may be any character.
SELECT
    *
FROM
    tblSalesman
WHERE
    name LIKE 'N__R%';

-- ii. Find the highest purchase amount on a date '2017-07-17' for each salesman with their ID.
SELECT
    s_id,
    MAX(prch_amt) AS highest_purchase
FROM
    tblOrders
WHERE
    ord_date = '2017-07-17'
GROUP BY
    s_id;

-- iii. Count the customers with grades above Kathmandu's average.
SELECT
    COUNT(*) AS customer_count
FROM
    tblCustomer
WHERE
    grade > (
        SELECT
            AVG(grade)
        FROM
            tblCustomer
        WHERE
            city = 'Kathmandu'
    );

-- iv. Increase the commission of salesmen by 2% if they are from Humla.
UPDATE tblSalesman
SET
    commission = commission + 0.02
WHERE
    city = 'Humla';