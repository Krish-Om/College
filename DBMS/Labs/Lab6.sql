-- Drop tables if they exist to avoid conflicts
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS courses;

-- Create courses table first (parent table)
CREATE TABLE courses(
    courseid VARCHAR(255) PRIMARY KEY,
    name VARCHAR(255)
);

-- Create students table with foreign key reference
CREATE TABLE students(
    studId INT PRIMARY KEY,
    name VARCHAR(50),
    course VARCHAR(255),
    FOREIGN KEY(course) REFERENCES courses(courseid)
);

-- Insert course data first (must exist before students can reference them)
INSERT INTO courses(courseid, name)
VALUES 
    ('PH', 'Pharmacy'),
    ('CM', 'Computing');

-- Insert student data (references existing course IDs)
INSERT INTO students(studId, name, course)
VALUES
    (100, 'Fred', 'PH'),
    (200, 'Dave', 'CM'),
    (300, 'Bob', 'CM');


-- Basic cross join (Cartesian product)
SELECT * FROM students, courses;

-- Query to find student with ID 200 and their course details
SELECT * FROM students, courses WHERE students.studId = 200 AND students.course = courses.courseid;

-- Alternative using proper JOIN syntax (recommended)
SELECT * FROM students 
JOIN courses ON students.course = courses.courseid 
WHERE students.studId = 200;

-- Query to find all students in a specific course (e.g., 'CM' for Computing)
SELECT * FROM students, courses WHERE students.course = 'CM' AND students.course = courses.courseid;