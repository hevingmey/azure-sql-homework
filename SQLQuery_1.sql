
create DATABASE book_store 
GO
use book_store
drop DATABASE book_store

CREATE TABLE authors(
	id INT PRIMARY KEY IDENTITY(1,1),
	name nvarchar(60) NOT NULL,
	surname nvarchar(30) NOT NULL
)
GO

CREATE TABLE jenre(
  id INT PRIMARY KEY IDENTITY(1,1),
genre NVARCHAR(50) not null)



GO
DROP TABLE books 
DROP TABLE authors
DROP TABLE jenre
DROP TABLE bookToGenres
CREATE TABLE books(
  id INT PRIMARY KEY IDENTITY(1,1),
  title nvarchar(70) NOT NULL,
  price DECIMAL (10,2) not null CHECK (price>0),
  [year] int NOT NULL CHECK ([year]>=1800 AND [year]<=YEAR(GETDATE())),
  author_id int FOREIGN KEY REFERENCES authors(id)
	ON DELETE CASCADE ON UPDATE CASCADE,
  jenry_id  int FOREIGN KEY REFERENCES jenre(id)
	ON DELETE CASCADE ON UPDATE CASCADE
);
GO
 CREATE TABLE bookToGenres(
    id INT PRIMARY KEY IDENTITY(1,1),
  id_book int FOREIGN KEY REFERENCES books(id)
	ON DELETE CASCADE ON UPDATE CASCADE,
  jenry_id  int FOREIGN KEY REFERENCES jenre(id)
 )
GO
INSERT INTO authors (name, surname) VALUES
('Stephen', 'King'),
('Agatha', 'Christie'),
('J.K.', 'Rowling'),
('George', 'Orwell'),
('Jane', 'Austen'),
('Ernest', 'Hemingway'),
('Mark', 'Twain'),
('Arthur', 'Doyle');
GO
INSERT INTO books (title, [year], price, author_id) VALUES
('The Shining', 1977, 15.99, 1),
('Murder on the Orient Express', 1934, 12.50, 2),
('Harry Potter and the Philosopher''s Stone', 1997, 20.00, 3),
('1984', 1949, 14.30, 4),
('Pride and Prejudice', 1813, 10.99, 5),
('The Old Man and the Sea', 1952, 13.45, 6),
('Adventures of Huckleberry Finn', 1884, 11.25, 7),
('Sherlock Holmes: A Study in Scarlet', 1887, 16.75, 8),
('Animal Farm', 1945, 9.99, 4),
('It', 1986, 18.60, 1);

INSERT INTO jenre (genre) VALUES 
('Fantasy'),
('Science Fiction'),
('Detective'),
('Romance'),
('Horror'),
('Historical'),
('Adventure'),
('Drama');

GO

INSERT INTO bookToGenres (id_book,jenry_id) VALUES
(1, 5),  -- The Shining -> Horror
(2, 3),  -- Murder on the Orient Express -> Detective
(3, 1),  -- Harry Potter -> Fantasy
(3, 7),  -- Harry Potter -> Adventure
(4, 2),  -- 1984 -> Science Fiction
(4, 8),  -- 1984 -> Drama
(5, 4),  -- Pride and Prejudice -> Romance
(6, 8),  -- The Old Man and the Sea -> Drama
(7, 7),  -- Huckleberry Finn -> Adventure
(8, 3),  -- Sherlock Holmes -> Detective
(9, 2),  -- Animal Farm -> Science Fiction
(10, 5); -- It -> Horror

SELECT * FROM books

SELECT   a.name ,COUNT( j.id)  FROM books b 
INNER join authors a on a.id=b.author_id
INNER JOIN bookToGenres bg on b.id=bg.id_book
INNER JOIN jenre j
On bg.jenry_id=j.id
GROUP by b.title ,b.id


SELECT
    a.name,a.surname,COUNT( j.id) AS genre_count FROM authors a
INNER JOIN books b ON b.author_id = a.id
INNER JOIN bookToGenres bg ON bg.id_book = b.id
INNER JOIN jenre j ON j.id = bg.jenry_id
GROUP BY a.name, a.surname


SELECT  FROM bookToGenres  where id =(
  select  top 1 id FROM books ORDER by price DESC
)





















insert into jenre( genre)
VALUES('Drama'), ('Roman')

SELECT *from authors
SELECT books.title,j.genre, authors.name, authors.surname FROM books
Inner JOIN jenre as j
 on books.jenre_id=j.id

SELECT sum(b.price), a.name ,a.surname, b.author_id  FROM books as b 
INNER JOIN authors as a 
on a.id=b.author_id
GROUP by a.name ,a.surname, b.author_id 

SELECT  a.name, a.surname, COUNT(author_id) AS count_books FROM books AS b
INNER JOIN authors AS a
ON a.id = b.author_id
GROUP BY author_id, a.name, a.surname
HAVING a.name LIKE N'Taras' OR a.name LIKE N'l'; 

SELECT year, COUNT(year) FROM books
GROUP BY year;


SELECT year, COUNT(year) FROM books
GROUP BY year;




 SELECT distinct title from books
 SELECT top 5 * from books ORDER by id DESC
 SELECT MAX(price) FROM books
 SELECT avg (price) from books where year >1830
 SELECT * FROM authors
 SELECT * from books
