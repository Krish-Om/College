-- 6. Consider the following supplier database, where primary keys are underlined:
-- Supplier(supplier-id, supplier-name, city)
-- Supplies(supplier-id, part-id, quantity)
-- Parts(part-id, part-name, color, weight)
CREATE DATABASE IF NOT EXISTS SupplierSystem;

USE SupplierSystem;

-- Create tables with appropriate constraints
CREATE TABLE
    IF NOT EXISTS Supplier (
        supplier_id INT PRIMARY KEY,
        supplier_name VARCHAR(50),
        city VARCHAR(50)
    );

CREATE TABLE
    IF NOT EXISTS Parts (
        part_id INT PRIMARY KEY,
        part_name VARCHAR(50),
        color VARCHAR(20),
        weight DECIMAL(10, 2)
    );

CREATE TABLE
    IF NOT EXISTS Supplies (
        supplier_id INT,
        part_id INT,
        quantity INT,
        PRIMARY KEY (supplier_id, part_id),
        FOREIGN KEY (supplier_id) REFERENCES Supplier (supplier_id),
        FOREIGN KEY (part_id) REFERENCES Parts (part_id)
    );

-- Sample data for Supplier table
INSERT INTO
    Supplier (supplier_id, supplier_name, city)
VALUES
    (1, 'ABC Company', 'Kathmandu'),
    (2, 'XYZ Suppliers', 'Kathmandu'),
    (3, 'Nepal Parts', 'Pokhara'),
    (4, 'Mountain Supplies', 'Lalitpur'),
    (5, 'Valley Traders', 'Kathmandu');

-- Sample data for Parts table
INSERT INTO
    Parts (part_id, part_name, color, weight)
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
    (31, 'Mount', 'Black', 0.7);

-- Insert data into Supplies table with many parts for ABC Company for part (e)
INSERT INTO
    Supplies (supplier_id, part_id, quantity)
VALUES
    -- ABC Company supplies (with some over 300 quantity)
    (1, 1, 400), -- Bolt (quantity > 300)
    (1, 2, 350), -- Nut (quantity > 300)
    (1, 3, 500), -- Screw (quantity > 300)
    (1, 4, 200),
    (1, 5, 450), -- Pipe (quantity > 300)
    (1, 6, 380), -- Chain (quantity > 300)
    (1, 7, 150),
    (1, 8, 290),
    (1, 9, 320), -- Spring (quantity > 300)
    (1, 10, 520), -- Gear (quantity > 300)
    (1, 11, 280),
    (1, 12, 310), -- Gasket (quantity > 300)
    (1, 13, 230),
    (1, 14, 180),
    (1, 15, 270),
    (1, 16, 340), -- Belt (quantity > 300)
    (1, 17, 290),
    (1, 18, 430), -- Hose (quantity > 300)
    (1, 19, 270),
    (1, 20, 390), -- Bracket (quantity > 300)
    (1, 21, 460), -- Fastener (quantity > 300)
    (1, 22, 250),
    (1, 23, 480), -- Bushing (quantity > 300)
    (1, 24, 220),
    (1, 25, 510), -- Ring (quantity > 300)
    (1, 26, 190),
    (1, 27, 420), -- Roller (quantity > 300)
    (1, 28, 280),
    (1, 29, 490), -- Seal (quantity > 300)
    (1, 30, 360), -- Filter (quantity > 300)
    (1, 31, 400), -- Mount (quantity > 300)
    -- Other suppliers
    (2, 1, 150),
    (2, 3, 320), -- Screw (quantity > 300)
    (2, 5, 100),
    (3, 2, 200),
    (3, 4, 350), -- Wire (quantity > 300)
    (3, 6, 180),
    (4, 7, 290),
    (4, 9, 310), -- Spring (quantity > 300)
    (5, 8, 200),
    (5, 10, 150);

-- a. Find the name of all suppliers located in city "Kathmandu"
-- SQL Query
SELECT
    supplier_name
FROM
    Supplier
WHERE
    city = 'Kathmandu';

-- Relational Algebra:
-- π supplier_name (σ city='Kathmandu' (Supplier))
-- b. Find the name of all parts supplied by "ABC company"
-- SQL Query
SELECT DISTINCT
    p.part_name
FROM
    Parts p
    JOIN Supplies s ON p.part_id = s.part_id
    JOIN Supplier sup ON s.supplier_id = sup.supplier_id
WHERE
    sup.supplier_name = 'ABC Company';

-- Relational Algebra:
-- π part_name (Parts ⋈ Supplies ⋈ σ supplier_name='ABC Company' (Supplier))
-- c. Find the name of all parts that are supplied in quantity greater than 300
-- SQL Query
SELECT DISTINCT
    p.part_name
FROM
    Parts p
    JOIN Supplies s ON p.part_id = s.part_id
WHERE
    s.quantity > 300;

-- Relational Algebra:
-- π part_name (Parts ⋈ σ quantity>300 (Supplies))
-- d. Find the number of parts supplied by "ABC Company"
-- SQL Query
SELECT
    COUNT(DISTINCT s.part_id) AS total_parts
FROM
    Supplies s
    JOIN Supplier sup ON s.supplier_id = sup.supplier_id
WHERE
    sup.supplier_name = 'ABC Company';

-- Relational Algebra:
-- COUNT(π part_id (Supplies ⋈ σ supplier_name='ABC Company' (Supplier)))
-- e. Find the name of all suppliers who supply more than 30 different parts
-- SQL Query
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

-- γ supplier_name, COUNT(DISTINCT part_id)>30 (Supplier ⋈ Supplies)
-- {supplier_name | supplier_name ∈ Supplier, COUNT(DISTINCT part_id) > 30}