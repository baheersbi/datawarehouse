CREATE TABLE Employees (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
    SSN CHAR(11) NOT NULL UNIQUE,
    Name VARCHAR(255) NOT NULL,
    Gender ENUM('M', 'F', 'O') NOT NULL,
    DoB DATE NOT NULL,
    Position VARCHAR(255),
    Salary DECIMAL(10, 2),
    AffiliateStore INT,
    SupervisorID INT,
    FOREIGN KEY (AffiliateStore) REFERENCES Stores(StoreID),
    FOREIGN KEY (SupervisorID) REFERENCES Employees(EmployeeID)
) ENGINE=INNODB

# In this example, employees born before 1970 will be in partition p1, between 1970 and 1980 in p2, and so on. This allows MySQL to quickly scan partitions based on date ranges when querying by birthdate.

PARTITION BY RANGE (YEAR(DoB)) (
    PARTITION p1 VALUES LESS THAN (1970),
    PARTITION p2 VALUES LESS THAN (1980),
    PARTITION p3 VALUES LESS THAN (1990),
    PARTITION p4 VALUES LESS THAN (2000),
    PARTITION p5 VALUES LESS THAN (2010),
    PARTITION p6 VALUES LESS THAN MAXVALUE
);
# This example splits employees into different partitions based on their gender: males ('M') go into p0, females ('F') into p1, and others ('O') into p2. This might be helpful when querying data segmented by gender.

PARTITION BY LIST (Gender) (
    PARTITION p0 VALUES IN ('M'),
    PARTITION p1 VALUES IN ('F'),
    PARTITION p2 VALUES IN ('O')
);

# In cases where the partitioning key doesn’t follow a specific logical grouping, you can use hash partitioning to evenly distribute data based on the EmployeeID:

PARTITION BY HASH(EmployeeID) 
PARTITIONS 4;

#In this case, the data is split into 4 partitions by hashing the EmployeeID. This ensures an even distribution across partitions, which can be beneficial for large datasets with frequent EmployeeID lookups.

# General Querying a Partitioned Table

SELECT * FROM Employees WHERE DoB >= '1990-01-01' AND DoB < '2000-01-01';

# Checking Partition Pruning

EXPLAIN SELECT * FROM Employees WHERE DoB >= '1990-01-01' AND DoB < '2000-01-01';

# Directly Reading Data from a Specific Partition
SELECT * FROM Employees WHERE Gender = 'M';