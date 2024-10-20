--1. В каких странах проживают наши клиенты (таблица Customers)?
SELECT DISTINCT Country FROM Customers;
--Germany
--Mexico
--UK
--Sweden
--France
--Spain
--Canada
--Argentina
--Switzerland
--Brazil
--Austria
--Italy
--Portugal
--USA
--Venezuela
--Ireland
--Belgium
--Norway
--Denmark
--Finland
--Poland
--Сколько уникальных стран вы получили в ответе?
SELECT DISTINCT COUNT(DISTINCT Country) AS 'Количество стран' FROM Customers;
-- Количество уникальных стран - 21

--2. Сколько клиентов проживает в Argentina?
SELECT DISTINCT COUNT(DISTINCT CustomerID) AS 'Проживает в Аргентине' FROM Customers
WHERE Country = 'Argentina';

--Проживает в Аргентине клиентов в количестве 3 человек.
--3. Посчитайте среднюю цену и количество товаров в 8 категории (таблица Products ).
SELECT AVG(Price) AS 'Средняя цена в 8 категории', COUNT(*) AS 'Количество товаров в 8 категории' FROM Products
WHERE CategoryID = 8;
--Средняя цена в 8 категории товаров - 20,68
--Количество товаров в 8 категории - 12

--4. Посчитайте средний возраст работников (таблица Employees)
SELECT (AVG(CAST(JULIANDAY(DATE()) / 365.25 - JULIANDAY(BirthDate) / 365.25 AS INTEGER))) AS 'Средний возраст работников'
FROM Employees;
-- Средний возраст равен 66 с половиной лет
--5. Вам необходимо получить заказы, которые сделаны в течении 35 дней до даты 2023-10-10 (то есть с 5
--сентября до 10 октября включительно). Использовать функцию DATEDIFF, определить переменные для
--даты и диапазона.
SELECT * FROM Orders
WHERE OrderDate BETWEEN '2023-09-05' AND '2023-10-10' 
ORDER BY OrderDate;
-- Заказы
--10298	37	6	2023-09-05	2
--10299	67	4	2023-09-06	2
--10300	49	2	2023-09-09	2
--10301	86	8	2023-09-09	2
--10302	76	4	2023-09-10	2
--10303	30	7	2023-09-11	2
--10304	80	1	2023-09-12	2
--10305	55	8	2023-09-13	3
--10306	69	1	2023-09-16	3
--10307	48	2	2023-09-17	2
--10308	2	7	2023-09-18	3
--10309	37	3	2023-09-19	1
--10310	77	8	2023-09-20	2
--10311	18	1	2023-09-20	3
--10312	86	2	2023-09-23	2
--10313	63	2	2023-09-24	2
--10314	65	1	2023-09-25	2
--10315	38	4	2023-09-26	2
--10316	65	1	2023-09-27	3
--10317	48	6	2023-09-30	1
--10318	38	8	2023-10-01	2
--10319	80	7	2023-10-02	3
--10320	87	5	2023-10-03	3

--10321	38	3	2023-10-03	2
--10322	58	7	2023-10-04	3
--10323	39	4	2023-10-07	1
--10324	71	9	2023-10-08	1
--10325	39	1	2023-10-09	3
--10326	8	4	2023-10-10	2

-- Определите CustomerID, который оказался в первой строке запроса.
SELECT * FROM Customers
WHERE CustomerId = (SELECT CustomerId FROM Orders WHERE OrderDate BETWEEN '2023-09-05' AND '2023-10-10' 
ORDER BY OrderDate ASC 
LIMIT 1 );
--37	Hungry Owl All-Night Grocers	Patricia McKenna	8 Johnstown Road	Cork

--6. Вам необходимо получить количество заказов за сентябрь месяц  через LIKE, с
--помощью YEAR и MONTH и сравнение начальной и конечной даты).
SELECT COUNT(*) AS 'Количество заказов за Сентябрь' FROM Orders
WHERE OrderDate LIKE '2023-09-%';
-- Количество заказов за Сентябрь 23

--7. Вам необходимо получить количество заказов за сентябрь месяц через функцию strftime
SELECT COUNT(*) AS 'Количество заказов за Сентябрь' FROM Orders
WHERE strftime('%Y', OrderDate) = '2023' AND strftime('%m', OrderDate) = '09';
-- Количество заказов за Сентябрь 23

--8. Вам необходимо получить количество заказов за сентябрь месяц через сравнение начальной и конечной даты.
SELECT COUNT(*) AS 'Количество заказов за Сентябрь' FROM Orders
WHERE OrderDate BETWEEN '2023-09-01' AND '2023-09-30';
-- Количество заказов за Сентябрь 23
