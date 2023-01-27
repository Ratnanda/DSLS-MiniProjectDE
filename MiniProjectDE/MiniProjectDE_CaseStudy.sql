
SELECT ord.OrderID, pro.ProductID, pro.ProductName, cat.CategoryName, pro.CategoryID, det.Quantity As Qty, MONTH(ord.OrderDate) AS Month
FROM [Order Details] AS det 
INNER JOIN Orders AS ord ON  det.OrderID = ord.OrderID
INNER JOIN Products As pro ON det.ProductID = pro.ProductID
INNER JOIN Categories AS cat ON pro.CategoryID = cat.CategoryID
WHERE OrderDate > '1997-12-31' AND
      OrderDate < '1998-04-01';

SELECT ord.OrderID, ord.EmployeeID, emp.Title
FROM Orders as ord
INNER JOIN Employees as emp on ord.EmployeeID = emp.EmployeeID
WHERE OrderDate > '1997-12-31' AND
      OrderDate < '1998-04-01' 

SELECT det.OrderID, ord.ShipVia, ord.ShipCity, ord.ShipCountry,
	SUM(UnitPrice*Quantity) AS Order_Value,
	CASE 
		WHEN SUM(UnitPrice*Quantity) <= 100
			THEN 'Low (Pembelian x<=100)'
		WHEN SUM(UnitPrice*Quantity) > 100 AND
			SUM(UnitPrice*Quantity) <= 250
			THEN 'Medium (Pembelian 100<x<=250)'
		WHEN SUM(UnitPrice*Quantity) > 250 AND
			SUM(UnitPrice*Quantity) <= 500
			THEN 'High (Pembelian 250<x<=500)' 
		WHEN SUM(UnitPrice*Quantity) > 500
			THEN 'Very High (Pembelian x>500)'
	END AS Order_Category
FROM [Order Details] as det
JOIN Orders AS ord ON  det.OrderID = ord.OrderID
WHERE OrderDate > '1997-12-31' AND
      OrderDate < '1998-04-01'
GROUP BY det.OrderID, ord.ShipVia, ord.ShipCity, ord.ShipCountry;

