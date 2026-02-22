CREATE DATABASE SportShop
use SportShop
DROP DATABASE SportShop
DROP TABLE buyer 
drop TABLE SalesHistory
go 

CREATE TABLE goods(
    id int PRIMARY KEY IDENTITY(1,1) not NULL,
    name NVARCHAR(max) CHECK ( len(name)!=0) not null,
    clothes bit not null DEFAULT(0),
    shoes bit not null DEFAULT(0),
    accessory bit not null DEFAULT(0),
    amount int not null DEFAULT(0),
    cost DECIMAL(10,2) not null check(cost>=0) DEFAULT(0),
    produser NVARCHAR(max) CHECK ( len(produser)!=0)not null ,
    price decimal(10,2) DEFAULT(0) check(price>=0) not null
)
GO
CREATE TABLE seller (
    id int PRIMARY KEY IDENTITY(1,1) not NULL,
    name NVARCHAR(30) CHECK ( len(name)>=0) not null,
    surname NVARCHAR(30) CHECK ( len(surname)>=0) not null,
    position NVARCHAR(30) CHECK ( len(position)>=0) not null, 
    date_start date  CHECK(date_start>='2000-01-01')not null,
    gender NVARCHAR(10) CHECK ( len(gender)>=0) not null,
    salary DECIMAL(10,2) CHECK(salary>=0) not null
)
GO
CREATE TABLE buyer (
    id int PRIMARY KEY IDENTITY(1,1) not NULL,
    name NVARCHAR(30) CHECK ( len(name)>=0) not null,
    surname NVARCHAR(30) CHECK ( len(surname)>=0) not null,
    email NVARCHAR(max) check( len(email)>=0) not null,
    number NVARCHAR(15) check( len(number)>=10) not null,
    gender NVARCHAR(10) CHECK ( len(gender)>=0) not null,
    discount int CHECK(discount>=0) not null,
    subscription bit DEFAULT(0) not NULL
)
GO
CREATE TABLE SalesHistory(
     id int PRIMARY KEY IDENTITY(1,1) not NULL,
    price decimal(10,2) DEFAULT(0) check(price>=0) not null,
    amount int not null DEFAULT(1),
    date_s date  CHECK(date_s>='2000-01-01')not null,
    id_goods int FOREIGN key REFERENCES goods(id) 
    on DELETE cascade on UPDATE cascade not NULL,
    id_seler int FOREIGN key REFERENCES seller(id) 
    on DELETE cascade on UPDATE cascade not NULL,
    id_buyer int FOREIGN key REFERENCES buyer(id) 
    on DELETE cascade on UPDATE cascade not NULL
)
go
DROP TABLE archiveSeler
CREATE TABLE archiveSeler(
 id int PRIMARY KEY IDENTITY(1,1) not NULL,
    name NVARCHAR(30) CHECK ( len(name)>=0) not null,
    surname NVARCHAR(30) CHECK ( len(surname)>=0) not null,
    position NVARCHAR(30) CHECK ( len(position)>=0) not null, 
    date_start date  CHECK(date_start>='2000-01-01')not null,
    gender NVARCHAR(10) CHECK ( len(gender)>=0) not null,
    salary DECIMAL(10,2) CHECK(salary>=0) not null,
    reason NVARCHAR(max) CHECK ( len(reason)>=0) 
)
GO
-- GOODS
INSERT INTO goods (name, clothes, shoes, accessory, amount, cost, produser, price)
VALUES
(N'Training T-Shirt', 1, 0, 0, 60, 6.50,  N'Nike', 19.99),
(N'Running Shorts',   1, 0, 0, 40, 8.00,  N'Adidas', 24.99),
(N'Hoodie',           1, 0, 0, 25, 15.00, N'Puma', 49.99),
(N'Running Shoes',    0, 1, 0, 30, 35.00, N'Asics', 89.99),
(N'Football Boots',   0, 1, 0, 20, 40.00, N'Nike', 109.99),
(N'Gym Backpack',     0, 0, 1, 35, 12.00, N'Reebok', 39.99),
(N'Water Bottle',     0, 0, 1, 80, 2.00,  N'Decathlon', 7.99),
(N'Fitness Gloves',   0, 0, 1, 45, 3.50,  N'Under Armour', 14.99),
(N'Sports Socks',     1, 0, 0, 120,1.00,  N'Adidas', 5.99),
(N'Cap',              0, 0, 1, 55, 2.50,  N'Nike', 17.99);
GO

-- SELLER
INSERT INTO seller (name, surname, position, date_start, gender, salary)
VALUES
(N'Olena',  N'Koval',       N'Cashier',  '2021-03-15', N'Female', 1600.00),
(N'Andrii', N'Melnyk',      N'Salesman', '2020-09-01', N'Male',   1750.00),
(N'Iryna',  N'Shevchenko',  N'Manager',  '2019-01-10', N'Female', 2300.00),
(N'Oleh',   N'Bondar',      N'Salesman', '2022-06-20', N'Male',   1700.00),
(N'Marta',  N'Horbenko',    N'Cashier',  '2023-02-05', N'Female', 1550.00);
GO
INSERT INTO buyer (name, surname, email, number, gender, discount, subscription)
VALUES
(N'Vlad',     N'Petrenko',   N'vlad.petrenko@gmail.com',     N'380501234567', N'Male',   5, 1),
(N'Anna',     N'Ivanchuk',   N'anna.ivanchuk@outlook.com',   N'380502345678', N'Female', 10, 0),
(N'Dmytro',   N'Kravets',    N'dmytro.k@icloud.com',         N'380503456789', N'Male',   0,  1),
(N'Sofia',    N'Reva',       N'sofia.reva@yahoo.com',        N'380504567891', N'Female', 15, 1),
(N'Yurii',    N'Zaiets',     N'y.zaiets@mail.com',           N'380505678912', N'Male',   7,  0),
(N'Kateryna', N'Romanenko',  N'kat.romanenko@gmail.com',     N'380506789123', N'Female', 12, 1);
GO
INSERT INTO SalesHistory (price, amount, date_s, id_goods, id_seler, id_buyer)
VALUES
(19.99, 2, '2025-11-05', 1, 1, 1),
(89.99, 1, '2025-11-06', 4, 2, 2),
(39.99, 1, '2025-11-06', 6, 2, 3),
(7.99,  3, '2025-11-07', 7, 1, 4),
(109.99,1, '2025-11-07', 5, 3, 1),
(49.99, 1, '2025-11-08', 3, 4, 5),
(24.99, 2, '2025-11-08', 2, 5, 6),
(14.99, 1, '2025-11-09', 8, 4, 2),
(5.99,  5, '2025-11-10', 9, 1, 3),
(17.99, 1, '2025-11-10', 10,3, 4);

GO

        --тригер на звільнення 
CREATE TRIGGER sellerDeleteTrig
on seller 
after DELETE
AS
BEGIN
 INSERT into archiveSeler (name, surname, position, date_start, gender, salary,reason)
 select name, surname, position, date_start, gender, salary,N'liberated'
 FROM deleted;
 end;

GO
DELETE  FROM seller where id=1
select* FROM archiveSeler