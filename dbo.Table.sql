CREATE TABLE CartOrders (
    Id INT PRIMARY KEY IDENTITY(1,1),
    ProductId INT NOT NULL,
    ProductName NVARCHAR(100) NOT NULL,
    UnitPrice DECIMAL(18,2) NOT NULL,
    Quantity INT NOT NULL,
    ImageUrl NVARCHAR(255),
    DistributorName NVARCHAR(100),
    EstimatedDeliveryDays INT NOT NULL, 
    [OrderDate] DATETIME NULL

);
