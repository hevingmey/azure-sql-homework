USE [Akademy]
CREATE DATABASE Akademy
DROP TABLE Groups
CREATE table Groups
(
  id INT PRIMARY KEY IDENTITY(1,1)  NOT NULL,
  name varchar(10) UNIQUE  CHECK (len(name)>0) NOT NULL,
  rating float not null check (rating between 0 and 5),
  year int CHECK (year >= 1 AND year <= 5) DEFAULT(1) NOT NULL
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
    dean NVARCHAR(max) not null CHECK(dean!=''),
    name nvarchar(100) CHECK (len(name)>0) UNIQUE not NULL
)
CREATE table Teachers(
        id INT PRIMARY KEY IDENTITY(1,1)  NOT NULL,
        employmentDate date not null check ([EmploymentDate] >= '1990-01-01'),
        name nvarchar(max) CHECK (len(name)>0) not null,
        IsAssistant bit not null default (0),
        IsProfessor bit not null DEFAULT(0),
        POSITION NVARCHAR(max) not null CHECK(POSITION!=''),
        surname nvarchar(max) not null check (surname <> N''),
        premium money CHECK(premium>=0) DEFAULT(0)not null,
        salary money CHECK(salary>=1) not null       
)
GO

INSERT INTO Faculties (dean, name) VALUES
(N'Dr. Andrew Collins', N'Faculty of Computer Science'),
(N'Dr. Emily Parker',   N'Faculty of Engineering'),
(N'Dr. Michael Harris', N'Faculty of Economics'),
(N'Dr. Sarah Mitchell', N'Faculty of Humanities'),
(N'Dr. David Turner',   N'Faculty of Mathematics');
GO

INSERT INTO Departments (finansing, name) VALUES
(150000, N'Department of Software Engineering'),
(120000, N'Department of Computer Networks'),
(95000,  N'Department of Applied Mathematics'),
(110000, N'Department of Economics and Management'),
(80000,  N'Department of English Studies'),
(70000,  N'Department of History and Culture');
GO

INSERT INTO Groups (name, rating, year) VALUES
('CS-101',   4.5, 1),
('CS-201',   3.8, 2),
('SE-301',   4.9, 3),
('NET-101',  3.2, 1),
('MATH-201', 4.1, 2),
('ECO-101',  2.9, 1),
('HUM-401',  3.5, 4),
('CS-501',   4.7, 5);
GO

INSERT INTO Teachers
(employmentDate, name, IsAssistant, IsProfessor, POSITION, surname, premium, salary)
VALUES
('1998-09-01', N'John',    0, 1, N'Professor',           N'Smith',     800,  3200),
('2005-02-14', N'Emma',    0, 0, N'Senior Lecturer',     N'Johnson',   300,  2400),
('2010-11-20', N'William', 1, 0, N'Assistant Lecturer',  N'Brown',     0,    1900),
('1993-06-10', N'Olivia',  0, 1, N'Professor',           N'Davis',     900,  3500),
('2018-03-05', N'James',   1, 0, N'Teaching Assistant',  N'Miller',    150,  1600),
('2001-12-01', N'Sophia',  0, 0, N'Lecturer',            N'Wilson',    450,  2300),
('1995-04-17', N'Michael', 0, 0, N'Senior Lecturer',     N'Taylor',    200,  2600),
('2020-01-10', N'Chloe',   1, 0, N'Teaching Assistant',  N'Anderson',  0,    1500),
('2008-07-21', N'Daniel',  0, 0, N'Lecturer',            N'Thomas',    250,  2100),
('1999-03-12', N'Grace',   0, 1, N'Professor',           N'Moore',     1000, 3700);
GO

--1
SELECT name,finansing,id FROM Departments
--2
SELECT name as [Groups name],rating as [Groups rating]
FROM Groups
--3
SELECT surname , (premium*100)/salary as procent_st from Teachers 
select surname , (salary *100)/ salary + premium as prosent_sr from Teachers
--4
SELECT 'The dean of faculty '+ name + ' is ' +dean  from  Faculties
--5
SELECT surname FROM Teachers WHERE IsProfessor=1 AND salary >1050
--6
SELECT name FROM Departments where finansing<11000 or finansing>25000
--7
SELECT name FROM Faculties where not name='Faculty of Computer Science'
--8 
SELECT name, surname , [POSITION] FROM Teachers where not IsProfessor=1
--9
select surname , position , salary, premium from Teachers where premium>160 and premium<550
--10
SELECT surname , salary FROM Teachers WHERE IsAssistant=1
--11
SELECT surname , position FROM Teachers where year(employmentDate)<YEAR('01.01.2000')
--12
select name as 'Name of Department' FROM Faculties 
ORDER by name ASC
--13
SELECT surname from Teachers where IsAssistant=1 and salary+premium<=1200
--14
SELECT name FROM Groups where [year]=5 and rating BETWEEN 2 and 4
--15
SELECT surname FROM Teachers where IsAssistant=1 and salary <550 or premium<200
