-- Question 182
-- https://leetcode.com/problems/duplicate-emails/
SELECT email
FROM ex1
GROUP BY email
HAVING COUNT(email) > 1;
SELECT player_id, MIN(event_date) AS first_login
FROM Activity
GROUP BY player_id; 

-- Question 511 
-- https://leetcode.com/problems/game-play-analysis-i/ 
SELECT player_id, MIN(event_date) AS first_login
FROM Activity
GROUP BY player_id; 

-- Question 584
-- https://leetcode.com/problems/find-customer-referee/ 
SELECT name 
FROM customer 
WHERE NOT referee_id = 2 OR referee_id IS NULL;

-- Question 586
-- https://leetcode.com/problems/customer-placing-the-largest-number-of-orders/
DROP DATABASE IF EXISTS leetcode;
CREATE DATABASE leetcode;
USE leetcode;
DROP TABLE IF EXISTS leetcode; 
CREATE TABLE leetcode(
order_number INT(2), 
customer_number INT(2)
);

INSERT INTO leetcode (order_number, customer_number) VALUES(1,1);
INSERT INTO leetcode (order_number, customer_number) VALUES(2,2);
INSERT INTO leetcode (order_number, customer_number) VALUES(3,1);
INSERT INTO leetcode (order_number, customer_number) VALUES(4,3);

SELECT customer_number
FROM leetcode
GROUP BY customer_number
ORDER BY count(order_number) DESC LIMIT 1;

-- Question 595
-- https://leetcode.com/problems/big-countries/
SELECT name, population, area
FROM world
WHERE area >= 3000000 OR population >= 25000000;

-- Question 596
-- https://leetcode.com/problems/classes-more-than-5-students/
SELECT class
FROM courses
GROUP BY class
HAVING COUNT(DISTINCT student) >= 5;

-- Question 619 
-- Write a SQL query to find the biggest number, which only appears once
DROP TABLE IF EXISTS leetcode_619; 
CREATE TABLE leetcode_619(
num INT(2)
);
INSERT INTO leetcode_619 (num) VALUES(8);
INSERT INTO leetcode_619 (num) VALUES(8);
INSERT INTO leetcode_619 (num) VALUES(3);
INSERT INTO leetcode_619 (num) VALUES(3);
INSERT INTO leetcode_619 (num) VALUES(1);
INSERT INTO leetcode_619 (num) VALUES(4);
INSERT INTO leetcode_619(num) VALUES(5);
INSERT INTO leetcode_619(num) VALUES(6);

SELECT * 
FROM leetcode_619;

SELECT num
FROM leetcode_619
GROUP BY num
HAVING count(num) = 1
ORDER BY num DESC LIMIT 1; 

--
-- 
DROP TABLE IF EXISTS leetcode_620; 
CREATE TABLE leetcode_620(
id INT(2),
movie VARCHAR(50),
description VARCHAR(50),
rating float
);
INSERT INTO leetcode_620 (id,movie,description,rating) VALUES(1,'war','great 3D',8.9);
INSERT INTO leetcode_620 (id,movie,description,rating) VALUES(2,'science','fiction',8.5);
INSERT INTO leetcode_620 (id,movie,description,rating) VALUES(3,'irish','boring',6.2);
INSERT INTO leetcode_620 (id,movie,description,rating) VALUES(4,'ice song','fantacy',8.6);
INSERT INTO leetcode_620 (id,movie,description,rating) VALUES(5,'house card','interesting',9.1);

SELECT id, movie, description, rating
FROM leetcode_620
WHERE id IN (SELECT id FROM leetcode_620 WHERE id%2)
AND description NOT IN ('boring')
ORDER BY rating DESC;

