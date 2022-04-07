-- https://www.youtube.com/watch?v=2vrJ9UxxAGE&ab_channel=lifemichael

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
                    
-- Question 1141
-- https://leetcode.com/problems/user-activity-for-the-past-30-days-i/
-- Write an SQL query to find the daily active user count for a period of 30 days ending 2019-07-27 inclusively.
-- A user was active on someday if they made at least one activity on that day.
DROP TABLE IF EXISTS Activity;
Create table Activity(
user_id int, 
session_id int, activity_date date, 
activity_type ENUM('open_session', 'end_session', 'scroll_down', 'send_message'));

insert into Activity (user_id, session_id, activity_date, activity_type) values ('1', '1', '2019-07-20', 'open_session');
insert into Activity (user_id, session_id, activity_date, activity_type) values ('1', '1', '2019-07-20', 'scroll_down');
insert into Activity (user_id, session_id, activity_date, activity_type) values ('1', '1', '2019-07-20', 'end_session');
insert into Activity (user_id, session_id, activity_date, activity_type) values ('2', '4', '2019-07-20', 'open_session');
insert into Activity (user_id, session_id, activity_date, activity_type) values ('2', '4', '2019-07-21', 'send_message');
insert into Activity (user_id, session_id, activity_date, activity_type) values ('2', '4', '2019-07-21', 'end_session');
insert into Activity (user_id, session_id, activity_date, activity_type) values ('3', '2', '2019-07-21', 'open_session');
insert into Activity (user_id, session_id, activity_date, activity_type) values ('3', '2', '2019-07-21', 'send_message');
insert into Activity (user_id, session_id, activity_date, activity_type) values ('3', '2', '2019-07-21', 'end_session');
insert into Activity (user_id, session_id, activity_date, activity_type) values ('4', '3', '2019-06-25', 'open_session');
insert into Activity (user_id, session_id, activity_date, activity_type) values ('4', '3', '2019-06-25', 'end_session');

SELECT activity_date AS day, COUNT(DISTINCT user_id) AS active_users
FROM Activity
WHERE activity_date > '2019-06-27' AND activity_date < '2019-07-27'
GROUP BY day;

-- Question 1148
-- https://leetcode.com/problems/article-views-i/
-- Each row of this table indicates that some viewer viewed an article (written by some author) on some date. 
-- Note that equal author_id and viewer_id indicate the same person.
-- Write an SQL query to find all the authors that viewed at least one of their own articles.
-- Return the result table sorted by id in ascending order.

DROP TABLE IF EXISTS Views;
Create table Views (
article_id int, 
author_id int, 
viewer_id int, 
view_date date);
insert into Views (article_id, author_id, viewer_id, view_date) values ('1', '3', '5', '2019-08-01');
insert into Views (article_id, author_id, viewer_id, view_date) values ('1', '3', '6', '2019-08-02');
insert into Views (article_id, author_id, viewer_id, view_date) values ('2', '7', '7', '2019-08-01');
insert into Views (article_id, author_id, viewer_id, view_date) values ('2', '7', '6', '2019-08-02');
insert into Views (article_id, author_id, viewer_id, view_date) values ('4', '7', '1', '2019-07-22');
insert into Views (article_id, author_id, viewer_id, view_date) values ('3', '4', '4', '2019-07-21');
insert into Views (article_id, author_id, viewer_id, view_date) values ('3', '4', '4', '2019-07-21');

SELECT author_id AS id
FROM Views
GROUP BY author_id
HAVING author_id IN (SELECT viewer_id FROM Views WHERE viewer_id = author_id)
ORDER BY author_id;

-- Question 175
-- https://leetcode.com/problems/combine-two-tables/
-- Write an SQL query to report the first name, last name, city, and state of each person in the Person table. 
Create table If Not Exists Person (
personId int, 
firstName varchar(255), 
lastName varchar(255));

Create table If Not Exists Address (
addressId int, 
personId int, 
city varchar(255), 
state varchar(255));


insert into Person (personId, lastName, firstName) values ('1', 'Wang', 'Allen');
insert into Person (personId, lastName, firstName) values ('2', 'Alice', 'Bob');

insert into Address (addressId, personId, city, state) values ('1', '2', 'New York City', 'New York');
insert into Address (addressId, personId, city, state) values ('2', '3', 'Leetcode', 'California');

SELECT firstName,lastName, city, state
FROM Person 
LEFT JOIN Address ON Person.personID = Address.personID;

-- Question 181
-- https://leetcode.com/problems/employees-earning-more-than-their-managers/

DROP TABLE IF EXISTS Employee;
Create table If Not Exists Employee (
id int, 
name varchar(255), 
salary int,
managerId VARCHAR(50));
insert into Employee (id, name, salary, managerId) values ('1', 'Joe', '70000', '3');
insert into Employee (id, name, salary, managerId) values ('2', 'Henry', '80000', '4');
insert into Employee (id, name, salary, managerId) values ('3', 'Sam', '60000', 'None');
insert into Employee (id, name, salary, managerId) values ('4', 'Max', '90000', 'None');

SELECT E1.name
FROM Employee E1 
JOIN Employee E2 ON E1.managerID=E2.id
WHERE E2.salary < E1.salary;

-- Question 183
-- https://leetcode.com/problems/customers-who-never-order/
DROP TABLE IF EXISTS Customers;
Create table Customers (
id int, 
name varchar(255));

DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders(
id int, 
customerId int);

insert into Customers (id, name) values ('1', 'Joe');
insert into Customers (id, name) values ('2', 'Henry');
insert into Customers (id, name) values ('3', 'Sam');
insert into Customers (id, name) values ('4', 'Max');

insert into Orders (id, customerId) values ('1', '3');
insert into Orders (id, customerId) values ('2', '1');

SELECT name FROM Customers
LEFT JOIN Orders ON Customers.id = Orders.customerid 
  WHERE NOT EXISTS (SELECT * FROM Customers
                    WHERE Customers.id =  Orders.customerid);


-- Question 197 
-- https://leetcode.com/problems/rising-temperature/
-- Write an SQL query to find all dates' Id with higher temperatures compared to its previous dates
DROP TABLE IF EXISTS Weather;
CREATE TABLE Weather (
id int, 
recordDate date, 
temperature int);

insert into Weather (id, recordDate, temperature) values ('1', '2015-01-01', '10');
insert into Weather (id, recordDate, temperature) values ('2', '2015-01-02', '25');
insert into Weather (id, recordDate, temperature) values ('3', '2015-01-03', '20');
insert into Weather (id, recordDate, temperature) values ('4', '2015-01-04', '30');

SELECT W2.id
FROM Weather W1
JOIN Weather W2 ON W1.id = (W2.id-1)
WHERE W1.temperature < W2.temperature;

-- Question 512
-- https://programmer.ink/think/leetcode-sql-game-play-analysis.html
-- Write an SQL query statement to get the date when each player first landed on the platform.
-- revisit !!!!
DROP TABLE IF EXISTS player;
CREATE TABLE player(
player_id int, 
device_id int, 
event_date date,
games_played int);

insert into player (player_id, device_id, event_date,games_played) values ('1','2','2016-03-01','5');
insert into player (player_id, device_id, event_date,games_played) values ('1','2','2016-05-02','6');
insert into player (player_id, device_id, event_date,games_played) values ('2','3','2017-06-25','1');
insert into player (player_id, device_id, event_date,games_played) values ('3','1','2016-03-02','0');
insert into player (player_id, device_id, event_date,games_played) values ('3','4','2018-07-03','5');

select a.player_id, a.device_id
from player a JOIN
(select player_id, min(event_date) 'first_login'
from player group by player_id) t
ON a.player_id=t.player_id and a.event_date = t.first_login;

-- Question 577
-- https://www.datageekinme.com/general/leetcode/leetcode-sql-577-employee-bonus/
-- Select all employee’s name and bonus whose bonus is < 1000.
DROP TABLE IF EXISTS Employee;
Create table Employee (
    EmpId int, 
    Name varchar(255), 
    Supervisor int, 
    Salary int);

DROP TABLE IF EXISTS Bonus;
Create table Bonus (
    EmpId int, 
    Bonus int);

insert into Employee (EmpId, Name, Supervisor, Salary) 
    values ('3', 'Brad', null, '4000');
insert into Employee (EmpId, Name, Supervisor, Salary) 
    values ('1', 'John', '3', '1000');
insert into Employee (EmpId, Name, Supervisor, Salary) 
    values ('2', 'Dan', '3', '2000');
insert into Employee (EmpId, Name, Supervisor, Salary) 
    values ('4', 'Thomas', '3', '4000');


insert into Bonus (EmpId, Bonus) 
    values ('2', '500');
insert into Bonus (EmpId, Bonus) 
    values ('4', '2000');

SELECT Name, Bonus
FROM Employee
LEFT JOIN Bonus ON Employee.empid = Bonus.empid
WHERE Bonus IS NULL OR Bonus <= 500;

-- Question 607
-- https://leetcode.com/problems/sales-person/
-- Write an SQL query to report the names of all the salespersons who did not have any orders related to the company with the name "RED".
-- Revisit !!! 
DROP TABLE IF EXISTS SalesPerson;
Create table SalesPerson (
sales_id int, 
name varchar(255), 
salary int, 
commission_rate int, 
hire_date date);

DROP TABLE IF EXISTS Company; 
Create table Company (
com_id int, 
name varchar(255), 
city varchar(255));

DROP TABLE IF EXISTS Orders;
Create table Orders (
order_id int, 
order_date date, 
com_id int, 
sales_id int, 
amount int);

insert into SalesPerson (sales_id, name, salary, commission_rate, hire_date) values ('1', 'John', '100000', '6', '2016-04-01');
insert into SalesPerson (sales_id, name, salary, commission_rate, hire_date) values ('2', 'Amy', '12000', '5', '2010-05-01');
insert into SalesPerson (sales_id, name, salary, commission_rate, hire_date) values ('3', 'Mark', '65000', '12', '2008-12-25');
insert into SalesPerson (sales_id, name, salary, commission_rate, hire_date) values ('4', 'Pam', '25000', '25', '2005-01-01');
insert into SalesPerson (sales_id, name, salary, commission_rate, hire_date) values ('5', 'Alex', '5000', '10', '2007-02-03');

insert into Company (com_id, name, city) values ('1', 'RED', 'Boston');
insert into Company (com_id, name, city) values ('2', 'ORANGE', 'New York');
insert into Company (com_id, name, city) values ('3', 'YELLOW', 'Boston');
insert into Company (com_id, name, city) values ('4', 'GREEN', 'Austin');

insert into Orders (order_id, order_date, com_id, sales_id, amount) values ('1', '2014-01-01', '3', '4', '10000');
insert into Orders (order_id, order_date, com_id, sales_id, amount) values ('2', '2014-02-01', '4', '5', '5000');
insert into Orders (order_id, order_date, com_id, sales_id, amount) values ('3', '2014-03-01', '1', '1', '50000');
insert into Orders (order_id, order_date, com_id, sales_id, amount) values ('4', '2014-04-01', '1', '4', '25000');

SELECT name
FROM Salesperson
WHERE Salesperson.sales_id NOT IN (
SELECT Orders.sales_id
FROM Orders 
LEFT JOIN Company ON Orders.com_id = Company.com_id
WHERE Company.name = 'RED');

-- ATTEMPT 1
-- SELECT SalesPerson.name
-- FROM Orders
-- LEFT JOIN Company ON Orders.com_id = Company.com_id
-- LEFT JOIN SalesPerson ON Orders.sales_id = SalesPerson.sales_id
-- WHERE Company.name = 'RED'

-- ATTEMPT 2
-- SELECT *
-- FROM Orders
-- LEFT JOIN Company ON Orders.com_id = Company.com_id
-- LEFT JOIN SalesPerson ON Orders.sales_id = SalesPerson.sales_id
-- HAVING NOT Company.name ='RED';

