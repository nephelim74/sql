/*
 1. Посчитать средний чек одного заказа.
*/

SELECT od.OrderID , round(AVG(p.Price)) as price
FROM OrderDetails od 
join Products p on od.ProductID = p.ProductID 
GROUP BY od.OrderID
ORDER by price DESC 
/*
Средняя цена по каждому заказу:
10353	142.0
10372	103.0
10424	98.0
10360	92.0
10329	84.0
10369	81.0
10292	81.0
10268	79.0
10351	78.0
 */

/*
2. Посчитать сколько заказов доставляет в месяц каждая служба доставки.
Определите, сколько заказов доставила United Package в декабре 2023 года
*/

SELECT s.ShipperName , STRFTIME('%Y-%m', o.OrderDate) as cnt_date, COUNT(o.ShipperID) as cnt
FROM Shippers s
JOIN Orders o ON s.ShipperID = o.ShipperID 
GROUP BY s.ShipperName, cnt_date
ORDER BY s.ShipperName, cnt_date

/*
 Количество заказов доставляет в месяц каждая служба доставки:
 Federal Shipping	2023-07	9
Federal Shipping	2023-08	8
Federal Shipping	2023-09	5
Federal Shipping	2023-10	10
Federal Shipping	2023-11	10
Federal Shipping	2023-12	16
Federal Shipping	2024-01	8
Federal Shipping	2024-02	2
Speedy_Express	2023-07	7
Speedy_Express	2023-08	9
Speedy_Express	2023-09	3
Speedy_Express	2023-10	6
Speedy_Express	2023-11	6
Speedy_Express	2023-12	7
Speedy_Express	2024-01	14
Speedy_Express	2024-02	2
United Package	2023-07	6
United Package	2023-08	8
United Package	2023-09	15
United Package	2023-10	10
United Package	2023-11	9
United Package	2023-12	8
United Package	2024-01	11
United Package	2024-02	7
 */
SELECT s.ShipperName , STRFTIME('%Y-%m', o.OrderDate) as cnt_date, COUNT(o.ShipperID) as cnt
FROM Shippers s
JOIN Orders o ON s.ShipperID = o.ShipperID
WHERE s.ShipperName = 'United Package' AND cnt_date = '2023-12'
GROUP BY s.ShipperName, cnt_date
ORDER BY s.ShipperName, cnt_date

/*
 Количество заказов доставила United Package в декабре 2023 года:
 United Package	2023-12	8
 */

/*
 3. Определить средний LTV покупателя (сколько денег покупатели в среднем тратят в магазине за весь период)
 */

SELECT c.CustomerID, c.CustomerName, 0 AS LTV
FROM Customers c 
FULL JOIN Orders o ON c.CustomerID = o.CustomerID 
FULL JOIN OrderDetails od ON od.OrderID = o.OrderID 
FULL JOIN Products p ON p.ProductID = od.ProductID 
GROUP BY c.CustomerID
EXCEPT 
SELECT c.CustomerID, c.CustomerName, 0 AS LTV
FROM Customers c 
JOIN Orders o ON c.CustomerID = o.CustomerID 
JOIN OrderDetails od ON od.OrderID = o.OrderID 
JOIN Products p ON p.ProductID = od.ProductID 
GROUP BY c.CustomerID
UNION 
SELECT c.CustomerID, c.CustomerName, round(AVG(p.Price)) AS LTV
FROM Customers c 
JOIN Orders o ON c.CustomerID = o.CustomerID 
JOIN OrderDetails od ON od.OrderID = o.OrderID 
JOIN Products p ON p.ProductID = od.ProductID 
GROUP BY c.CustomerID


/*
 средний LTV покупателя за весь период:
 1	Alfreds Futterkiste	0
2	Ana Trujillo Emparedados y helados	26.0
3	Antonio Moreno TaquerÃƒÂ­a	21.0
4	Around the Horn	17.0
5	Berglunds snabbkÃƒÂ¶p	32.0
6	Blauer See Delikatessen	0
7	Blondel pÃƒÂ¨re et fils	51.0
8	BÃƒÂ³lido Comidas preparadas	16.0
9	Bon app'	29.0
10	Bottom-Dollar Marketse	27.0
11	B's Beverages	22.0
12	Cactus Comidas para llevar	0
13	Centro comercial Moctezuma	18.0
14	Chop-suey Chinese	17.0
15	ComÃƒÂ©rcio Mineiro	45.0
16	Consolidated Holdings	25.0
17	Drachenblut Delikatessend	11.0
18	Du monde entier	25.0
19	Eastern Connection	44.0
20	Ernst Handel	32.0
21	Familia Arquibaldo	11.0
22	FISSA Fabrica Inter. Salchichas S.A.	0
23	Folies gourmandes	28.0

 */
*/