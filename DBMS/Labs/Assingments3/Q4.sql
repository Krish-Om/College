-- Active: 1755364395954@@127.0.0.1@3306@Supply
-- 4. Consider the following supplier database, where primary keys are underlined:
-- Supplier (supplier –id, supplier name, city)
-- Supplies (supplier –id, part-id, quantity)
-- Parts (part- id, par-name, color, weight)
-- DROP DATABASE Supply;
CREATE DATABASE Supply;

USE Supply;

CREATE TABLE
    Supplier (
        supplier_id INT PRIMARY KEY,
        supplier_name VARCHAR(50),
        city VARCHAR(50)
    );

CREATE TABLE
    Part (
        part_id INT PRIMARY KEY,
        part_name VARCHAR(50),
        color VARCHAR(20),
        weight NUMERIC
    );

CREATE TABLE
    Supplies (
        supplier_id INT,
        part_id INT,
        quantity INT,
        PRIMARY KEY (supplier_id, part_id),
        Foreign Key (supplier_id) REFERENCES Supplier (supplier_id),
        FOREIGN KEY (part_id) REFERENCES Part (part_id)
    );

-- Insert sample data into Supplier table
INSERT INTO
    Supplier (supplier_id, supplier_name, city)
VALUES
    (1, 'ABC Company', 'Kathmandu'),
    (2, 'XYZ Suppliers', 'Kathmandu'),
    (3, 'Nepal Parts', 'Pokhara'),
    (4, 'Mountain Supplies', 'Lalitpur'),
    (5, 'Valley Traders', 'Kathmandu');

-- Insert sample data into Part table
INSERT INTO
    Part (part_id, part_name, color, weight)
VALUES
    (1, 'Bolt', 'Silver', 0.1),
    (2, 'Nut', 'Silver', 0.05),
    (3, 'Screw', 'Black', 0.08),
    (4, 'Wire', 'Copper', 0.2),
    (5, 'Pipe', 'Gray', 2.5),
    (6, 'Chain', 'Silver', 1.5),
    (7, 'Washer', 'Silver', 0.03),
    (8, 'Bearing', 'Silver', 0.5),
    (9, 'Spring', 'Silver', 0.15),
    (10, 'Gear', 'Silver', 1.2),
    (11, 'Shaft', 'Black', 3.0),
    (12, 'Gasket', 'Black', 0.07),
    (13, 'Piston', 'Silver', 2.8),
    (14, 'Valve', 'Brass', 0.9),
    (15, 'Pulley', 'Black', 1.8),
    (16, 'Belt', 'Black', 0.6),
    (17, 'Coupling', 'Silver', 1.1),
    (18, 'Hose', 'Black', 0.4),
    (19, 'Flange', 'Silver', 1.3),
    (20, 'Bracket', 'Gray', 0.8),
    (21, 'Fastener', 'Silver', 0.04),
    (22, 'Connector', 'Brass', 0.12),
    (23, 'Bushing', 'Bronze', 0.25),
    (24, 'Pin', 'Silver', 0.02),
    (25, 'Ring', 'Silver', 0.06),
    (26, 'Clip', 'Silver', 0.01),
    (27, 'Roller', 'Black', 0.35),
    (28, 'Socket', 'Black', 0.45),
    (29, 'Seal', 'Black', 0.09),
    (30, 'Filter', 'White', 0.3),
    (31, 'Mount', 'Black', 0.7),
    (32, 'Plug', 'Black', 0.11),
    (33, 'Clamp', 'Silver', 0.22),
    (34, 'Spacer', 'Silver', 0.05),
    (35, 'Guard', 'Black', 1.4);

-- Insert sample data into Supplies table
INSERT INTO
    Supplies (supplier_id, part_id, quantity)
VALUES
    -- ABC Company (supplying more than 30 different parts)
    (1, 1, 400),
    (1, 2, 350),
    (1, 3, 500),
    (1, 4, 320),
    (1, 5, 450),
    (1, 6, 380),
    (1, 7, 410),
    (1, 8, 290),
    (1, 9, 330),
    (1, 10, 520),
    (1, 11, 280),
    (1, 12, 360),
    (1, 13, 420),
    (1, 14, 310),
    (1, 15, 470),
    (1, 16, 340),
    (1, 17, 390),
    (1, 18, 430),
    (1, 19, 370),
    (1, 20, 440),
    (1, 21, 460),
    (1, 22, 350),
    (1, 23, 480),
    (1, 24, 320),
    (1, 25, 510),
    (1, 26, 330),
    (1, 27, 420),
    (1, 28, 380),
    (1, 29, 490),
    (1, 30, 360),
    (1, 31, 400),
    (1, 32, 340),
    (1, 33, 450),
    (1, 34, 370),
    (1, 35, 430),
    -- XYZ Suppliers (few parts)
    (2, 1, 250),
    (2, 3, 320),
    (2, 5, 380),
    (2, 7, 410),
    (2, 9, 290),
    -- Nepal Parts (few parts)
    (3, 2, 180),
    (3, 4, 400),
    (3, 6, 350),
    (3, 8, 430),
    (3, 10, 270),
    -- Mountain Supplies (few parts)
    (4, 11, 290),
    (4, 13, 310),
    (4, 15, 460),
    (4, 17, 250),
    (4, 19, 380),
    -- Valley Traders (few parts)
    (5, 12, 450),
    (5, 14, 380),
    (5, 16, 420),
    (5, 18, 340),
    (5, 20, 360);

-- quantity > 300
-- Construct the following relation algebra queries for this relation database
-- (a) Find the name of all suppliers located in city "Kathmandu"
SELECT
    supplier_name
FROM
    Supplier
WHERE
    city = 'Kathmandu';

-- (b) Find the name of all parts supplied "ABC Company".
SELECT DISTINCT
    p.part_name
FROM
    Part p
    JOIN Supplies s ON p.part_id = s.part_id
    JOIN Supplier sup ON s.supplier_id = sup.supplier_id
WHERE
    sup.supplier_name = 'ABC Company';

-- (c) Find the name of all parts that are supplied in quantity greater than 300.
SELECT DISTINCT
    p.part_name
FROM
    Part p
    JOIN Supplies s ON p.part_id = s.part_id
WHERE
    s.quantity > 300;

-- (d) Find the number of all parts supplied by "ABC Company".
SELECT
    COUNT(DISTINCT s.part_id) AS supply_count
FROM
    Supplies s
    JOIN Supplier sup ON s.supplier_id = sup.supplier_id
WHERE
    sup.supplier_name = 'ABC Company';

-- (e) Find the name of all suppliers who supply more than 30 different parts
SELECT
    sup.supplier_name
FROM
    Supplier sup
    JOIN Supplies s ON sup.supplier_id = s.supplier_id
GROUP BY
    sup.supplier_id,
    sup.supplier_name
HAVING
    COUNT(DISTINCT s.part_id) > 30;