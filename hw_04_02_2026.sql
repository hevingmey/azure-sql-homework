CREATE DATABASE Akademy
CREATE table Groups
(
  id INT PRIMARY KEY IDENTITY(1,1)  NOT NULL,
  name varchar(10) UNIQUE  CHECK (len(name)>0) NOT NULL,
  rating int CHECK(rating<=5) NOT NULL,
  year int CHECK( year>=1 and year<=5) DEFAULT(2020) not NULL
  
);
CREATE TABLE Departments
(
    id INT PRIMARY KEY IDENTITY(1,1)  NOT NULL,
    finansing money CHECK(finansing!=0) DEFAULT(0) not NULL,
    name nvarchar(100) CHECK (len(name)>0) UNIQUE not NULL
)
CREATE TABLE Faculties
(
    id INT PRIMARY KEY IDENTITY(1,1)  NOT NULL,
    
    name nvarchar(100) CHECK (len(name)>0) UNIQUE not NULL
)
CREATE table Teachers(
        id INT PRIMARY KEY IDENTITY(1,1)  NOT NULL,
        employmentDate date CHECK (employmentDate!<'1990-01-01') not null ,
        name nvarchar(max) CHECK (len(name)>0) not null,
        surname NVARCHAR(max)CHECK (len(name)>0) not null,
        premium money CHECK(premium>=0) DEFAULT(0)not null,
        salary money CHECK(salary>=1) not null

       
)