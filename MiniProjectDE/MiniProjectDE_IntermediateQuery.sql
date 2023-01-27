
SELECT COUNT(OrderID) As Total_Cust FROM Orders
WHERE OrderDate > '1996-12-31 00:00:00.000' AND
      OrderDate < '1998-01-01 00:00:00.000';


SELECT FirstName + ' ' + LastName AS Name FROM Employees
WHERE Title = 'Sales Representative';


SELECT TOP 5 SUM(det.Quantity) As Qty, pro.ProductName
FROM [Order Details] AS det 
INNER JOIN Orders AS ord ON  det.OrderID = ord.OrderID
INNER JOIN Products As pro ON det.ProductID = pro.ProductID
WHERE OrderDate > '1996-12-31' AND
      OrderDate < '1997-02-01'
	GROUP BY ProductName
	ORDER BY Qty DESC;


SELECT s.CompanyName
FROM Suppliers AS s
JOIN Products As pro ON s.SupplierID = pro.SupplierID
JOIN [Order Details] AS det ON  pro.ProductID = det.ProductID
JOIN Orders As ord ON det.OrderID = ord.OrderID
WHERE OrderDate > '1997-05-31' AND
      OrderDate < '1997-07-01' AND ProductName='Chai';

SELECT Order_Category, COUNT(*) AS Jumlah_Order FROM (
SELECT OrderID, 
	SUM(UnitPrice*Quantity) AS order_value,
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
FROM [Order Details]
GROUP BY OrderID) ranks
GROUP BY Order_Category
ORDER BY Jumlah_Order;


SELECT c.CompanyName, SUM(det.UnitPrice*det.Quantity) AS Total_Price
FROM Customers AS c
JOIN Orders As ord ON c.CustomerID = ord.CustomerID
JOIN [Order Details] AS det ON  ord.OrderID = det.OrderID
WHERE OrderDate > '1996-12-31' AND 
      OrderDate < '1998-01-01' 
	  GROUP BY CompanyName 
	  HAVING SUM(UnitPrice*Quantity) > 500
	  ORDER BY Total_Price ASC;




CREATE VIEW FinalView
AS  
SELECT OrderID, ProductID, UnitPrice, Quantity, Discount, 
UnitPrice*Quantity*(1-Discount) as Final_Price
FROM [Order Details]

SELECT * FROM FinalView
