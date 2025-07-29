CREATE DATABASE lab5_q2;

USE lab5_q2;
CREATE TABLE product(
    pid VARCHAR(5),
    ProductName VARCHAR(40),
    UnitPrice numeric(5)
);

INSERT INTO product(pid,ProductName,`UnitPrice`)
VALUES
(12345,'Smartphone',25000),
(12346,'Laptop',45000),
(12347,'Headphones',1500),
(12348,'Smartwatch',8000),
(12349,'Tablet',15000);

SELECT * from product where `UnitPrice`>200;

SELECT * FROM product ORDER BY `ProductName`;

select * FROM product WHERE
`UnitPrice` >(SELECT avg(`UnitPrice`) FROM product);

DELETE  FROM product;

drop Table product;
