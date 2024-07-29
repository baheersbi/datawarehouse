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

SELECT StoreName AS Name, Location AS Position FROM Stores
UNION
SELECT Name, Position FROM Employees;



create view EmployeeStore as
SELECT EmployeeID, SSN, Name, Position, Stores.StoreID, StoreName
FROM Employees
         INNER JOIN Stores
                    ON Employees.AffiliateStore = Stores.StoreID;

SELECT Name, StoreName FROM EmployeeStore;


SELECT Stores.StoreID, Stores.StoreName, Stores.Location, Stores.Contact
FROM Stores
LEFT JOIN Employees ON Stores.StoreID = Employees.AffiliateStore
WHERE Employees.AffiliateStore IS NULL;


SELECT *
FROM Employees
         LEFT JOIN Stores
                    ON Employees.AffiliateStore = Stores.StoreID;

SELECT *
FROM Employees
         RIGHT JOIN Stores
                   ON Employees.AffiliateStore = Stores.StoreID;

# The Cartesian product in SQL is achieved using a CROSS JOIN, 
         # which combines each row from the first table with every row from 
         # the second table. This results in a set that contains all possible combinations of rows from the two tables.


SELECT *
FROM Employees
          CROSS JOIN Stores;

SELECT A.Name AS EmployeeName1, B.Name AS EmployeeName2, A.SupervisorID
FROM Employees A, Employees B
WHERE A.EmployeeID <> B.EmployeeID
  AND A.SupervisorID = B.SupervisorID
ORDER BY A.SupervisorID;



######### More Join Examples ########
#List all stores along with the products they sell:

SELECT 
    Stores.StoreID,
    Stores.StoreName,
    Products.Name AS ProductName,
    Products.Price,
    Products.Quantity
FROM 
    Stores
INNER JOIN 
    StoreProducts ON Stores.StoreID = StoreProducts.StoreID
INNER JOIN 
    Products ON StoreProducts.ProductName = Products.Name;

# Find all employees working at each store (including stores with no employees):
SELECT 
    Stores.StoreID,
    Stores.StoreName,
    Employees.EmployeeID,
    Employees.Name AS EmployeeName,
    Employees.Position,
    Employees.Salary
FROM 
    Stores
LEFT JOIN 
    Employees ON Stores.StoreID = Employees.AffiliateStore;

# List all employees along with their affiliated store (including employees not assigned to any store):

SELECT 
    Employees.EmployeeID,
    Employees.Name AS EmployeeName,
    Stores.StoreID,
    Stores.StoreName
FROM 
    Employees
RIGHT JOIN 
    Stores ON Employees.AffiliateStore = Stores.StoreID;


#  List all possible pairs of stores and products:

SELECT 
    Stores.StoreID,
    Stores.StoreName,
    Products.Name AS ProductName,
    Products.Price
FROM 
    Stores
CROSS JOIN 
    Products;

# List all stores along with their contact details and the number of employees working in each store:

SELECT 
    Stores.StoreID,
    Stores.StoreName,
    Stores.Contact,
    COUNT(Employees.EmployeeID) AS NumberOfEmployees
FROM 
    Stores
LEFT JOIN 
    Employees ON Stores.StoreID = Employees.AffiliateStore
GROUP BY 
    Stores.StoreID, Stores.StoreName, Stores.Contact;


# List all products available in each store along with their vendor details:

SELECT 
    Stores.StoreID,
    Stores.StoreName,
    Products.Name AS ProductName,
    Products.Price,
    Vendors.VendorName,
    Vendors.ContactPerson
FROM 
    Stores
INNER JOIN 
    StoreProducts ON Stores.StoreID = StoreProducts.StoreID
INNER JOIN 
    Products ON StoreProducts.ProductName = Products.Name
INNER JOIN 
    Vendors ON Products.VendorName = Vendors.VendorName;


########Using Case##########



SELECT
    Name,
    Price,
    CASE
        WHEN Price < 10 THEN 'Cheap'
        WHEN Price >= 10 AND Price <= 50 THEN 'Moderate'
        ELSE 'Expensive'
        END AS PriceCategory
FROM
    Products;


SELECT
    Name,
    Quantity,
    CASE
        WHEN Quantity = 0 THEN 'Out of Stock'
        ELSE 'In Stock'
        END AS StockStatus
FROM
    Products;


SELECT
    Name,
    Price,
    VendorName,
    CASE VendorName
        WHEN 'Pet Paradise' THEN Price * 0.9 -- 10% discount for VendorA
        WHEN 'Ready Tools' THEN Price * 0.85 -- 15% discount for VendorB
        ELSE Price
        END AS DiscountedPrice
FROM
    Products;


SELECT
    Name,
    Quantity,
    CASE
        WHEN Quantity = 0 THEN 'Currently unavailable'
        WHEN Quantity <= 5 THEN 'Limited stock available'
        ELSE 'Available in ample quantity'
        END AS StockDescription
FROM
    Products;


SELECT
    Name,
    Price,
    Quantity,
    CASE
        WHEN Quantity = 0 AND Price > 50 THEN 'High priced and out of stock'
        WHEN Quantity > 10 AND Price < 20 THEN 'Affordable and well-stocked'
        ELSE 'Varies'
        END AS ProductStatus
FROM
    Products;

