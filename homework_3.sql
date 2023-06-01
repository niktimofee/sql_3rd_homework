CREATE DATABASE IF NOT EXISTS homework_3;

USE homework_3;

/* ЧАСТЬ 1 */

CREATE TABLE IF NOT EXISTS salespeople (
	id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    snum INT NOT NULL,
    sname VARCHAR(25) NOT NULL,
    city VARCHAR(25),
    comm DECIMAL(3,2)
);

INSERT INTO salespeople (snum, sname, city, comm) 
VALUES
	(1001, "Peel", "London", 0.12),
	(1002, "Serres", "San Jose", 0.13),
	(1004, "Motika", "London", 0.11),
	(1007, "Rifkin", "Barcelona", 0.15),
	(1003, "Axelrod", "New York", 0.10);
    
CREATE TABLE IF NOT EXISTS customers (
	id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    cnum INT NOT NULL,
    cname VARCHAR(25) NOT NULL,
    city VARCHAR(25),
    rating INT,
    snum INT
);

INSERT INTO customers(cnum, cname, city, rating, snum) 
VALUES
	(2001, "Hoffman", "London", 100, 1001),
	(2002, "Giovanni", "Rome", 200, 1003),
	(2003, "Liu", "SanJose", 200, 1002),
	(2004, "Grass", "Berlin", 300, 1002),
	(2006, "Clemens", "London", 100, 1001),
	(2008, "Cisneros", "SanJose", 300, 1007),
	(2007, "Pereira", "Rome", 100, 1004);

CREATE TABLE IF NOT EXISTS orders (
	id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    onum INT NOT NULL,
    amt DECIMAL(6,2),
    odate DATE,
    cnum INT NOT NULL,
    snum INT NOT NULL
);

INSERT INTO orders(onum, amt, odate, cnum, snum) 
VALUES
	(3001, 18.69, '1990-03-10', 2008, 1007),
	(3003, 767.19, '1990-03-10', 2001, 1001),
	(3002, 1900.10, '1990-03-10', 2007, 1004),
	(3005, 5160.45, '1990-03-10', 2003, 1002),
	(3006, 1098.16, '1990-03-10', 2008, 1007),
	(3009, 1713.23, '1990-04-10', 2002, 1003),
	(3007, 75.75, '1990-04-10', 2004, 1002),
	(3008, 4723.00, '1990-05-10', 2006, 1001),
	(3010, 1309.95, '1990-06-10', 2004, 1002),
	(3011, 9891.88, '1990-06-10', 2006, 1001);

/* Задание 1. Написать запрос, который выводить таблицу со столбцами в следующем порядке: city, sname, 
snum, comm. (к первой или второй таблице, используя SELECT) */

SELECT 
	city, 
	sname, 
	snum, 
	comm 
FROM salespeople;

/* Задание 2. Написать команду SELECT, которая выводит оценку(rating), сопровождаемую именем 
каждого заказчика в городе San Jose. (“заказчики”) */

SELECT 
	rating, 
    cname 
FROM customers
WHERE city = 'SanJose';

/* Задание 3. Написать запрос, который выводит значения snum всех продавцов из таблицы заказов без 
каких бы то ни было повторений. (уникальные значения в “snum“ “Продавцы”) */

SELECT DISTINCT 
	snum 
FROM orders;

/* Задание 4 (*). Написать запрос, который выбирает заказчиков, чьи имена начинаются с буквы G. 
Используется оператор "LIKE": (“заказчики”) */

SELECT 
	cname 
FROM customers
WHERE cname LIKE 'G%';

/* Задание 5. Написать запрос, который выдаёт все заказы со значениями суммы выше чем $1,000.
(“Заказы”, “amt” - сумма) */

SELECT 
	* 
FROM orders
WHERE amt > 1000;

/* Задание 6. Написать запрос который выбирает наименьшую сумму заказа.
(Из поля “amt” - сумма в таблице “Заказы” выбрать наименьшее значение) */

SELECT 
	MIN(amt) AS min_amount 
FROM orders;

/* Задание 7. Написать запрос к таблице “Заказчики”, который показывает всех заказчиков, у которых 
рейтинг больше 100 и они находятся не в Риме. */

SELECT 
	* 
FROM customers
WHERE city != 'Rome' AND rating > 100;

/* ЧАСТЬ 2 */

CREATE TABLE IF NOT EXISTS employee (
	id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    firstname VARCHAR(25) NOT NULL,
    surname VARCHAR(25) NOT NULL,
    specialty  VARCHAR(25) NOT NULL,
    seniority INT,
    salary INT,
    аgе INT
);

INSERT INTO employee (firstname, surname, specialty, seniority, salary, аgе) 
VALUES
	('Вася', 'Васькин', 'начальник', 40, 100000, 60),
	('Петя', 'Петькин', 'начальник', 8, 70000, 30),
	('Катя', 'Каткина', 'инженер', 2, 70000, 25),
	('Саша', 'Сашкин', 'инженер', 12, 50000, 35),
	('Иван', 'Иванов', 'рабочий', 40, 30000, 59),
	('Петр', 'Петров', 'рабочий', 20, 25000, 40),
	('Сидор', 'Сидоров', 'рабочий', 10, 20000, 35),
	('Антон', 'Антонов', 'рабочий', 8, 19000, 28),
	('Юра', 'Юркин', 'рабочий', 5, 15000, 25),
	('Максим', 'Воронин', 'рабочий', 2, 11000, 22),
	('Юра', 'Галкин', 'рабочий', 3, 12000, 24),
	('Люся', 'Люськина', 'уборщик', 10, 10000, 49);
    
/* Задание 1. Отсортировать поле “зарплата” в порядке убывания и возрастания */

SELECT 
	salary 
FROM employee 
ORDER BY salary DESC;

SELECT 
	salary 
FROM employee 
ORDER BY salary;

/* Задание 2 (*). Отсортировать по возрастанию поле “Зарплата” и вывести 5 строк с 
наибольшей заработной платой (возможен подзапрос) */

SELECT 
	* 
FROM (
	SELECT 
		* 
	FROM employee 
    ORDER BY salary DESC 
    LIMIT 5) AS tb
 ORDER BY salary;

/* Задание 3. Выполнить группировку всех сотрудников по специальности , 
суммарная зарплата которых превышает 100000 */

SELECT
	specialty,
	SUM(salary) AS money
FROM employee
GROUP BY specialty
HAVING money > 100000;
