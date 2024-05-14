CREATE TRIGGER BeforeInsert_Products
    BEFORE INSERT ON Products
    FOR EACH ROW
BEGIN
    IF NEW.Price < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Price cannot be negative.';
    END IF;

    IF NEW.Quantity < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Quantity cannot be negative.';
    END IF;
END;


CREATE TRIGGER BeforeUpdate_Products
    BEFORE UPDATE ON Products
    FOR EACH ROW
BEGIN
    IF NEW.Price < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Price cannot be negative.';
    END IF;

    IF NEW.Quantity < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Quantity cannot be negative.';
    END IF;
END;


CREATE TRIGGER AfterInsert_Products
    AFTER INSERT ON Products
    FOR EACH ROW
BEGIN
    INSERT INTO ProductAudit (Action, ProductName, Timestamp)
    VALUES ('Insert', NEW.Name, NOW());
END;


CREATE TRIGGER AfterUpdate_Products
    AFTER UPDATE ON Products
    FOR EACH ROW
BEGIN
    INSERT INTO ProductAudit (Action, ProductName, Timestamp)
    VALUES ('Update', NEW.Name, NOW());
END;


CREATE TRIGGER AfterDelete_Products
    AFTER DELETE ON Products
    FOR EACH ROW
BEGIN
    INSERT INTO ProductAudit (Action, ProductName, Timestamp)
    VALUES ('Delete', OLD.Name, NOW());
END;


CREATE TABLE ProductAudit
(
    AuditID int AUTO_INCREMENT PRIMARY KEY,
    Action varchar(50),
    ProductName varchar(255),
    Timestamp datetime
);

