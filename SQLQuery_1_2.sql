CREATE DATABASE Shop
--

--
go 

CREATE TABLE Products
(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    ProductName NVARCHAR(30) NOT NULL,
    Manufacturer NVARCHAR(20) NOT NULL,
    ProductCount INT DEFAULT 0,
    Price DECIMAL(10, 2) NOT NULL

);

CREATE TABLE Customers

(

    Id INT IDENTITY(1,1) PRIMARY KEY,

    FirstName VARCHAR(30) NOT NULL

);

CREATE TABLE Orders

(

    Id INT IDENTITY(1,1) PRIMARY KEY,

    ProductId INT NOT NULL,

    CustomerId INT NOT NULL,

    CreatedAt DATE NOT NULL,

    ProductCount INT DEFAULT 1,

    Price DECIMAL(10, 2) NOT NULL,

    FOREIGN KEY (ProductId) REFERENCES Products(Id) ON DELETE CASCADE,

    FOREIGN KEY (CustomerId) REFERENCES Customers(Id) ON DELETE CASCADE

);

INSERT INTO Products (ProductName, Manufacturer, ProductCount, Price) VALUES

('iPhone 12', 'Apple', 10, 999.99),

('Galaxy S21', 'Samsung', 8, 899.99),

('P40 Pro', 'Huawei', 5, 799.99),

('Mi 11', 'Xiaomi', 12, 699.99),

('Pixel 5', 'Google', 6, 699.99),

('OnePlus 9', 'OnePlus', 7, 799.99),

('Xperia 1 III', 'Sony', 4, 1099.99),

('Mate 40 Pro', 'Huawei', 3, 899.99),

('Galaxy Note 20 Ultra', 'Samsung', 9, 1199.99),

('iPhone SE', 'Apple', 15, 399.99);


CREATE TABLE smartphones (
  id INT PRIMARY KEY IDENTITY(1,1),
  ProductName VARCHAR(100),
  ProductModel VARCHAR(100),
  Manufacture VARCHAR(100),
  ProductCount INT,
  Price DECIMAL(10, 2),
  Storage VARCHAR(100)
);

insert into smartphones (ProductName, ProductModel, Manufacture, ProductCount, Price, Storage) values
    ('Galaxy', 'M32', 'Samsung', 5, 8555, '128GB'),
    ('Galaxy', 'A73', 'Samsung', 10, 20699, '128GB'),
    ('Galaxy', 'M32', 'Samsung', 15, 23499, '128GB'),
    ('Galaxy', 'M32', 'Samsung', 7, 6749, '64GB'),
    ('Galaxy', 'M32', 'Samsung', 52, 51099, '512GB'),
    ('Galaxy', 'M32', 'Samsung', 13, 25499, '256GB'),
    ('Apple Iphone', '13', 'Apple', 20, 35999, '128GB'),
    ('Apple Iphone', '11', 'Apple', 25, 25499, '128GB'),
    ('Apple Iphone', '14', 'Apple', 100, 41499, '128GB'),
    ('Apple Iphone', '10', 'Apple', 3, 12599, '128GB'),
    ('Xiaomi Redmi', '9A', 'Xiaomi', 23, 4199, '64GB'),
    ('Xiaomi Redmi', '9C', 'Xiaomi', 31, 4799, '32GB'),
    ('Xiaomi Redmi', 'Note 11', 'Xiaomi', 70, 7199, '128GB'),
    ('Xiaomi Redmi', 'Note 9', 'Xiaomi', 4, 8199, '128GB'),
    ('Huawei', 'P30', 'Huawei', 25, 18458, '128GB'),
    ('Huawei', 'Nova 9', 'Huawei', 30, 17033, '256GB'),
    ('Huawei', 'Nova 9 SE', 'Huawei', 40, 13999, '128GB'),
    ('Honor', '20 Pro', 'Honor', 21, 14569, '128GB'),
    ('Honor', '50 Lite', 'Honor', 38, 13744, '128GB'),
    ('Honor', '8X', 'Honor', 19, 13228, '128GB');



INSERT INTO Customers (FirstName) VALUES
('Alexander'),
('Ivan'),
('Maria'),
('Olena'),
('Andrii'),
('Sofia'),
('Mykhailo'),
('Anastasia'),
('Victoria'),
('Artem');




INSERT INTO Orders (ProductId, CustomerId, CreatedAt, ProductCount, Price) VALUES

(1, 1, '2022-01-01', 2, 1999.98),

(2, 2, '2022-01-02', 1, 899.99),

(3, 3, '2022-01-03', 1, 799.99),

(4, 4, '2022-01-04', 3, 2099.97),

(5, 5, '2022-01-05', 1, 699.99),

(6, 6, '2022-01-06', 2, 1599.98),

(7, 7, '2022-01-07', 1, 1099.99),

(9, 9, '2022-01-09', 2, 2399.98),

(10, 10, '2022-01-10', 1, 399.99),

(1, 2, '2022-01-11', 1, 999.99),

(2, 3, '2022-01-12', 1, 899.99),

(3, 4, '2022-01-13', 1, 799.99),

(4, 5, '2022-01-14', 1, 699.99),

(5, 6, '2022-01-15', 1, 699.99),

(6, 7, '2022-01-16', 1, 799.99),

(8, 9, '2022-01-18', 1, 899.99),

(9, 10, '2022-01-19', 1, 799.99),

(10, 1, '2022-01-20', 1, 399.99);

--1
SELECT o.* FROM Orders o 
INNER join Products p on p.Id=o.ProductId
where p.Manufacturer='Google'
--2
SELECT c.FirstName 
FROM Customers c 
left  join Orders o on o.CustomerId=c.Id
where o.Id is null
--3
SELECT c.FirstName, Count(o.id)
from Customers c 
LEFT join Orders o on c.Id=o.CustomerId
GROUP by c.id , c.FirstName

--4
SELECT ProductName, Manufacture, ProductCount, Price  FROM smartphones
UNION
SELECT ProductName,Manufacturer, ProductCount, Price from Products

-- cтворення змінних 
DECLARE @age int 
set @age=22
SELECT @age as age 
--
select Id,ProductName,Price,
CASE 
WHEN Price>800 THEN 'expensive'
ELSE 'normal'
END -- закриває when 
as order_type
from Products
 DECLARE @n int=10
 if @n>0
    PRINT ('+')
    ELSE 
        print('-')
