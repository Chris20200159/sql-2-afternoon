-- SYNTAX HINT: 
SELECT [Column names] 
FROM [table] [abbv]
JOIN [table2] [abbv2] ON abbv.prop = abbv2.prop WHERE [Conditions];

SELECT a.name, b.name FROM some_table a JOIN another_table b ON a.some_id = b.some_id;
SELECT a.name, b.name FROM some_table a JOIN another_table b ON a.some_id = b.some_id WHERE b.email = 'e@mail.com';

-- PRACTICE JOINS
-- 1. Get all invoices where the unit_price on the invoice_line is greater than $0.99
SELECT *
FROM invoice i
JOIN invoice_line il ON il.invoice_id = i.invoice_id
WHERE il.unit_price > 0.99;

-- 2. Get the invoice_date, customer first_name and last_name, and total from all invoices.

SELECT i.invoice_date, c.first_name, c.last_name, i.total
FROM invoice i
JOIN customer c ON i.customer_id = c.customer_id;

-- 3. Get the customer first_name and last_name and the support rep's first_name and last_name from all customers.

SELECT c.first_name, c.last_name, e.first_name, e.last_name
FROM customer c
JOIN employee e ON c.support_rep_id = e.employee_id;

-- 4. Get the album title and the artist name from all albums.

SELECT al.title, ar.name
FROM album al
JOIN artist ar ON al.artist_id = ar.artist_id;

-- 5. Get all playlist_track track_ids where the playlist name is Music.

SELECT pt.track_id
FROM playlist_track pt
JOIN playlist p ON p.playlist_id = pt.playlist_id
WHERE p.name = 'Music';

-- 6. Get all track names for playlist_id 5.

SELECT t.name
FROM track t
JOIN playlist_track pt ON pt.track_id = t.track_id
WHERE pt.playlist_id = 5;

-- 7. Get all track names and the playlist name that they're on ( 2 joins ).

SELECT t.name, p.name
FROM track t
JOIN playlist_track pt ON t.track_id = pt.track_id
JOIN playlist p ON pt.playlist_id = p.playlist_id;


-- 8. Get all track names and album titles that are the genre Alternative & Punk ( 2 joins ).

SELECT t.name, a.title
FROM track t
JOIN album a ON t.album_id = a.album_id
JOIN genre g ON g.genre_id = t.genre_id
WHERE g.name = 'Alternative & Punk';

-- PRACTICE NESTED QUERIES
SELECT [column names] 
FROM [table] 
WHERE column_id IN ( SELECT column_id FROM [table2] WHERE [Condition] );

SELECT name, Email FROM Athlete WHERE AthleteId IN ( SELECT PersonId FROM PieEaters WHERE Flavor='Apple' );

-- 1. Get all invoices where the unit_price on the invoice_line is greater than $0.99.

SELECT *
FROM invoice
WHERE invoice_id IN ( SELECT invoice_id FROM invoice_line WHERE unit_price > 0.99 );

-- 2. Get all playlist tracks where the playlist name is Music.

SELECT *
FROM playlist_track
WHERE playlist_id IN ( SELECT playlist_id FROM playlist WHERE name = 'Music' );

-- 3. Get all track names for playlist_id 5.

SELECT name
FROM track
WHERE track_id IN ( SELECT track_id FROM playlist_track WHERE playlist_id = 5 );


-- 4. Get all tracks where the genre is Comedy.

SELECT *
FROM track
WHERE genre_id IN ( SELECT genre_id FROM genre WHERE name = 'Comedy' );


-- 5. Get all tracks where the album is Fireball.

SELECT *
FROM track
WHERE album_id IN ( SELECT album_id FROM album WHERE title = 'Fireball' );


-- 6. Get all tracks for the artist Queen ( 2 nested subqueries ).
 
 SELECT *
FROM track
WHERE album_id IN ( 
  SELECT album_id FROM album WHERE artist_id IN ( 
    SELECT artist_id FROM artist WHERE name = 'Queen'
  )
); 

-- PRACTICE UPDATING ROWS
UPDATE [table] 
SET [column1] = [value1], [column2] = [value2] 
WHERE [Condition];

UPDATE athletes SET sport = 'Picklball' WHERE sport = 'pockleball';

-- 1. Find all customers with fax numbers and set those numbers to null.
UPDATE customer
SET fax = null
WHERE fax IS NOT null;

SELECT * FROM customer; 

-- 2. Find all customers with no company (null) and set their company to "Self".

UPDATE customer
SET company = 'Self'
WHERE company IS null;

SELECT * FROM customer; 

-- 3. Find the customer Julia Barnett and change her last name to Thompson.
UPDATE customer 
SET last_name = 'Thompson' 
WHERE first_name = 'Julia' AND last_name = 'Barnett';

SELECT * FROM customer;
-- 4. Find the customer with this email luisrojas@yahoo.cl and change his support rep to 4.

UPDATE customer
SET support_rep_id = 4
WHERE email = 'luisrojas@yahoo.cl';

SELECT * FROM customer;

-- 5. Find all tracks that are the genre Metal and have no composer. Set the composer to "The darkness around us".

UPDATE track
SET composer = 'The darkness around us'
WHERE genre_id = ( SELECT genre_id FROM genre WHERE name = 'Metal' )
AND composer IS null;

SELECT * FROM customer;
-- 6. Refresh your page to remove all database changes.
***

-- GROUP BY
SELECT [column1], [column2]
FROM [table] [abbr]
GROUP BY [column];

-- 1. Find a count of how many tracks there are per genre. Display the genre name with the count.

SELECT COUNT(*), g.name
FROM track t
JOIN genre g ON t.genre_id = g.genre_id
GROUP BY g.name;

-- 2. Find a count of how many tracks are the "Pop" genre and how many tracks are the "Rock" genre.

SELECT COUNT(*), g.name
FROM track t
JOIN genre g ON g.genre_id = t.genre_id
WHERE g.name = 'Pop' OR g.name = 'Rock'
GROUP BY g.name;


-- 3. Find a list of all artists and how many albums they have.

SELECT ar.name, COUNT(*)
FROM album al
JOIN artist ar ON ar.artist_id = al.artist_id
GROUP BY ar.name;

-- USE DISTINCT
SELECT DISTINCT [column]
FROM [table];

-- 1. From the track table find a unique list of all composers.

SELECT DISTINCT composer
FROM track;

-- 2. From the invoice table find a unique list of all billing_postal_codes.

SELECT DISTINCT billing_postal_code
FROM invoice;

-- 3. From the customer table find a unique list of all companys.

SELECT DISTINCT company
FROM customer;

-- DELETE ROWS

DELETE FROM [table] WHERE [condition]

-- Practice Delete Table:
CREATE TABLE practice_delete ( name TEXT, type TEXT, value INTEGER );
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'bronze', 50);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'bronze', 50);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'bronze', 50);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'silver', 100);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'silver', 100);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'gold', 150);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'gold', 150);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'gold', 150);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'gold', 150);

SELECT * FROM practice_delete;

-- 1. Copy, paste, and run the SQL code from the summary.

CREATE TABLE practice_delete ( name TEXT, type TEXT, value INTEGER );
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'bronze', 50);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'bronze', 50);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'bronze', 50);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'silver', 100);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'silver', 100);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'gold', 150);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'gold', 150);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'gold', 150);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'gold', 150);

SELECT * FROM practice_delete;

-- 2. Delete all 'bronze' entries from the table.

DELETE 
FROM practice_delete 
WHERE type = 'bronze';

SELECT * FROM practice_delete;

-- 3. Delete all 'silver' entries from the table.
DELETE 
FROM practice_delete 
WHERE type = 'silver';

SELECT * FROM practice_delete;

-- 4. Delete all entries whose value is equal to 150.

DELETE 
FROM practice_delete 
WHERE value = 150;

SELECT * FROM practice_delete;

-- eCommerce Simulation
-- Let's simulate an e-commerce site. We're going to need users, products, and orders.

-- users need a name and an email.
-- products need a name and a price
-- orders need a ref to product.
-- All 3 need primary keys.
-- Instructions
-- Create 3 tables following the criteria in the summary.
-- Add some data to fill up each table.
-- At least 3 users, 3 products, 3 orders.
-- Run queries against your data.
-- Get all products for the first order.
-- Get all orders.
-- Get the total cost of an order ( sum the price of all products on an order ).
-- Add a foreign key reference from orders to users.
-- Update the orders table to link a user to each order.
-- Run queries against your data.
-- Get all orders for a user.
-- Get how many orders each user has.

-- 
CREATE TABLE boots (
 user_id SERIAL PRIMARY KEY, 
  first_name VARCHAR(30),
  last_name VARCHAR(30),
  email VARCHAR(70),
  product_id TEXT,
  price FLOAT(2),
  invoice_id INT
  );

SELECT * FROM boots;
-- 
CREATE TABLE vests (
 user_id SERIAL PRIMARY KEY, 
  first_name VARCHAR(30),
  last_name VARCHAR(30),
  email VARCHAR(70),
  product_id TEXT,
  price FLOAT(2),
  invoice_id INT
  );

SELECT * FROM vests;
-- 
CREATE TABLE jeans (
 user_id SERIAL PRIMARY KEY, 
  first_name VARCHAR(30),
  last_name VARCHAR(30),
  email VARCHAR(70),
  product_id TEXT,
  price FLOAT(2),
  invoice_id INT
  );

SELECT * FROM jeans;
-- 
INSERT INTO boots (first_name, last_name, email, product_id, price, invoice_id)
VALUES
('James', 'Garner', 'rockford@gmail.com', 'Sedona', 99.97, 01),
('Clint', 'Eastwood', 'blondie@gmail.com', 'Monterrey', 89.99, 02),
('Steve', 'McQueen', 'LeMansFast@gmail.com', 'Redwood', 79.99, 03);
  
SELECT * FROM boots;  
-- 
INSERT INTO vests (first_name, last_name, email, product_id, price, invoice_id)
VALUES
('James', 'Garner', 'rockford@gmail.com', 'Kansas City', 69.95, 01),
('Robert', 'Vaughn', 'AgentUNCLE@gmail.com', 'Chicago', 79.95, 02),
('Denzel', 'Washington', 'Smooth71@gmail.com', 'Harlem', 89.95, 03);
  
SELECT * FROM vests;  
-- 
INSERT INTO jeans (first_name, last_name, email, product_id, price, invoice_id)
VALUES
('Charles', 'Bronson', 'Mag7@gmail.com', 'Levi501', 49.95, 01),
('Yul', 'Bryner', 'RussianBlue@gmail.com', 'CalvinKlein3', 59.95, 02),
('James', 'Cogburn', 'InLikeFlint@gmail.com', 'Skinny7', 99.95, 03);
  
SELECT * FROM jeans;  
-- 
SELECT SUM("price")
FROM boots;

-- 
SELECT boots.email, boots.first_name, boots.last_name, boots.price, boots.product_id
FROM boots
JOIN vests
on boots.product_id = vests.product_id;

SELECT boots.email, boots.first_name, boots.last_name, boots.price, boots.product_id
FROM boots
JOIN jeans
on boots.product_id = jeans.product_id;

SELECT jeans.email, jeans.first_name, jeans.last_name, jeans.price, jeans.product_id
FROM jeans
JOIN vests
on jeans.product_id = vests.product_id;
-- 
ALTER TABLE boots
RENAME COLUMN email TO emailId;

ALTER TABLE jeans
RENAME COLUMN email TO emailId;

ALTER TABLE vests
RENAME COLUMN email TO emailId;
-- 
SELECT * 
FROM boots
WHERE emailId IN (
  SELECT emailId
  FROM vests
  WHERE last_name = 'Garner'
  );
-- 
  SELECT * 
FROM vests
WHERE emailId IN (
  SELECT emailId
  FROM boots
  WHERE user_id >= 1
  );
  -- 

