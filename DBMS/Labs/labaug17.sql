-- Active: 1755364395954@@127.0.0.1@3306@employee
-- DROP DATABASE labaug18;
CREATE DATABASE labaug18;

USE labaug18;

CREATE TABLE
    User (
        user_id int PRIMARY KEY,
        user_name VARCHAR(50),
        address varchar(50)
    );

CREATE TABLE
    Publisher (
        publisher_id INT PRIMARY KEY,
        publisher_name VARCHAR(50),
        address VARCHAR(50)
    );

CREATE TABLE
    Book (
        book_id int PRIMARY KEY,
        book_name VARCHAR(50),
        author VARCHAR(50),
        publisher_id int,
        Foreign Key (publisher_id) REFERENCES Publisher (publisher_id)
    );

CREATE TABLE
    Uses (
        user_id INT,
        book_id INT,
        issued_date VARCHAR(50),
        publisher_id INT,
        PRIMARY KEY (user_id, book_id),
        Foreign Key (user_id) REFERENCES User (user_id),
        Foreign Key (book_id) REFERENCES Book (book_id),
        Foreign Key (publisher_id) REFERENCES Publisher (publisher_id)
    );

-- Inserting data into User table
INSERT INTO
    User
VALUES
    (1, 'Hari', 'Kathmandu'),
    (2, 'Shyam', 'Lalitpur'),
    (3, 'Sita', 'Bhaktapur');

-- Inserting data into Publisher table
INSERT INTO
    Publisher
VALUES
    (1, 'ABC publication', 'Kathmandu'),
    (2, 'XYZ Publishers', 'Lalitpur'),
    (3, 'Nepal Publications', 'Bhaktapur');

-- Inserting data into Book table
INSERT INTO
    Book
VALUES
    (1, 'Database Systems', 'Ram', 1),
    (2, 'Computer Networks', 'Ram', 1),
    (3, 'Operating Systems', 'Shyam', 2),
    (4, 'Data Structures', 'Ram', 1),
    (5, 'Python Programming', 'Hari', 3);

-- Inserting data into Uses table
INSERT INTO
    Uses
VALUES
    (1, 1, '2025-08-01', 1), -- Hari borrowed Database Systems
    (1, 2, '2025-08-10', 1), -- Hari borrowed Computer Networks
    (2, 3, '2025-08-05', 2),
    (3, 4, '2025-08-15', 1),
    (1, 5, '2025-08-17', 3);

-- Hari borrowed Python Programming


-- Retrieve names of all books issued to the user "Hari"
SELECT
    Book.book_name
FROM
    User
    JOIN Uses ON User.user_id = Uses.user_id
    JOIN Book ON Book.book_id = Uses.book_id
WHERE
    User.user_name = "Hari";

-- Retreive the names of all books published by "ABC production"
SELECT
    Book.book_name
FROM
    Publisher
    JOIN Book ON `Book`.publisher_id = `Publisher`.publisher_id
WHERE
    `Publisher`.publisher_name = 'ABC publication';

-- Count the number of books published by the author 'Ram;
SELECT
    COUNT(DISTINCT Book.book_id)
FROM
    Book
WHERE
    `Book`.author = 'Ram';