-- SELECT * from employee;

-- DROP TABLE employee;

-- CREATE TABLE employee(name VARCHAR(255) not NULL,
-- eid int primary key unique,
-- designation VARCHAR(255),
-- salary float );

-- INSERT INTO employee(name,eid,designation,salary)
-- VALUES
--     ("Alita",300,'Supervisor',90000),
--     ("Alita",10,'Assistant',90000),
--     ('Ram', 301, 'Manager', 40000),
--     ('Priya', 302, 'Software Engineer', 35000),
--     ('Amit', 303, 'Team Lead', 45000),
--     ('Sneha', 304, 'HR Executive', 28000),
--     ('Rahul', 305, 'Business Analyst', 38000),
--     ('Kavya', 306, 'UI/UX Designer', 32000),
--     ('Vikram', 307, 'Database Administrator', 42000),
--     ('Anita', 308, 'Quality Assurance', 30000),
--     ('Suresh', 309, 'Project Manager', 55000),
--     ('Meera', 310, 'DevOps Engineer', 48000);

-- SELECT * FROM employee;

-- SELECT * FROM employee WHERE designation="Supervisor";

-- UPDATE employee
-- SET name='Hari'
-- WHERE eid=50;

-- DELETE FROM employee WHERE eid=10;

-- SELECT AVG(salary) FROM employee;

-- SELECT COUNT(*) FROM employee;

-- SELECT SUM(salary) FROM employee;

-- UPDATE employee
-- SET salary=1.1*salary;

SELECT * FROM employee;



