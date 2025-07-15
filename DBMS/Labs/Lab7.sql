use lab7;

CREATE TABLE student(
    name VARCHAR(50),
    roll INT PRIMARY KEY,
    marks FLOAT,
    address VARCHAR(50)
);

INSERT INTO student(name, roll, marks, address)
VALUES 
    ("Ram", 12, 98, "Palpa"),
    ("Shyam", 13, 99, "KTM"),
    ("Hari", 14, 88, "PKR"),
    ("Rita", 15, 57, "BRT"),
    ("Sita", 16, 66, "BKT"),
    ("Gita", 17, 29, "KTM"),
    ("Anita", 18, 54, "PKR"),
    ("Dinesh", 19, 49, "BIR"),
    ("Kartik", 20, 34, "JHP"),
    ("Tarun", 21, 39, "PKR");

-- Query 1: Find all students whose name starts with "R"
-- This will return Ram and Rita
SELECT * FROM student WHERE name LIKE 'R%';

-- Query 2: Find all students whose name ends with "ita"
-- This will return Rita, Sita, Gita, and Anita
SELECT * FROM student WHERE name LIKE "%ita";

-- Query 3: Count the number of students whose name starts with "R"
-- This will return 2 (Ram and Rita)
SELECT count(*) FROM student WHERE name LIKE 'R%';

-- Query 4: Count the number of students whose name ends with "ita"
-- This will return 4 (Rita, Sita, Gita, and Anita)
SELECT count(*) FROM student WHERE name LIKE "%ita";

