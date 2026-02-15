USE Akademy
USE master;
GO



CREATE DATABASE Akademy
--  drop
ALTER DATABASE Akademy SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO
DROP DATABASE Akademy;
GO
DROP TABLE Groups
GO
drop TABLE Departments
GO
DROP TABLE Faculties
GO
DROP TABLE Teachers
-- drop
CREATE table Groups
(
  id INT PRIMARY KEY IDENTITY(1,1)  NOT NULL,
  name varchar(10) UNIQUE  CHECK (len(name)>0) NOT NULL,
  rating float not null check (rating between 0 and 5),
  year int CHECK (year >= 1 AND year <= 5) DEFAULT(1) NOT NULL,
  id_departnent int FOREIGN KEY REFERENCES Departments(id)
  on DELETE CASCADE ON UPDATE CASCADE not NULL
);
CREATE TABLE Departments
(
    id INT PRIMARY KEY IDENTITY(1,1)  NOT NULL,
    finansing money CHECK(finansing>=0) DEFAULT(0) not NULL,
    name nvarchar(100) CHECK (len(name)>0) UNIQUE not NULL,
    id_faculties int FOREIGN key REFERENCES Faculties(id) 
    on DELETE cascade on UPDATE cascade not NULL
)
CREATE TABLE Faculties
(
    id INT PRIMARY KEY IDENTITY(1,1)  NOT NULL,
    dean NVARCHAR(max) not null CHECK(dean!=''),
    name nvarchar(100) CHECK (len(name)>0) UNIQUE not NULL,
    financing money not NULL CHECK(financing>=0) default(0)
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
CREATE TABLE Curators (
  id int PRIMARY KEY IDENTITY(1,1) not null ,
  name NVARCHAR(max) not null CHECK (len(name)!=0),
  surname NVARCHAR(max)not null CHECK(len(surname)!=0)
)
GO
CREATE TABLE GropsCurators(
  id int PRIMARY key IDENTITY(1,1)not null,
  id_curator int FOREIGN key REFERENCES Curators(id)
  on DELETE CASCADE on UPDATE CASCADE not null,
  id_group int FOREIGN key REFERENCES Groups(id)
  on DELETE CASCADE on UPDATE CASCADE not null,
)
GO
CREATE TABLE GroupsLectures(
  id int PRIMARY KEY IDENTITY(1,1) not null,
  id_group int FOREIGN key REFERENCES Groups(id)
  on DELETE CASCADE on UPDATE CASCADE not null,
  id_lecture int FOREIGN key REFERENCES Lectures(id)
  on DELETE CASCADE on UPDATE CASCADE not null,
)
GO
CREATE TABLE Lectures(
  id int PRIMARY KEY IDENTITY(1,1) not null ,
  dayOfWeek int not null CHECK (dayOfWeek>=1 and dayOfWeek<=7),
  lectureRoom NVARCHAR(max) not null CHECK(len(lectureRoom)!=0),
  id_subject int FOREIGN key REFERENCES Subjects(id)
  on DELETE CASCADE on UPDATE CASCADE not null,
  id_teacher int FOREIGN key REFERENCES Teachers(id)
  on DELETE CASCADE on UPDATE CASCADE not null,
)
GO
CREATE TABLE Subjects (
  id int PRIMARY KEY IDENTITY(1,1) not null ,
  name nvarchar(100) not NULL CHECK (len(name)!=0) UNIQUE,
)


/* 1) Faculties */
INSERT INTO Faculties (dean, name, financing)
VALUES
(N'John McArthur', N'Faculty of Computer Science', 250000),
(N'Anna Kowalska', N'Faculty of Engineering', 180000),
(N'Robert Smith',  N'Faculty of Business', 120000);
GO

/* 2) Departments (id_faculties -> Faculties.id) */
INSERT INTO Departments (finansing, name, id_faculties)
VALUES
(60000,  N'Software Development', 1),
(45000,  N'Cybersecurity',        1),
(50000,  N'Computer Networks',    1),
(70000,  N'Mechanical Eng.',      2),
(40000,  N'Finance & Accounting', 3);
GO

/* 3) Groups (id_departnent -> Departments.id) */
INSERT INTO Groups (name, rating, year, id_departnent)
VALUES
('SD-101', 4.6, 1, 1),
('SD-201', 4.2, 2, 1),
('CS-101', 4.4, 1, 2),
('NET-101', 4.1, 1, 3),
('ME-201', 3.8, 2, 4),
('FA-301', 4.0, 3, 5);
GO

/* 4) Teachers */
INSERT INTO Teachers (employmentDate, name, IsAssistant, IsProfessor, POSITION, surname, premium, salary)
VALUES
('2012-09-01', N'Andrew', 0, 1, N'Professor',        N'Brown',   1500, 6500),
('2018-02-10', N'Olivia', 1, 0, N'Assistant',        N'Wilson',   500, 3200),
('2016-11-25', N'Mateusz',0, 0, N'Lecturer',         N'Nowak',    800, 4200),
('2010-05-12', N'Sophia', 0, 1, N'Head of кафедра',  N'Johnson', 2000, 7000),
('2020-03-01', N'Yaroslav',1, 0, N'Assistant',       N'Shevchenko',400, 3000),
('2014-07-19', N'Emma',   0, 0, N'Lecturer',         N'Taylor',   900, 4500),
('2019-01-15', N'James',  0, 0, N'Lecturer',         N'Clark',    700, 4100),
('2005-10-03', N'Natalia',0, 1, N'Professor',        N'Ivanko',  2500, 7800);
GO

/* 5) Subjects */
INSERT INTO Subjects (name)
VALUES
(N'C# Basics'),
(N'Databases (SQL)'),
(N'Computer Networks'),
(N'Algorithms'),
(N'OOP'),
(N'Web Development'),
(N'Operating Systems'),
(N'Cybersecurity Fundamentals'),
(N'Linear Algebra'),
(N'Accounting');
GO

/* 6) Lectures (id_subject -> Subjects.id, id_teacher -> Teachers.id) */
INSERT INTO Lectures (lectureRoom, id_subject, id_teacher)
VALUES
(N'A-101',  1, 3),  -- C# Basics / Mateusz Nowak
(N'A-102',  2, 6),  -- SQL / Emma Taylor
(N'B-201',  3, 7),  -- Networks / James Clark
(N'A-103',  4, 1),  -- Algorithms / Prof Brown
(N'A-104',  5, 3),  -- OOP / Mateusz
(N'C-301',  8, 8),  -- Cybersecurity / Prof Ivanko
(N'B-202',  7, 1),  -- OS / Prof Brown
(N'D-110',  6, 6),  -- Web / Emma
(N'E-210',  9, 4),  -- Linear Algebra / Prof Johnson
(N'F-105', 10, 8);  -- Accounting / Prof Ivanko
GO

/* 7) Curators */
INSERT INTO Curators (name, surname)
VALUES
(N'Maria',  N'Anderson'),
(N'Igor',   N'Petrenko'),
(N'Kate',   N'Miller'),
(N'Bohdan', N'Koval'),
(N'Lisa',   N'Scott'),
(N'Roman',  N'Kharchenko');
GO

/* 8) GropsCurators (зв’язок куратор ↔ група) */
INSERT INTO GropsCurators (id_curator, id_group)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6);
GO

/* 9) GroupsLectures (зв’язок група ↔ лекція) */
INSERT INTO GroupsLectures (id_group, id_lecture)
VALUES
-- SD-101
(1, 1), (1, 2), (1, 5), (1, 4),
-- SD-201
(2, 5), (2, 2), (2, 4), (2, 7), (2, 8),
-- CS-101
(3, 6), (3, 2), (3, 8), (3, 7),
-- NET-101
(4, 3), (4, 2), (4, 7),
-- ME-201
(5, 9), (5, 7),
-- FA-301
(6,10), (6, 2);
                    --#1
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

--2--Групірування даних, зв'язок many to many, аномалії

--1
SELECT t.name,t.surname, g.name as NameGroups
FROM Teachers t 
INNER JOIN Lectures l on l.id_teacher =t.id
INNER JOIN GroupsLectures gl on gl.id_lecture=l.id
INNER JOIN Groups g on g.id=gl.id_group   
--2
SELECT f.name ,f.financing as finansingFaculties , SUM(d.finansing) as DepFinans
from Faculties f 
INNER join Departments d on d.id_faculties=f.id
GROUP by f.id, f.name,f.financing
HAVING SUM(d.finansing)>f.financing
--3
SELECT c.name as curator , g.name as GROUPS
from Curators c 
INNER JOIN Groups g on g.id=c.id
--4
SELECT t.surname as teacher 
FROM Teachers t 
INNER JOIN Lectures l on l.id_teacher=t.id
INNER JOIN GroupsLectures gl on gl.id_lecture=l.id
INNER join Groups g on g.id=gl.id_group
where g.name='SD-101'
--5
SELECT t.surname as teacher , f.name as faculties 
from Teachers t 
INNER join Lectures l on l.id_teacher=t.id
INNER join GroupsLectures gl on gl.id_lecture=l.id
INNER JOIN Groups g on g.id=gl.id_group
inner JOIN Departments d on d.id=g.id_departnent
inner join Faculties f on f.id=d.id_faculties
--6
SELECT d.name as depart , g.name as groups
FROM Departments d
inner JOIN Groups g on g.id_departnent=d.id
--7
SELECT s.name as sabj
from Subjects s 
inner join Lectures l on l.id_subject=s.id
INNER join Teachers t on t.id=l.id_teacher
where t.name='Sophia'
--8
SELECT distinct d.name 
FROM Departments d 
INNER join Groups g on g.id_departnent=d.id
INNER JOIN GroupsLectures gl on gl.id_group=g.id
inner join Lectures l on l.id=gl.id_lecture
INNER JOIN Subjects s on s.id=l.id_subject
where s.name='Databases (SQL)'
--9
SELECT g.name 
FROM Groups g 
INNER JOIN Departments d on d.id=g.id_departnent
INNER join Faculties f on f .id=d.id_faculties
where f.name='Faculty of Computer Science'
--10
SELECT g.name , f.name 
FROM Groups g 
INNER JOIN Departments d on d.id=g.id_departnent
INNER join Faculties f on f .id=d.id_faculties
where g.[year]=5
--11 
SELECT t.surname , s.name, g.name
from Teachers t 
INNER JOIN Lectures l on l.id_teacher=t.id
Inner JOIN Subjects s on s.id=l.id_subject
INNER join GroupsLectures gl on gl.id_lecture=l.id
inner join Groups g on g.id=gl.id_group
where lectureRoom='A-103'

--3--Функції агрегування

--1
select Count(t.id) as CounterTeacher
FROM Teachers t 
INNER JOIN Lectures l on l.id_teacher=t.id
INNER JOIN GroupsLectures gl on gl.id_lecture=l.id
INNER JOIN Groups g on g.id=gl.id_group
INNER JOIN Departments d on d.id=g.id_departnent
WHERE d.name='Software Development'
--2
SELECT COUNT(l.id) as counterLecture
FROM Lectures l 
INNER JOIN Teachers t on t.id=l.id_teacher
where t.name='Andrew'
--3
select COUNT(l.id) as counterI
FROM Lectures l 
INNER JOIN GroupsLectures gl on gl.id_lecture=l.id
inner join Groups g on g.id=gl.id_group
WHERE l.lectureRoom ='B-202'
--4 
SELECT lectureRoom,COUNT(*) as lecture_count
FROM Lectures
GROUP by lectureRoom
--5 



--6 
SELECT AVG(x.salary) AS AvgSalary
FROM (
    SELECT DISTINCT t.id, t.salary
    FROM Teachers t
    INNER JOIN Lectures l        ON l.id_teacher = t.id
    INNER JOIN GroupsLectures gl ON gl.id_lecture = l.id
    INNER JOIN Groups g          ON g.id = gl.id_group
    INNER JOIN Departments d     ON d.id = g.id_departnent
    INNER JOIN Faculties f       ON f.id = d.id_faculties
    WHERE f.name = 'Faculty of Computer Science'
) x;
--7
SELECT AVG(finansing) as finDep
FROM Departments
--8



--Підзапити



