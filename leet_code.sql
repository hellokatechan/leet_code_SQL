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

-- Question 620 
-- https://leetcode.com/problems/not-boring-movies/
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

-- Question 1050 
-- https://leetcode.com/problems/actors-and-directors-who-cooperated-at-least-three-times/
-- review
DROP TABLE IF EXISTS ActorDirector;
CREATE TABLE ActorDirector(
actor_id int, 
director_id int, 
timestamp int);
insert into ActorDirector (actor_id, director_id, timestamp) values ('1', '1', '0');
insert into ActorDirector (actor_id, director_id, timestamp) values ('1', '1', '1');
insert into ActorDirector (actor_id, director_id, timestamp) values ('1', '1', '2');
insert into ActorDirector (actor_id, director_id, timestamp) values ('1', '2', '3');
insert into ActorDirector (actor_id, director_id, timestamp) values ('1', '2', '4');
insert into ActorDirector (actor_id, director_id, timestamp) values ('2', '1', '5');
insert into ActorDirector (actor_id, director_id, timestamp) values ('2', '1', '6');

SELECT * 
FROM ActorDirector;

SELECT actor_id, director_id
FROM ActorDirector
GROUP BY actor_id, director_id
HAVING count(*) = 
(SELECT COUNT(DISTINCT actor_id, director_id) AS cnt
FROM ActorDirector
GROUP BY actor_id
ORDER BY cnt DESC
LIMIT 1);

COUNT(DISTINCT actor_id, director_id) >=3;

SELECT COUNT(DISTINCT actor_id, director_id) AS cnt
FROM ActorDirector
ORDER actor_id, director_id;


-- Question 1069
-- https://circlecoder.com/product-sales-analysis-II/
-- Write an SQL query that reports the total quantity sold for every product id.
DROP TABLE IF EXISTS sales;
CREATE TABLE sales(
sale_id int, 
product_id int, 
year int, 
quantity int,
price int
);
insert into sales (sale_id, product_id, year, quantity, price) values ('1', '100','2008','10','5000');
insert into sales (sale_id, product_id, year, quantity, price) values ('2', '100','2009','12','5000');
insert into sales (sale_id, product_id, year, quantity, price) values ('7', '200','2011','15','9000');

DROP TABLE IF EXISTS product;
CREATE TABLE product(
product_id int, 
product_name VARCHAR(100)
);
insert into product (product_id, product_name) values ('100','Nokia');
insert into product (product_id, product_name) values ('200','Apple');
insert into product (product_id, product_name) values ('300','Samsung');

SELECT sales.product_id, SUM(quantity)
FROM sales
LEFT JOIN product ON sales.product_id = product.product_id
GROUP BY sales.product_id;

-- Question 1076 
-- https://xingxingpark.com/Leetcode-1076-Project-Employees-II/
-- Write an SQL query that reports all the projects that have the most employees.
-- review
DROP TABLE IF EXISTS project;
CREATE TABLE project(
project_id int, 
employee_id int
);
insert into project(project_id, employee_id) values ('1','1');
insert into project(project_id, employee_id) values ('1','2');
insert into project(project_id, employee_id) values ('1','3');
insert into project(project_id, employee_id) values ('2','1');
insert into project(project_id, employee_id) values ('2','4');

DROP TABLE IF EXISTS employee;
CREATE TABLE employee(
employee_id int, 
name VARCHAR(200),
experience_years int
);
insert into employee(employee_id, name,experience_years) values ('1','Khaled','3');
insert into employee(employee_id, name,experience_years) values ('2','Ali','2');
insert into employee(employee_id, name,experience_years) values ('3','John','1');
insert into employee(employee_id, name,experience_years) values ('4','Doe','2');

SELECT project_id, COUNT(project_id) AS total_num_project
FROM employee
LEFT JOIN project ON employee.employee_id = project.employee_id
GROUP BY project_id
ORDER BY COUNT(project_id) DESC LIMIT 1;

SELECT project_id
FROM project 
GROUP BY project_id
HAVING COUNT(*) = 
(SELECT COUNT(employee_id) AS cnt 
    FROM Project 
    GROUP BY project_id 
    ORDER BY cnt DESC 
    LIMIT 1);

-- Question 1082
-- https://ladychili.top/leetcode/sql/1082.SalesAnalysisI.html
-- Reports the best seller by total sales price, If there is a tie, report them all.
-- review
DROP TABLE IF EXISTS product;
CREATE TABLE product(
product_id int, 
product_name VARCHAR(200),
unit_price int
);
insert into product(product_id, product_name,unit_price) values ('1','s8','1000');
insert into product(product_id, product_name,unit_price) values ('2','G4','800');
insert into product(product_id, product_name,unit_price) values ('3','iphone','1400');

DROP TABLE IF EXISTS sales;
CREATE TABLE sales(
seller_id  int, 
product_id  int,
buyer_id int,
sale_date date,
quantity int,
price int
);
insert into sales(seller_id, product_id,buyer_id,sale_date,quantity,price) values ('1','1','1','2019-01-21','2','2000');
insert into sales(seller_id, product_id,buyer_id,sale_date,quantity,price) values ('1','2','2','2019-02-17','1','800');
insert into sales(seller_id, product_id,buyer_id,sale_date,quantity,price) values ('2','2','3','2019-06-02','1','800');
insert into sales(seller_id, product_id,buyer_id,sale_date,quantity,price) values ('3','3','4','2019-05-13','2','2800');

SELECT sum(price)
FROM sales
GROUP BY seller_id
ORDER BY sum(price) desc;

SELECT seller_id
FROM sales
GROUP BY seller_id
HAVING SUM(price) = (SELECT SUM(price)
                    FROM sales
                    GROUP BY seller_id
                    ORDER BY SUM(price) DESC
                    LIMIT 1);
                    
-- test