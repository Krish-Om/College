-- DROP DATABASE assingment3;
CREATE DATABASE assingment3;

USE assingment3;

CREATE TABLE
    member (
        member_no int PRIMARY KEY,
        name VARCHAR(50),
        age int
    );

CREATE TABLE
    book (
        isbn int PRIMARY KEY,
        title VARCHAR(50),
        authors VARCHAR(50),
        publisher VARCHAR(40)
    );

-- DROP TABLE borrower;
CREATE TABLE
    borrower (
        member_no int,
        isbn int,
        date VARCHAR(20),
        FOREIGN KEY (member_no) REFERENCES member (member_no),
        FOREIGN KEY (isbn) REFERENCES book (isbn)
    );

INSERT INTO
    book (isbn, title, authors, publisher)
VALUES
    (100, "DSA", 'Anit', "DHH"),
    (101, "TOC", 'Anish', "HM"),
    (102, "Database Systems", 'Peter Smith', "Pearson"),
    (
        103,
        "Python Programming",
        'John Davis',
        "O'Reilly"
    ),
    (104, "Web Development", 'Sarah Wilson', "Wiley"),
    (105, "Data Structures", 'Mike Johnson', "McGraw"),
    (106, "Machine Learning", 'Emma Brown', "Springer"),
    (
        107,
        "Network Security",
        'David Lee',
        "Academic Press"
    ),
    (
        108,
        "Software Engineering",
        'Lisa Chen',
        "Addison"
    ),
    (
        109,
        "Cloud Computing",
        'Robert King',
        "Tech Books"
    ),
    (110, "AI Basics", 'James White', "InfoPress");

-- TRUNCATE TABLE member;
INSERT INTO
    member (member_no, name, age)
VALUES
    (301, 'Ram', 20),
    (100, 'Dem', 20),
    (302, 'Hari', 22),
    (303, 'Sita', 19),
    (304, 'Gita', 21),
    (305, 'Krishna', 23),
    (306, 'Shyam', 20),
    (307, 'Rita', 24),
    (308, 'Amit', 22),
    (309, 'Anita', 21),
    (310, 'Sunil', 25),
    (311, 'Pip', 25),
    (312, 'Peep', 25);

INSERT INTO
    borrower (member_no, isbn, date)
VALUES
    (301, 101, "2081-08-24"),
    (302, 102, "2081-07-15"),
    (303, 103, "2081-08-01"),
    (304, 104, "2081-07-20"),
    (305, 105, "2081-08-10"),
    (306, 106, "2081-07-25"),
    (307, 107, "2081-08-15"),
    (308, 108, "2081-07-30"),
    (309, 109, "2081-08-05"),
    (310, 110, "2081-07-28");

SELECT
    name
from
    member
    JOIN borrower ON member.member_no = borrower.member_no
WHERE
    `date` > DATE ('2081-06-15')
    AND `date` < DATE ('2081-08-25');

    -- Display the title of the book taken by member „Hari‟
SELECT
    *
FROM
    book
    JOIN borrower ON book.isbn = borrower.isbn
    JOIN member ON borrower.member_no = member.member_no
WHERE
    name = 'Hari';

-- Display the name and age of member who have taken a book written by „Avi Silberschatz‟
SELECT
    name,
    age
from
    member
    join borrower on member.member_no = borrower.member_no
    join book on borrower.isbn = book.isbn
WHERE
    book.authors = 'Avi Silberschatz';

-- Display the list of members whose first name starts from the letter „P‟.
SELECT
    *
from
    member
WHERE
    name LIKE "P%";

-- Update the name and age of member whose member_no is 100.
UPDATE member
SET age=33,name='Krish'
WHERE member_no=100;

-- Delete all records from relation borrower without deleting the table.
DELETE FROM borrower;