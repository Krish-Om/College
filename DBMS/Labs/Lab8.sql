create DATABASE lab8;

use lab8;

create TABLE
    First (id int primary key, name varchar(5));

create TABLE
    Second (id int primary key, name varchar(5));

INSERT INTO
    First (id, name)
VALUES
    (1, 'A'),
    (2, 'B'),
    (3, 'C');

INSERT INTO
    Second (id, name)
VALUES
    (2, "B"),
    (3, "C"),
    (5, "E"),
    (6, "F");

SELECT * FROM First UNION SELECT * FROM Second;

SELECT * FROM First INTERSECT SELECT * from Second;

SELECT * FROM First WHERE id not in(SELECT id from Second);