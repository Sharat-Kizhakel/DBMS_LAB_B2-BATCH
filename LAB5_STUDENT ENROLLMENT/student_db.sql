DROP database student_db;
CREATE database student_db;
USE student_db;
CREATE TABLE STUDENT(
regno VARCHAR(30) PRIMARY KEY,
s_name VARCHAR(30),
major VARCHAR(30),
bdate varchar(30)
 );
 CREATE TABLE COURSE(
 course_no INT PRIMARY KEY,
 c_name VARCHAR(30),
 dept VARCHAR(30)
 );
 CREATE TABLE ENROLL(
 regno VARCHAR(30),
 course_no INT,
 sem INT,
 marks INT,
 PRIMARY KEY(regno,course_no),
FOREIGN KEY(regno) REFERENCES STUDENT(regno),
FOREIGN KEY(course_no) REFERENCES COURSE(course_no)
 );
 CREATE TABLE TEXT
 (
 book_isbn INT PRIMARY KEY,
 book_title VARCHAR(40),
 publisher VARCHAR(40),
 author varchar(40)
 );
 CREATE TABLE BOOK_ADOPTION(
 course_no INT,
 sem INT,
 book_isbn INT,
 PRIMARY KEY(course_no,book_isbn)
 );
 INSERT INTO STUDENT VALUES
 ('CS01','RAM','DS','12-MAR-86')
,('IS02','SMITH','USP','23-DEC-87')
,('EC03','AHMED','SNS','17-APR-85')
,('CS03','SNEHA','DBMS','01-JAN-87')
,('TC05','AKHILA','EC','06-OCT-86');

INSERT INTO COURSE VALUES
      (11,'DS','CS'),
      (22,'USP','IS'),
	  (33,'SNS','EC'),
	(44,'DBMS','CS'),
	(55,'EC','TC');

INSERT INTO ENROLL VALUES
('CS01',11,4,85),
('IS02',22,6,80),
('EC03',33,2,80),
('CS03',44,6,75),
('TC05',55,2,8);
INSERT INTO TEXT VALUES
(1,'DS and C','Princeton','Padma Reddy'),
(2,'Fundamentals of DS','Princeton','Godse'),
(3,'Fundamentals of DBMS','TMH','Navathe'),
(4,'SQL','Princeton','Foley'),
(5,'Electronic circuits','TMH','Elmasri'),
(6,'Adv unix prog','TMH','Stevens');
INSERT INTO BOOK_ADOPTION VALUES
        (11,4,1),
        (11,4,2),
        (44,6,3),
        (44,6,4),
        (44,2,5),
        (22,6,6),
        (55,2,7);

/*iii.Demonstrate how you add a new text book to the database and make this book be
adopted by some department.*/

-- INSERT INTO TEXT 

INSERT INTO TEXT VALUES(8,'AUTOMATA THEORY','TMH','Peter Lynch');
INSERT INTO BOOK_ADOPTION VALUES(22,4,8);
SELECT*FROM TEXT;
SELECT*FROM BOOK_ADOPTION;
/*iv.Produce a list of text books (include Course #, Book-ISBN, Book-title) in the alphabetical order for courses offered by the ‘CS’ department that use more than two books.*/

SELECT C.COURSE_NO,BA.BOOK_ISBN, TB.BOOK_TITLE FROM COURSE C, BOOK_ADOPTION BA,TEXT TB
WHERE C.COURSE_NO=BA.COURSE_NO AND BA.BOOK_ISBN=TB.BOOK_ISBN AND C.DEPT="CS"
AND 2<(SELECT COUNT(BOOK_ISBN) FROM BOOK_ADOPTION B 
		WHERE C.COURSE_NO=B.COURSE_NO)
        ORDER BY TB.BOOK_TITLE;
-- SELECT BOOK_ADOPTION.course_no,BOOK_ADOPTION.book_isbn,book_title FROM BOOK_ADOPTION JOIN TEXT ON BOOK_ADOPTION.book_isbn=TEXT.book_isbn JOIN COURSE ON COURSE.course_no= BOOK_ADOPTION.course_no WHERE COURSE.dept="CS" AND 2<(SELECT COUNT(BOOK_ADOPTION.book_isbn) FROM BOOK_ADOPTION JOIN COURSE ON COURSE.COURSE_NO=book_adoption.course_no WHERE COURSE.dept="CS") ORDER BY TEXT.book_title;

/*v.List any department that has all its adopted books published by a specific publisher.*/

SELECT dept FROM COURSE JOIN BOOK_ADOPTION ON COURSE.COURSE_NO=BOOK_ADOPTION.COURSE_NO JOIN TEXT ON TEXT.book_isbn=BOOK_ADOPTION.book_isbn WHERE publisher="Princeton" AND course.dept NOT IN(SELECT course.dept FROM COURSE JOIN BOOK_ADOPTION ON COURSE.COURSE_NO=BOOK_ADOPTION.COURSE_NO JOIN TEXT ON TEXT.book_isbn=BOOK_ADOPTION.book_isbn WHERE text.publisher!="Princeton") LIMIT 1;


       