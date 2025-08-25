-- 8. Consider the following relational data model.
-- Student(crn, name, address, phone, dob)
-- Course(coursed, crn, duration, fee)
-- Enroll(enrolled, cname, courseid, enrolldata, completedata)
CREATE DATABASE IF NOT EXISTS StudentEnrollment;

USE StudentEnrollment;

-- i. Write the SQL statements required to create above relations, including appropriate versions of all
-- primary and foreign key integrity constraints.
CREATE TABLE
    Student (
        crn VARCHAR(10) PRIMARY KEY,
        name VARCHAR(50) NOT NULL,
        address VARCHAR(100),
        phone VARCHAR(15),
        dob DATE
    );

CREATE TABLE
    Course (
        courseid VARCHAR(10) PRIMARY KEY,
        crn VARCHAR(10),
        duration INT, -- duration in weeks
        fee DECIMAL(10, 2),
        FOREIGN KEY (crn) REFERENCES Student (crn)
    );

CREATE TABLE
    Enroll (
        enrollid INT PRIMARY KEY,
        cname VARCHAR(50) NOT NULL,
        courseid VARCHAR(10),
        enrolldate DATE,
        completedate DATE,
        FOREIGN KEY (courseid) REFERENCES Course (courseid)
    );

-- Insert sample data into Student table
INSERT INTO
    Student (crn, name, address, phone, dob)
VALUES
    (
        'S001',
        'Ram Sharma',
        'Kathmandu',
        '9841234567',
        '2000-05-15'
    ),
    (
        'S002',
        'Sita Ghimire',
        'Pokhara',
        '9857123456',
        '2001-02-20'
    ),
    (
        'S003',
        'Hari KC',
        'Kathmandu',
        '9812345678',
        '2000-11-10'
    ),
    (
        'S004',
        'Gita Thapa',
        'Lalitpur',
        '9845678901',
        '1999-08-25'
    ),
    (
        'S005',
        'Mohan Singh',
        'Bhaktapur',
        '9851234567',
        '2002-04-30'
    ),
    (
        'S006',
        'Radha Shrestha',
        'Kathmandu',
        '9861234567',
        '2001-07-12'
    ),
    (
        'S007',
        'Shyam Basnet',
        'Pokhara',
        '9871234567',
        '2000-09-18'
    ),
    (
        'S008',
        'Sarita Tamang',
        'Lalitpur',
        '9881234567',
        '2001-12-05'
    ),
    (
        'S009',
        'Deepak Karki',
        'Bhaktapur',
        '9891234567',
        '1999-03-22'
    ),
    (
        'S010',
        'Anita Rai',
        'Kathmandu',
        '9801234567',
        '2002-01-14'
    );

-- Insert sample data into Course table
INSERT INTO
    Course (courseid, crn, duration, fee)
VALUES
    ('C001', 'S001', 12, 15000.00),
    ('C002', 'S002', 8, 10000.00),
    ('C003', 'S003', 16, 20000.00),
    ('C004', 'S004', 10, 12000.00),
    ('C005', 'S005', 14, 18000.00),
    ('C006', 'S006', 12, 15000.00),
    ('C007', 'S007', 8, 10000.00),
    ('C008', 'S008', 16, 20000.00),
    ('C009', 'S009', 10, 12000.00),
    ('C010', 'S010', 14, 18000.00);

-- Insert sample data into Enroll table
INSERT INTO
    Enroll (
        enrollid,
        cname,
        courseid,
        enrolldate,
        completedate
    )
VALUES
    (1, 'Java', 'C001', '2025-01-15', '2025-04-15'),
    (2, 'Python', 'C002', '2025-02-01', '2025-04-01'),
    (3, 'Java', 'C003', '2025-01-20', '2025-05-20'),
    (4, 'C++', 'C004', '2025-03-10', '2025-05-20'),
    (5, 'Linux', 'C005', '2025-02-15', '2025-06-15'),
    (6, 'Java', 'C006', '2025-01-05', '2025-04-05'),
    (7, 'Linux', 'C007', '2025-03-01', '2025-05-01'),
    (8, 'Python', 'C008', '2025-02-10', '2025-06-10'),
    (9, 'Linux', 'C009', '2025-01-25', '2025-04-05'),
    (10, 'Java', 'C010', '2025-03-05', '2025-07-05');

-- ii. Write an expression in SQL to find crn, names and enroll data of all students who have taken the
-- course 'Java' (cname).
SELECT
    s.crn,
    s.name,
    e.enrolldate
FROM
    Student s
    JOIN Course c ON s.crn = c.crn
    JOIN Enroll e ON c.courseid = e.courseid
WHERE
    e.cname = 'Java';

-- iii. Write SQL to find the names and address of all the students who have taken both course Java and
-- Linux.
SELECT
    s.name,
    s.address
FROM
    Student s
    JOIN Course c ON s.crn = c.crn
    JOIN Enroll e1 ON c.courseid = e1.courseid
WHERE
    e1.cname = 'Java'
    AND EXISTS (
        SELECT
            1
        FROM
            Course c2
            JOIN Enroll e2 ON c2.courseid = e2.courseid
        WHERE
            c2.crn = s.crn
            AND e2.cname = 'Linux'
    );

-- iv. Write an expression in SQL to create a view 'Student_course' having the attributes crn, cname,
-- phone, coursename, enrolldata.
CREATE VIEW
    Student_course AS
SELECT
    s.crn,
    s.name AS cname,
    s.phone,
    e.cname AS coursename,
    e.enrolldate
FROM
    Student s
    JOIN Course c ON s.crn = c.crn
    JOIN Enroll e ON c.courseid = e.courseid;