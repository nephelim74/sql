/*
1. Вам необходимо проверить влияние семейного
положения (family_status) на средний	доход
клиентов (income) и запрашиваемый кредит
(credit_amount) .
*/

select family_status, round(AVG(income)) as inc_average, round(AVG(credit_amount)) as redut_average  FROM Clusters c 
group by family_status
ORDER by inc_average

/*
Как видим наименьший доход имеют состоящие в браке, а так же меньше берут кредитов
Наиболший доход имеют люди состоящие вне брака, при этом запрашиваемые размеры кредитов у них больше чем у людей состоящих в браке.ю но чуть меньше, чем у людей 
с остальныи типом семейного положения
*/

/*
2. Сколько товаров в категории Meat/Poultry.
*/
SELECT 
    (SELECT CategoryName FROM Categories WHERE CategoryID = p.CategoryID) AS CategoryName,
    COUNT(ProductID) AS ProductCount
FROM Products p
WHERE p.CategoryID IN (SELECT CategoryID FROM Categories WHERE CategoryName LIKE '%Meat/Poultry%')
GROUP BY 
    CategoryName;
/*
 В таблице Products найдено 6 продуктов оносящихся к категории с названием CategoryName = Meat/Poultry
 */
   
 /*
  3. Какой товар (название) заказывали в сумме в
самом большом количестве (sum(Quantity) в
таблице OrderDetails) 
  */
SELECT  (SELECT ProductName  FROM Products WHERE ProductID = o.ProductID ) as ProductName,
SUM(Quantity) as count_product FROM OrderDetails o
WHERE o.ProductID IN (SELECT ProductID FROM Products p)
GROUP BY ProductID 
ORDER by count_product DESC limit 1;
/*
 Наибольшее количество 458 в сумме заказали сыр "gorgonzola telino"
 */
*/