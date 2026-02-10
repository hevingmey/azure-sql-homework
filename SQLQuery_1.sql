
create DATABASE book_store 
GO
use book_store
drop DATABASE book_store
CREATE TABLE authors(
  id INT PRIMARY KEY IDENTITY(1,1),
  name nvarchar(30) NOT NULL,
  surname nvarchar(30) NOT NULL
)

GO
DROP TABLE books 

CREATE TABLE books(
  id INT PRIMARY KEY IDENTITY(1,1),
  title nvarchar(30) NOT NULL,
  [year] int NOT NULL CHECK ([year]>=1800 AND [year]<=YEAR(GETDATE())),
  author_id int FOREIGN KEY REFERENCES authors(id),
  jenre_id int FOREIGN KEY REFERENCES jenre(id)
);

GO

INSERT INTO authors (name, surname)
VALUES 
('Taras', 'Shevchenko'),
('Ivan', 'Franko'),
('Lesya', 'Ukrainka'),
('Mykhailo', 'Kotsiubynskyi');

GO

INSERT INTO books (title, [year], author_id, jenre_id)
VALUES
('Kobzar', 1840, 1,2),
('The Haidamaks', 1841, 1,2),
('Zahar Berkut', 1883, 2,1),
('Moses', 1905, 2,1),
('The Forest Song', 1911, 3,2),
('Intermezzo', 1908, 4,1);

CREATE TABLE jenre(
  id INT PRIMARY KEY IDENTITY(1,1),
genre NVARCHAR(10) not null

)
insert into jenre( genre)
VALUES('Drama'), ('Roman')

SELECT *from authors
SELECT books.title,j.genre, authors.name, authors.surname FROM books
Inner JOIN jenre as j
 on books.jenre_id=j.id
 INNER JOIN authors on books.author_id=authors.id
 

