CREATE database IF NOT EXISTS `sql_dz_final#5`;

USE sql_dz_final#5;
/*1. Создайте хранимую процедуру с именем «GetEmployeeOrders».
который принимает идентификатор сотрудника в качестве
параметра и возвращает все заказы, обработанные этим
сотрудником.
Пропишите запрос, который создаст требуемую процедуру.
*/



CREATE PROCEDURE GetEmployeeOrders(in p_shipperId INTEGER)
BEGIN
	SELECT 
	e.lastname ,
	e.firstname,
	o2.orderid,
	p.productname 
	FROM orders o
	JOIN orderdetails o2 ON o.orderid = o2.orderid
	JOIN products p ON o2.productid = p.productid 
	JOIN employees e ON e.employeeid = o.employeeid 
	WHERE o.employeeid = p_shipperId
	ORDER BY o.orderid;
END;
-- Вызов процедуры с id 5 
CALL GetEmployeeOrders(5)

/*
 2. Создайте таблицу EmployeeRoles, как на уроке и удалите ее.
Напишите запрос, который удалит нужную таблицу
 */


CREATE TABLE EmployeeRoles (
EmployeeRoleID INT PRIMARY KEY AUTO_INCREMENT,
EmployeeID INT,
Role VARCHAR(50)
);

DESCRIBE EmployeeRoles;
-- EmployeeRoleID	int	NO	PRI		auto_increment
-- EmployeeID	int	YES			
-- Role	varchar(50)	YES			

INSERT INTO EmployeeRoles (EmployeeID,`Role` ) VALUES (1021, 'Менеджер');
INSERT INTO EmployeeRoles (EmployeeID,`Role` ) VALUES (13647, 'Инженер');

SELECT * FROM EmployeeRoles;
-- 1	1021	Менеджер
-- 2	13647	Инженер

-- Удаление данных
DELETE FROM EmployeeRoles;

-- Удаление таблицы
DROP TABLE EmployeeRoles;

/*
 Удалите все заказы со статусом 'Delivered' из таблицы OrderStatus,
которую создавали на семинаре
Напишите запрос, который удалит нужные строки в таблице.
 */

-- Для начала нужно создать таблицу
CREATE TABLE OrderStatus (
OrderStatusID INT PRIMARY KEY AUTO_INCREMENT,
OrderID INT,
Status VARCHAR(50)
);
-- Затем заполним ее данными
INSERT INTO OrderStatus (OrderID, Status)
VALUES
(101, 'Shipped');

INSERT INTO OrderStatus (OrderID, Status)
VALUES
(102, 'Shipped');

INSERT INTO OrderStatus (OrderID, Status)
VALUES
(103, 'Shipped');

INSERT INTO OrderStatus (OrderID, Status)
VALUES
(104, 'Shipped');

INSERT INTO OrderStatus (OrderID, Status)
VALUES
(105, 'Shipped');

SELECT * FROM OrderStatus;
-- 1	101	Shipped
-- 2	102	Shipped
-- 3	102	Shipped
-- 4	103	Shipped
-- 5	104	Shipped
-- 6	105	Shipped
-- 7	105	Shipped
-- 8	105	Shipped

-- изменим данные 
UPDATE OrderStatus SET Status = 'Delivered'
WHERE OrderID > 103 OR OrderID < 102;

SELECT * FROM OrderStatus;
-- 1	101	Delivered
-- 2	102	Shipped
-- 3	102	Shipped
-- 4	103	Shipped
-- 5	104	Delivered
-- 6	105	Delivered
-- 7	105	Delivered
-- 8	105	Delivered

DELETE FROM OrderStatus 
WHERE Status = 'Delivered';

SELECT * FROM OrderStatus;

-- 2	102	Shipped
-- 3	102	Shipped
-- 4	103	Shipped

