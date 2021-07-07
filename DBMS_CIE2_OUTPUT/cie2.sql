DROP DATABASE CIE2;
CREATE database cie2;
USE cie2;
show tables;
/*i)Create the above tables by properly specifying the primary keys and the foreign keys.
  ii) Enter at least five tuples for each relation.
*/
CREATE TABLE AUTHOR(
author_id INT PRIMARY KEY,
a_name VARCHAR(20),
city VARCHAR(20),
country VARCHAR(20)
);
CREATE TABLE publisher(
publisher_id INT PRIMARY KEY,
p_name VARCHAR(20),
city VARCHAR(20),
country VARCHAR(20) 
);
CREATE TABLE Catalog(
book_id INT PRIMARY KEY,
title varchar(30),
author_id INT,
publisher_id INT,
category_id INT,
p_year INT,
PRICE INT,
FOREIGN KEY(publisher_id) REFERENCES publisher(publisher_id),
FOREIGN KEY(author_id) REFERENCES author(author_id)  
);
CREATE TABLE category(
category_id INT PRIMARY KEY,
Description VARCHAR(100)
);
CREATE TABLE orders(
order_no INT PRIMARY KEY,
book_id INT,
qty INT,
FOREIGN KEY(book_id) REFERENCES catalog(book_id)
);
INSERT INTO AUTHOR(author_id,a_name,city,country) VALUES(1001,'TERAS CHAN','CA','USA'),
(1002,'STEVENS','ZOMBI','UGANDA'),
(1003,'M MANO','CAIR','CANADA'),
(1004,'KARTHIK B.P.','NEW YORK','USA'),
(1005,'WILLIAM STALLINGS','LAS VEGAS','USA');
INSERT INTO publisher(publisher_id,p_name,city,country) VALUES (1,'PEARSON','NEW YORK','USA'),
(2,'EEE','NEW SOUTH WALES','USA'),
(3,'PHI','DELHI','INDIA'),
(4,'WILLEY','BERLIN','GERMANY'),
(5,'MGH','NEW YORK','USA');
INSERT INTO category(category_id,Description) VALUES (1001,'COMPUTER SCIENCE'),
(1002,'ALGORITHM DESIGN'),
(1003,'ELECTRONICS'),
(1004,'PROGRAMMING'),
(1005,'OPERATING SYSTEMS');/*william stallings*/
INSERT INTO Catalog(book_id,title,author_id,publisher_id,category_id,p_year,PRICE) VALUES(11,'Unix System Prg',1001,1,1001,2000,251),
(12,'Digital Signals',1002,2,1003,2001,425),
(13,'Logic Design',1003,3,1002,1999,225),
(14,'Server Prg',1004,4,1004 ,2001,333),
(15,'Linux OS',1005,5,1005,2003,326),/*>2000*/
(16,'C++ Bible',1005,5,1001,2000,526),
(17,'COBOL Handbook',1005,4,1001,2000,658);
INSERT INTO orders(order_no,book_id,qty) VALUES(1,11,5),
(2,12,8),
(3,13,15),
(4,14,22),
(5,15,3),/*ordered one*/
(6,17,10);
SELECT*FROM AUTHOR;
SELECT*FROM category;
SELECT*FROM Catalog;
SELECT*FROM orders;
SELECT*FROM publisher;

/*
iii) Give the details of the authors who have 2 or more books in the catalog and the price of the books in the
	catalog and the year of publication is after 2000.
*/
SELECT AUTHOR.author_id,a_name,city,country,price FROM AUTHOR,Catalog WHERE AUTHOR.author_id=Catalog.author_id AND Catalog.p_year>=2000 GROUP BY Catalog.author_id HAVING COUNT(Catalog.author_id)>=2;
/*
iv) Find the author of the book which has maximum sales.
*/
SELECT AUTHOR.a_name FROM AUTHOR,Catalog,orders WHERE AUTHOR.author_id=Catalog.author_id AND Catalog.book_id=orders.book_id ORDER BY orders.qty DESC LIMIT 1;
-- or
SELECT AUTHOR.a_name FROM AUTHOR,Catalog,orders WHERE AUTHOR.author_id=Catalog.author_id AND Catalog.book_id=orders.book_id AND orders.qty=(SELECT MAX(qty) FROM orders);
/*
v) Demonstrate how you increase the price of books published by a specific publisher by 10%.
*/
UPDATE CATALOG SET PRICE=1.10*PRICE WHERE publisher_id=2;
SELECT*FROM CATALOG;
/*vi)Get the Order Details of the Books published by a specific publisher(Eg Elsevier)*/
SELECT  orders.order_no,orders.book_id,orders.qty from orders,catalog,publisher WHERE orders.book_id=catalog.book_id AND Catalog.publisher_id=publisher.publisher_id  AND publisher.p_name='MGH';