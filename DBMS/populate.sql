-- College Admission Database Population Script
-- Drop tables if they exist (optional - uncomment if needed)
-- DROP TABLE IF EXISTS Apply;
-- DROP TABLE IF EXISTS Student;
-- DROP TABLE IF EXISTS College;

-- Create tables
CREATE TABLE College (
    cName VARCHAR(100) PRIMARY KEY,
    state VARCHAR(50) NOT NULL,
    enrollment INT NOT NULL
);

CREATE TABLE Student (
    sID INT PRIMARY KEY,
    sName VARCHAR(100) NOT NULL,
    GPA DECIMAL(3,2) NOT NULL,
    sizeHS INT NOT NULL
);

CREATE TABLE Apply (
    sID INT NOT NULL,
    cName VARCHAR(100) NOT NULL,
    major VARCHAR(100) NOT NULL,
    decision VARCHAR(20) NOT NULL,
    PRIMARY KEY (sID, cName, major),
    FOREIGN KEY (sID) REFERENCES Student(sID),
    FOREIGN KEY (cName) REFERENCES College(cName)
);

-- Populate College table
INSERT INTO College (cName, state, enrollment) VALUES
('Stanford', 'CA', 15000),
('Berkeley', 'CA', 36000),
('MIT', 'MA', 10000),
('Cornell', 'NY', 21000),
('Harvard', 'MA', 19000),
('Yale', 'CT', 11000),
('Princeton', 'NJ', 8000),
('Caltech', 'CA', 2000),
('UCLA', 'CA', 41000),
('Carnegie Mellon', 'PA', 13000),
('University of Texas', 'TX', 50000),
('Georgia Tech', 'GA', 25000),
('University of Michigan', 'MI', 45000),
('Northwestern', 'IL', 21000),
('Duke', 'NC', 15000);

-- Populate Student table
INSERT INTO Student (sID, sName, GPA, sizeHS) VALUES
(123, 'Amy', 3.90, 1000),
(234, 'Bob', 3.60, 1500),
(345, 'Craig', 3.50, 500),
(456, 'Doris', 3.90, 1000),
(567, 'Edward', 2.90, 2000),
(678, 'Fay', 3.80, 200),
(789, 'Gary', 3.40, 800),
(987, 'Helen', 3.70, 800),
(876, 'Irene', 3.90, 400),
(765, 'Jay', 2.90, 1500),
(654, 'Kevin', 3.50, 1200),
(543, 'Lisa', 3.80, 600),
(432, 'Mike', 3.20, 1800),
(321, 'Nancy', 3.60, 900),
(111, 'Oliver', 3.75, 1100),
(222, 'Paula', 3.85, 300),
(333, 'Quinn', 3.25, 1400),
(444, 'Rachel', 3.95, 700),
(555, 'Steve', 3.10, 2500),
(666, 'Tina', 3.65, 950);

-- Populate Apply table
INSERT INTO Apply (sID, cName, major, decision) VALUES
-- Amy's applications
(123, 'Stanford', 'CS', 'Y'),
(123, 'Stanford', 'EE', 'N'),
(123, 'Berkeley', 'CS', 'Y'),
(123, 'Cornell', 'EE', 'Y'),

-- Bob's applications
(234, 'Berkeley', 'biology', 'N'),
(234, 'Cornell', 'biology', 'Y'),
(234, 'Stanford', 'biology', 'N'),

-- Craig's applications
(345, 'MIT', 'bioengineering', 'Y'),
(345, 'Cornell', 'bioengineering', 'N'),
(345, 'Stanford', 'CS', 'N'),

-- Doris's applications
(456, 'Harvard', 'economics', 'Y'),
(456, 'Yale', 'economics', 'Y'),
(456, 'Princeton', 'economics', 'N'),

-- Edward's applications
(567, 'Berkeley', 'CS', 'N'),
(567, 'Cornell', 'CS', 'N'),

-- Fay's applications
(678, 'Stanford', 'history', 'Y'),
(678, 'Harvard', 'history', 'N'),
(678, 'Yale', 'history', 'Y'),

-- Gary's applications
(789, 'Berkeley', 'EE', 'Y'),
(789, 'Cornell', 'EE', 'N'),

-- Helen's applications
(987, 'Stanford', 'CS', 'N'),
(987, 'Berkeley', 'CS', 'Y'),
(987, 'MIT', 'CS', 'Y'),

-- Irene's applications
(876, 'Stanford', 'biology', 'N'),
(876, 'MIT', 'biology', 'Y'),
(876, 'Harvard', 'biology', 'Y'),

-- Jay's applications
(765, 'Stanford', 'history', 'N'),
(765, 'Cornell', 'history', 'N'),

-- Additional applications for more realistic data
(654, 'UCLA', 'CS', 'Y'),
(654, 'Berkeley', 'CS', 'N'),
(654, 'Stanford', 'CS', 'N'),

(543, 'MIT', 'EE', 'Y'),
(543, 'Caltech', 'EE', 'Y'),
(543, 'Stanford', 'EE', 'N'),

(432, 'University of Texas', 'CS', 'Y'),
(432, 'Georgia Tech', 'CS', 'Y'),
(432, 'Carnegie Mellon', 'CS', 'N'),

(321, 'Northwestern', 'economics', 'Y'),
(321, 'Duke', 'economics', 'N'),
(321, 'Harvard', 'economics', 'N'),

(111, 'University of Michigan', 'EE', 'Y'),
(111, 'Northwestern', 'EE', 'Y'),
(111, 'Cornell', 'EE', 'N'),

(222, 'Caltech', 'physics', 'Y'),
(222, 'MIT', 'physics', 'N'),
(222, 'Stanford', 'physics', 'N'),

(333, 'UCLA', 'biology', 'Y'),
(333, 'Berkeley', 'biology', 'N'),
(333, 'University of Texas', 'biology', 'Y'),

(444, 'Harvard', 'CS', 'Y'),
(444, 'MIT', 'CS', 'Y'),
(444, 'Stanford', 'CS', 'Y'),

(555, 'University of Texas', 'history', 'Y'),
(555, 'Georgia Tech', 'CS', 'N'),
(555, 'University of Michigan', 'history', 'Y'),

(666, 'Duke', 'biology', 'Y'),
(666, 'Northwestern', 'biology', 'N'),
(666, 'Cornell', 'biology', 'Y');

-- Display summary statistics
SELECT 'College Count' as Metric, COUNT(*) as Value FROM College
UNION ALL
SELECT 'Student Count', COUNT(*) FROM Student
UNION ALL
SELECT 'Application Count', COUNT(*) FROM Apply
UNION ALL
SELECT 'Acceptance Rate', CONCAT(ROUND(100.0 * SUM(CASE WHEN decision = 'Y' THEN 1 ELSE 0 END) / COUNT(*), 1), '%') FROM Apply;

-- Display sample data from each table
SELECT '=== COLLEGES ===' as Info;
SELECT * FROM College ORDER BY enrollment DESC LIMIT 5;

SELECT '=== STUDENTS ===' as Info;
SELECT * FROM Student ORDER BY GPA DESC LIMIT 5;

SELECT '=== APPLICATIONS ===' as Info;
SELECT s.sName, a.cName, a.major, a.decision 
FROM Apply a 
JOIN Student s ON a.sID = s.sID 
ORDER BY s.sName, a.cName 
LIMIT 10;
