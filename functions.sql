CREATE FUNCTION CalculateTotalPrice(p_Price DECIMAL(10, 2), p_Quantity INT)
    RETURNS DECIMAL(10, 2)
    DETERMINISTIC
BEGIN
    RETURN p_Price * p_Quantity;
END;


CREATE FUNCTION CheckStock(p_ProductName VARCHAR(255), p_RequestedQty INT)
    RETURNS BOOLEAN
    DETERMINISTIC
BEGIN
    DECLARE v_AvailableQty INT;
    SELECT Quantity INTO v_AvailableQty FROM Products WHERE Name = p_ProductName;
    RETURN v_AvailableQty >= p_RequestedQty;
END;


-- Example usage in a query:
SELECT Name, CalculateTotalPrice(Price, Quantity) AS TotalPrice
FROM Products;

-- Example usage in a stored procedure or with a variable:
SET @price := 20.99;
SET @quantity := 5;
SET @total := CalculateTotalPrice(@price, @quantity);
SELECT @total AS TotalPrice;



-- Example usage in a query:
SELECT Name, CheckStock(Name, 10) AS IsInStock
FROM Products;

-- Example usage with a variable:
SET @productName := 'Laptop';
SET @requestedQty := 5;
SET @inStock := CheckStock(@productName, @requestedQty);
SELECT @inStock AS IsInStock;
