-- 10. Consider the following relational database model:
-- Author(a-name, citizenship, birthYear) 
-- Book(isbn, title, a-name)
-- Topic(isbn, subject)
-- Branch(libname, city)
-- Instock(isbn, libname, quantity)
CREATE DATABASE IF NOT EXISTS LibrarySystem;

USE LibrarySystem;

-- Create tables with appropriate constraints
CREATE TABLE
    Author (
        a_name VARCHAR(50) PRIMARY KEY,
        citizenship VARCHAR(50),
        birthYear INT
    );

CREATE TABLE
    Book (
        isbn VARCHAR(20) PRIMARY KEY,
        title VARCHAR(100) NOT NULL,
        a_name VARCHAR(50),
        FOREIGN KEY (a_name) REFERENCES Author (a_name)
    );

CREATE TABLE
    Topic (
        isbn VARCHAR(20),
        subject VARCHAR(50),
        PRIMARY KEY (isbn, subject),
        FOREIGN KEY (isbn) REFERENCES Book (isbn)
    );

CREATE TABLE
    Branch (
        libname VARCHAR(50) PRIMARY KEY,
        city VARCHAR(50) NOT NULL
    );

CREATE TABLE
    Instock (
        isbn VARCHAR(20),
        libname VARCHAR(50),
        quantity INT NOT NULL,
        PRIMARY KEY (isbn, libname),
        FOREIGN KEY (isbn) REFERENCES Book (isbn),
        FOREIGN KEY (libname) REFERENCES Branch (libname)
    );

-- Insert sample data into Author table
INSERT INTO
    Author (a_name, citizenship, birthYear)
VALUES
    ('J.K. Rowling', 'British', 1965),
    ('George Orwell', 'British', 1903),
    ('Haruki Murakami', 'Japanese', 1949),
    ('Jane Austen', 'British', 1775),
    ('Laxmi Prasad Devkota', 'Nepali', 1909),
    ('xyz', 'Unknown', 2000),
    ('Khagendra Sangraula', 'Nepali', 1946);

-- Insert sample data into Book table
INSERT INTO
    Book (isbn, title, a_name)
VALUES
    (
        '978-0-7475-3269-9',
        'Harry Potter and the Philosopher''s Stone',
        'J.K. Rowling'
    ),
    ('978-0-14-118776-1', '1984', 'George Orwell'),
    (
        '978-0-679-75379-6',
        'The Wind-Up Bird Chronicle',
        'Haruki Murakami'
    ),
    (
        '978-0-14-143951-8',
        'Pride and Prejudice',
        'Jane Austen'
    ),
    (
        '978-9-937-70014-2',
        'Muna Madan',
        'Laxmi Prasad Devkota'
    ),
    ('978-9-937-73322-5', 'Book1', 'xyz'),
    ('978-9-937-73323-6', 'Book2', 'xyz'),
    ('978-9-937-73324-7', 'Book3', 'xyz'),
    (
        '978-9-937-83310-2',
        'Junkiree',
        'Khagendra Sangraula'
    );

-- Insert sample data into Topic table
INSERT INTO
    Topic (isbn, subject)
VALUES
    ('978-0-7475-3269-9', 'Fantasy'),
    ('978-0-14-118776-1', 'Dystopian'),
    ('978-0-679-75379-6', 'Magical Realism'),
    ('978-0-14-143951-8', 'Classic Literature'),
    ('978-9-937-70014-2', 'Poetry'),
    ('978-9-937-73322-5', 'Fiction'),
    ('978-9-937-73323-6', 'Science'),
    ('978-9-937-73324-7', 'Science'),
    ('978-9-937-83310-2', 'Essay');

-- Insert sample data into Branch table
INSERT INTO
    Branch (libname, city)
VALUES
    ('Central Library', 'Kathmandu'),
    ('Pokhara Public Library', 'Pokhara'),
    ('Birgunj Library', 'Birgunj'),
    ('TU Central Library', 'Kathmandu'),
    ('Dharan Public Library', 'Dharan');

-- Insert sample data into Instock table
INSERT INTO
    Instock (isbn, libname, quantity)
VALUES
    ('978-0-7475-3269-9', 'Central Library', 5),
    ('978-0-7475-3269-9', 'TU Central Library', 3),
    ('978-0-14-118776-1', 'Central Library', 2),
    ('978-0-14-118776-1', 'Pokhara Public Library', 1),
    ('978-0-679-75379-6', 'Birgunj Library', 2),
    ('978-0-14-143951-8', 'Central Library', 3),
    ('978-0-14-143951-8', 'TU Central Library', 2),
    ('978-9-937-70014-2', 'Central Library', 4),
    ('978-9-937-70014-2', 'TU Central Library', 3),
    ('978-9-937-70014-2', 'Pokhara Public Library', 2),
    ('978-9-937-73322-5', 'Dharan Public Library', 1),
    ('978-9-937-73323-6', 'Birgunj Library', 1),
    ('978-9-937-73324-7', 'Central Library', 2),
    ('978-9-937-83310-2', 'TU Central Library', 3);

-- Write SQL queries for the following:
-- i. Give the cities where each book is held.
SELECT
    b.title,
    br.city
FROM
    Book b
    JOIN Instock i ON b.isbn = i.isbn
    JOIN Branch br ON i.libname = br.libname
ORDER BY
    b.title;

-- ii. Give the title and author of each book of which at least two copies are held in a branch located in Kathmandu.
SELECT
    b.title,
    b.a_name
FROM
    Book b
    JOIN Instock i ON b.isbn = i.isbn
    JOIN Branch br ON i.libname = br.libname
WHERE
    br.city = 'Kathmandu'
    AND i.quantity >= 2;

-- iii. Delete those books that are from the author 'xyz'
START TRANSACTION;

-- First delete child records to maintain referential integrity
DELETE i, t, b
FROM Book b
LEFT JOIN Instock i ON b.isbn = i.isbn
LEFT JOIN Topic t ON b.isbn = t.isbn
WHERE b.a_name = 'xyz';

DELETE FROM Author WHERE a_name = 'xyz';

COMMIT;

-- iv. List the total no. of available books of each subject.
SELECT
    t.subject,
    SUM(i.quantity) AS total_available
FROM
    Topic t
    JOIN Instock i ON t.isbn = i.isbn
GROUP BY
    t.subject
ORDER BY
    total_available DESC;