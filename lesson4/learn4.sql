/*
 Задание 1: Ранжирование продуктов по средней цене

 Задание: Ранжируйте продукты в каждой категории на основе их средней цены
(AvgPrice). Используйте таблицы OrderDetails и Products.
Результат: В результате запроса будут следующие столбцы:
● CategoryID: идентификатор категории продукта,
● ProductID: идентификатор продукта,
● ProductName: название продукта,
● AvgPrice: средняя цена продукта,
● ProductRank: ранг продукта внутри своей категории на основе средней цены в
порядке убывания
 */


WITH ProductAvgPrice AS ( -- Рассчитываем среднюю цену для каждого продукта
    SELECT
        p.CategoryID,
        p.ProductID,
        p.ProductName,
        AVG(p.Price) AS AvgPrice
    FROM Products p
    JOIN OrderDetails od ON p.ProductID = od.ProductID
    GROUP BY p.CategoryID, p.ProductID, p.ProductName
)
SELECT -- Ранжируем продукты по средней цене внутри каждой категории
    CategoryID,
    ProductID,
    ProductName,
    AvgPrice,
    RANK() OVER (PARTITION BY CategoryID ORDER BY AvgPrice DESC) AS ProductRank
FROM ProductAvgPrice;

/*
 1.Ранжируйте продукты (по ProductRank) в каждой
категории на основе их общего объема продаж
(TotalSales).
*/
WITH Productquantity AS ( -- Рассчитываем среднюю цену для каждого продукта
    SELECT
        p.CategoryID,
        p.ProductID,
        p.ProductName,
        sum(od.quantity) AS TotalSales
    FROM Products p
    JOIN OrderDetails od ON p.ProductID = od.ProductID
    GROUP BY p.CategoryID, p.ProductID, p.ProductName
)
SELECT -- Ранжируем продукты по средней цене внутри каждой категории
    CategoryID,
    ProductID,
    ProductName,
    TotalSales,
    RANK() OVER (PARTITION BY CategoryID ORDER BY TotalSales DESC) AS ProductRank
FROM Productquantity;


--1	35	Steeleye Stout	369	1
--1	2	Chang	341	2
--1	39	Chartreuse verte	266	3
--1	38	CÃƒÂ´te de Blaye	239	4
--1	76	LakkalikÃƒÂ¶ÃƒÂ¶ri	198	5
--1	70	Outback Lager	164	6
--1	1	Chais	159	7
--1	24	GuaranÃƒÂ¡ FantÃƒÂ¡stica	158	8
--1	75	RhÃƒÂ¶nbrÃƒÂ¤u Klosterbier	144	9
--1	43	Ipoh Coffee	136	10
--1	34	Sasquatch Ale	110	11
--1	67	Laughing Lumberjack Lager	5	12
--2	63	Vegie-spread	209	1
--2	44	Gula Malacca	178	2
--2	65	Louisiana Fiery Hot Pepper Sauce	175	3
--2	8	Northwoods Cranberry Sauce	140	4
--2	5	Chef Anton's Gumbo Mix	129	5
--2	77	Original Frankfurter grÃƒÂ¼ne SoÃƒÅ¸e	108	6
--2	4	Chef Anton's Cajun Seasoning	107	7
--2	61	Sirop d'ÃƒÂ©rable	106	8
--2	66	Louisiana Hot Spiced Okra	90	9
--2	3	Aniseed Syrup	80	10
--2	6	Grandma's Boysenberry Spread	36	11
--2	15	Genen Shouyu	25	12
--3	16	Pavlova	338	1
--3	62	Tarte au sucre	325	2
--3	26	GumbÃƒÂ¤r GummibÃƒÂ¤rchen	232	3
--3	68	Scottish Longbreads	199	4
--3	19	Teatime Chocolate Biscuits	181	5
--3	49	Maxilaku	180	6
--3	21	Sir Rodney's Scones	147	7
--3	20	Sir Rodney's Marmalade	106	8

--/////////////////////

/*
 Задание 2: Средняя и максимальная сумма кредита по месяцам
Задание: Рассчитайте среднюю сумму кредита (AvgCreditAmount) для каждого
кластера в каждом месяце и сравните её с максимальной суммой кредита
(MaxCreditAmount) за тот же месяц. Используйте таблицу Clusters.
Подсказка:
1. Рассчитайте среднюю сумму кредита: Используйте подзапрос (или CTE) для
вычисления средней суммы кредита (AVG(credit_amount)) для каждого
кластера в каждом месяце.
2. Рассчитайте максимальную сумму кредита: Создайте другой подзапрос для
вычисления максимальной суммы кредита (MAX(credit_amount)) для каждого
месяца.
3. Объедините результаты: Используйте JOIN для объединения результатов
двух подзапросов по месяцу и выведите нужные столбцы.
Результат: В результате запроса будут следующие столбцы:
● month: месяц,
● cluster: кластер,
● AvgCreditAmount: средняя сумма кредита для каждого кластера в каждом
месяце,
● MaxCreditAmount: максимальная сумма кредита в каждом месяце.
*/



WITH AvgCredit AS ( -- Рассчитываем среднюю сумму кредита для каждого кластера и месяца
SELECT
month,
cluster,
AVG(credit_amount) AS AvgCreditAmount
FROM Clusters
GROUP BY month, cluster
),
MaxCredit AS ( -- Рассчитываем максимальную сумму кредита для каждого месяца
SELECT
month,
MAX(credit_amount) AS MaxCreditAmount
FROM Clusters
GROUP BY month
)
SELECT -- Объединяем результаты и выводим их
a.month,
a.cluster,
round(a.AvgCreditAmount),
m.MaxCreditAmount
FROM AvgCredit a
JOIN MaxCredit m ON a.month = m.month;

/*
 Рассчитайте среднюю сумму кредита (AvgCreditAmount) для
каждого кластера и месяца, учитывая общую среднюю сумму
кредита за соответствующий месяц (OverallAvgCreditAmount).
Определите OverallAvgCreditAmount в первой строке
результатов запроса.
 */
with OverallAvgCreditAmount_1 as (
SELECT
month,
cluster,
AVG(credit_amount) AS AvgCreditAmount
FROM Clusters
GROUP BY month, cluster
)
SELECT 
month,
cluster,
AVG(AvgCreditAmount) over (PARTITION BY month) as OverallAvgCreditAmount
from OverallAvgCreditAmount_1





WITH MonthlyAverages AS (
  SELECT
    month,
    round(AVG(credit_amount)) AS OverallAvgCreditAmount
  FROM Clusters
  GROUP BY month
)
SELECT
  ma.month,
  c.cluster,
  round(AVG(c.credit_amount)) AS AvgCreditAmount,
  ma.OverallAvgCreditAmount
FROM Clusters c
JOIN MonthlyAverages ma
  ON c.month = ma.month
GROUP BY
  ma.month,
  c.cluster
ORDER BY
  ma.month,
  c.cluster;
 
 -- Или через оконные функции
 SELECT DISTINCT 
  month,
  cluster,
  round(AVG(credit_amount) OVER (PARTITION BY month, cluster)) AS AvgCreditAmount,
  round(AVG(credit_amount) OVER (PARTITION BY month)) AS OverallAvgCreditAmount
FROM Clusters
ORDER BY
  month,
  cluster;
 
-- 1	0	18000.0	26194.0
--1	2	39500.0	26194.0
--1	3	22115.0	26194.0
--1	4	33714.0	26194.0
--2	0	22452.0	30181.0
--2	2	74750.0	30181.0
--2	3	25530.0	30181.0
--2	4	31337.0	30181.0
--2	5	190500.0	30181.0
--2	6	57167.0	30181.0
--3	0	26607.0	28443.0

/*Задание 3: Разница в суммах кредита по месяцам
Задание: Создайте таблицу с разницей (Difference) между суммой кредита и
предыдущей суммой кредита по месяцам для каждого кластера. Используйте таблицу
Clusters.
Подсказка:
1. Получите сумму кредита и сумму кредита в предыдущем месяце:
Используйте функцию оконного анализа LAG() для получения суммы кредита в
предыдущем месяце в рамках каждого кластера.
 2. Вычислите разницу: Используйте результат предыдущего шага для
вычисления разницы между текущей и предыдущей суммой кредита.
Примените COALESCE() для обработки возможных значений NULL.
Примечания:
● Функция RANK() в MySQL 8.0 и выше позволяет вычислять ранг записей в
рамках заданного окна.
● Функция LAG() используется для получения значения предыдущей строки в
рамках окна.
● Функция MAX() может быть использована как оконная функция для получения
максимального значения в рамках окна данных.
Результат: В результате запроса будут следующие столбцы:
● month: месяц,
● cluster: кластер,
● credit_amount: сумма кредита,
● PreviousCreditAmount: сумма кредита в предыдущем месяце,
● Difference: разница между текущей и предыдущей суммой кредита.
*/
 
 
WITH CreditWithPrevious AS ( -- Рассчитываем сумму кредита и сумму кредита в предыдущем месяце
SELECT
month,
cluster,
credit_amount,
LAG(credit_amount) OVER (PARTITION BY cluster ORDER BY
month) AS PreviousCreditAmount
FROM Clusters
)
SELECT -- Вычисляем разницу между текущей и предыдущей суммой кредита
month,
cluster,
credit_amount,
PreviousCreditAmount,
COALESCE(credit_amount - PreviousCreditAmount, 0) AS Difference
FROM CreditWithPrevious;

/*
3.Сопоставьте совокупную сумму сумм кредита
(CumulativeSum) для каждого кластера, упорядоченную по
месяцам, и сумму кредита в порядке возрастания.
Определите CumulativeSum в первой строке результатов
запроса
*/


WITH MonthlySums AS (
  SELECT
    month,
    cluster,
    SUM(credit_amount) AS MonthlySum
  FROM Clusters
  GROUP BY
    month,
    cluster
)
SELECT
  ms.month,
  ms.cluster,
  SUM(ms.MonthlySum) OVER (PARTITION BY ms.cluster ORDER BY ms.month) AS CumulativeSum
--  ms.MonthlySum
FROM MonthlySums ms
ORDER BY
	ms.month,
  ms.cluster;
  
-- используя оконную функцию
SELECT DISTINCT 
  month,
  cluster,
  SUM(credit_amount) OVER (PARTITION BY cluster ORDER BY month) AS CumulativeSum
FROM Clusters
ORDER BY
	month,
  cluster;

 
-- 1	0	234000
--1	2	118500
--1	3	1636500
--1	4	1652000
--2	0	705500
--2	2	417500
--2	3	3321500
--2	4	2999500
--2	5	190500
--2	6	171500
3	0	1078000
