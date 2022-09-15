/* Creating the detailed table */
/* This will show all the rentals that an employee has been a part of */
CREATE TABLE DETAILED (
rental_id INT PRIMARY KEY,
last_name VARCHAR(50),
first_name VARCHAR(50),
staff_id INT,
rental_date TIMESTAMP,
email VARCHAR(50),
address_id VARCHAR(90)
customer_id INT,
store_id INT
);
/* Check if detailed table exists */
SELECT *
FROM detailed
/* Creating summary table */
/* This table is a more condensed version of the detailed table and will show the employee’s full
name, their staff id, their email to send rewards, and all_rentals
CREATE TABLE SUMMARY (
staff_id INT PRIMARY KEY,
complete_name VARCHAR(90),
email VARCHAR(90),
all_rentals INT
);
/* Check if summary table exists */
SELECT *
FROM summary
/* INSERTING DATA FROM THE GIVEN TABLES INTO DETAILED SECTION OF
REPORT */
INSERT INTO DETAILED(rental_id, last_name, first_name, staff_id , rental_date, email,
address_id, customer_id, store_id)
SELECT r.rental_id, s.last_name, s.first_name, s.staff_id, r.rental_date , s.email, s. address_id,
r.customer_id, s.store_id
FROM rental AS r
JOIN staff as S ON r.staff_id = s.staff_id;
/* CHECK IF INFORMATION HAS BEEN STORED IN DETAILED TABLE */
SELECT * FROM DETAILED;
/* INSERT INTO summary table INFORMATION FROM THE DETAILED TABLE THAT IS
NEEDED */
INSERT INTO SUMMARY (
SELECT staff_id,
CONCAT(last_name,’ ‘, first_name) AS complete_name,
email,
COUNT(staff_id)
FROM DETAILED
GROUP BY staff_id, complete_name, email
ORDER BY COUNT(staff_id) DESC
);
/* CHECK IF INFORMATION HAS BEEN STORES IN SUMMARY TABLE */
SELECT* FROM SUMMARY;
/* I will create a function that will be able to clear out the old summary table and insert new data
into it*/
/* The transformation are concating the last and first name into on complete name, and adding up
the the total rental sales a staff member makes to a customer using COUNT*/
CREATE FUNCTION reset_summary_table_function()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
/* DELETE FROM OLD SUMMARY TABLE */
DELETE FROM SUMMARY;
/* INSERTING NEW DATA INTO SUMMARY TABLE */
INSERT INTO SUMMARY (
SELECT staff_id,
SELECT CONCAT(last_name,’ ‘, first_name) AS complete_name,
email,
COUNT(staff_id)
FROM DETAILED
GROUP BY staff_id, complete_name, email
ORDER BY COUNT(staff_id) DESC
);
/* RETURN THE NEW SUMMARY TABLE WITH NEW DATA*/
RETURN NEW;
/* END THE FUNCTION*/RETURN
END;$$
CREATE TRIGGER reset_summary_table_trigger
AFTER INSERT ON DETAILED
FOR EACH STATEMENT
EXECUTE PROCEDURE reset_summary_table_function();
/* The following procedure can run whenever the DVD rental store management feels like giving
out rewards, it could be after a month or 6 months etc. It is also possible to write a script so the
function can be run automatically instead of manually each time by a database administrator */
CREATE PROCEDURE reset_tables()
LANGUAGE plpgsql
AS $$
BEGIN
/* OLD DATA DELETED FROM DETAILED TABLE*/
DELETE FROM DETAILED;
INSERT INTO DETAILED(rental_id, last_name, first_name, staff_id , rental_date, email,
address_id, customer_id, store_id)
SELECT r.rental_id, s.last_name, s.first_name, s.staff_id, r.rental_date , s.email, s.address_id,
r.customer_id, s.store_id
FROM rental AS r
JOIN staff as s ON r.staff_id = s.staff_id;
/* OLD DATA DELETED FROM SUMMARY TABLE*/
DELETE FROM SUMMARY;
INSERT INTO SUMMARY (
SELECT staff_id,
CONCAT(last_name,’ ‘, first_name) AS complete_name,
email,
COUNT(staff_id)
FROM DETAILED
GROUP BY staff_id, complete_name, email
ORDER BY COUNT(staff_id) DESC
);
END; $$
/* TO CALL THE STORED PROCEDURE*/
CALL reset_tables()
SELECT * FROM SUMMARY
