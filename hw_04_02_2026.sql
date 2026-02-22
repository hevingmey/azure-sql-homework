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
GO
DROP TABLE Lectures
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
go 
create table [Students]
(
	[Id] int not null identity(1, 1) primary key,
	[Name] nvarchar(max) not null check ([Name] <> N''),
	[Rating] int not null check ([Rating] between 0 and 5),
	[Surname] nvarchar(max) not null check ([Surname] <> N'')
);

CREATE TABLE GropsStudents
(
  id int PRIMARY KEY IDENTITY(1,1) not null ,
  id_student int FOREIGN key REFERENCES Students(id)
  on DELETE CASCADE on UPDATE CASCADE not null,
    id_group int FOREIGN key REFERENCES Groups(id)
  on DELETE CASCADE on UPDATE CASCADE not null,
)
/* 1) Faculties */
INSERT INTO Faculties (dean, name, financing) VALUES
(N'John Smith', N'IT корпус', 250000),
(N'Emma Brown', N'Business корпус', 180000),
(N'Oliver Wilson', N'Engineering корпус', 220000);
GO

/* 2) Departments */
INSERT INTO Departments (finansing, name, id_faculties) VALUES
(120000, N'Software Development', 1),
( 90000, N'Cyber Security', 1),
( 70000, N'QA & Testing', 1),
(110000, N'Accounting', 2),
( 60000, N'Marketing', 2),
(130000, N'Electrical Engineering', 3);
GO

/* 3) Groups */
INSERT INTO Groups (name, rating, year, id_departnent) VALUES
('SD-501', 4.6, 5, 1),   -- Software Development (5 курс)
('SD-502', 4.2, 5, 1),   -- Software Development (5 курс)
('CS-301', 3.9, 3, 2),   -- Cyber Security
('QA-201', 4.1, 2, 3),   -- QA & Testing
('AC-401', 3.7, 4, 4);   -- Accounting
GO

/* 4) Teachers */
INSERT INTO Teachers (employmentDate, name, IsAssistant, IsProfessor, [POSITION], surname, premium, salary) VALUES
('2012-09-01', N'Michael', 0, 1, N'Professor', N'Johnson', 2000, 8000),
('2018-02-15', N'Sarah',   1, 0, N'Assistant', N'Davis',   800,  4200),
('2015-11-20', N'Daniel',  0, 0, N'Lecturer',  N'Miller',  900,  5000),
('2020-01-10', N'Laura',   1, 0, N'Assistant', N'Anderson',700,  3900);
GO

/* 5) Subjects */
INSERT INTO Subjects (name) VALUES
(N'Databases'),
(N'Algorithms'),
(N'Backend Development'),
(N'Software Architecture'),
(N'Testing Fundamentals');
GO

/* 6) Lectures
   (створимо 12 пар у межах 1-го тижня (дні 1..7) для групи SD-501) */
INSERT INTO Lectures (dayOfWeek, lectureRoom, id_subject, id_teacher) VALUES
(1, N'A-101', 1, 1),
(1, N'A-101', 2, 1),
(2, N'A-102', 3, 3),
(2, N'A-102', 4, 1),
(3, N'A-201', 1, 3),
(3, N'A-201', 2, 3),
(4, N'A-202', 3, 1),
(4, N'A-202', 4, 1),
(5, N'A-301', 1, 2),
(5, N'A-301', 5, 2),
(6, N'A-401', 4, 1),
(7, N'A-402', 3, 3);
GO

/* 7) GroupsLectures
   Прив’яжемо всі 12 лекцій до групи SD-501 (це Group.Id = 1 у нашій вставці) */
INSERT INTO GroupsLectures (id_group, id_lecture) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(1, 8),
(1, 9),
(1,10),
(1,11),
(1,12);
GO

/* Додатково: кілька лекцій для SD-502 (Group.Id = 2) */
INSERT INTO GroupsLectures (id_group, id_lecture) VALUES
(2, 1),
(2, 3),
(2, 5),
(2, 7),
(2, 9);
GO

/* 8) Curators */
INSERT INTO Curators (name, surname) VALUES
(N'Kevin', N'Thomas'),
(N'Emily', N'Moore'),
(N'Ryan',  N'Taylor');
GO

/* 9) GropsCurators (зв’язок куратор-група) */
INSERT INTO GropsCurators (id_curator, id_group) VALUES
(1, 1),  -- Kevin -> SD-501
(2, 2),  -- Emily -> SD-502
(3, 3);  -- Ryan  -> CS-301
GO

/* 10) Students */
INSERT INTO Students ([Name], [Rating], [Surname]) VALUES
(N'John',   5, N'Smith'),
(N'Emily',  4, N'Johnson'),
(N'Daniel', 3, N'Brown'),
(N'Sarah',  4, N'Wilson'),
(N'Michael',2, N'Davis'),
(N'Laura',  5, N'Miller'),
(N'Emma',   4, N'Anderson'),
(N'Oliver', 3, N'Thomas'),
(N'Ryan',   1, N'Moore'),
(N'Kevin',  4, N'Taylor'),
(N'Sophia', 5, N'Walker'),
(N'James',  2, N'Hall');
GO

/* 11) GropsStudents (розподіл студентів по групах) */
INSERT INTO GropsStudents (id_student, id_group) VALUES
(1, 1),(2, 1),(3, 1),(4, 1),(5, 1),(6, 1),  -- SD-501
(7, 2),(8, 2),(9, 2),                       -- SD-502
(10,3),(11,3),                              -- CS-301
(12,4);                                     -- QA-201
GO
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
--1
SELECT f.id as facultFinan
from Faculties f 
JOIN Departments d on d.id_faculties=f.id
GROUP by f.id
HAVING SUM(d.finansing)>100000
--2
SELECT g.name
FROM Groups g
JOIN Departments d ON d.id = g.id_departnent
WHERE g.year = 5
  AND d.name =N'Software Development'
  AND g.id IN (
      SELECT gl.id_group
      FROM GroupsLectures gl
      JOIN Lectures l ON l.id = gl.id_lecture
      WHERE l.dayOfWeek BETWEEN 1 AND 7
      GROUP BY gl.id_group
      HAVING COUNT(*) > 10
  );
  --3
select
