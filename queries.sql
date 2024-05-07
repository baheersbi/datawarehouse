select Name, Price, Quantity from Products where Price between 15.00 AND 40;

SELECT * FROM Employees where Name like 'J%';

select * from Employees;
SELECT * FROM Employees where SupervisorID is null;

SELECT * FROM Employees where Name like '%e';

SELECT * FROM Employees where Name like '%m%';

SELECT * FROM Employees where Name like '_m%';

SELECT * from Employees where Name REGEXP '^O';
SELECT * from Employees where Name REGEXP 'm$';

SELECT * FROM Employees;

create view EmployeeStore as
SELECT EmployeeID, SSN, Name, Position, Stores.StoreID, StoreName
FROM Employees
         INNER JOIN Stores
                    ON Employees.AffiliateStore = Stores.StoreID;

SELECT Name, StoreName FROM EmployeeStore;


SELECT *
FROM Employees
         LEFT JOIN Stores
                    ON Employees.AffiliateStore = Stores.StoreID;

SELECT *
FROM Employees
         RIGHT JOIN Stores
                   ON Employees.AffiliateStore = Stores.StoreID;

SELECT *
FROM Employees
          CROSS JOIN Stores;

SELECT A.Name AS EmployeeName1, B.Name AS EmployeeName2, A.SupervisorID
FROM Employees A, Employees B
WHERE A.EmployeeID <> B.EmployeeID
  AND A.SupervisorID = B.SupervisorID
ORDER BY A.SupervisorID;
