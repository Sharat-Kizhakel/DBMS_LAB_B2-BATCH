DROP DATABASE airline_db;
CREATE DATABASE airline_db;
USE airline_db;
SET FOREIGN_KEY_CHECKS=0;
CREATE TABLE FLIGHTS(flno INT PRIMARY KEY,ffrom VARCHAR(40),fto VARCHAR(40),distance INT,departs TIME,arrives TIME,price INT);
CREATE TABLE AIRCRAFT(aid INT PRIMARY KEY,aname VARCHAR(40),cruisingrange INT);
CREATE TABLE CERTIFIED(eid INT,aid INT,PRIMARY KEY(eid,aid),foreign key(aid) REFERENCES AIRCRAFT(aid) ON DELETE CASCADE);
CREATE TABLE EMPLOYEES(eid INT,ename VARCHAR(40),salary INT,foreign key(eid) REFERENCES CERTIFIED(eid));
INSERT INTO FLIGHTS VALUES(101,'pune','mumbai',300,'17:00:00','18:00:00',2500),
(102,'bangalore','pune',800,'15:10:00','16:20:00',6000),
(103,'bangalore','frankfurt',7000,'11:00:00','13:00:00',50000),
(104,'bangalore','delhi',950,'16:00:00','17:30:00',8500),
(105,'surat','mumbai',270,'10:00:00','11:00:00',3000),
(106,'pune','mumbai',300,'14:00:00','15:00:00',3300),
(107,'bangalore','mumbai',340,'17:00:00','17:45:00',7000);
INSERT INTO AIRCRAFT VALUES(1,'SUKHOI-30',2000),
(2,'MIRAGE 2000',3300),
(3,'BOEING-747',9000),
(4,'HAL TEJAS',900),
(5,'BOEING-404',5000);

INSERT INTO CERTIFIED VALUES
(12,3),
(13,5),
(14,2),
(15,1),
(14,1),
(14,3),
(14,5);
INSERT INTO EMPLOYEES VALUES(11,'RAMESH',70000),
(12,'RAVI',25000),
(15,'BOB',45000),
(13,'NEIL',90000),
(14,'NIKHIL',10000);

/*i. Find the names of aircraft such that all pilots certified to operate them have salaries more than
Rs.80,000.*/
SELECT aname FROM AIRCRAFT,CERTIFIED,EMPLOYEES WHERE AIRCRAFT.aid=CERTIFIED.aid and CERTIFIED.eid=EMPLOYEES.eid and salary>80000;
/*ii. For each pilot who is certified for more than three aircrafts, find the eid and the maximum cruising
range of the aircraft for which she or he is certified.*/
SELECT CERTIFIED.eid,AIRCRAFT.cruisingrange FROM AIRCRAFT,CERTIFIED,EMPLOYEES WHERE AIRCRAFT.aid=CERTIFIED.aid and CERTIFIED.eid=EMPLOYEES.eid GROUP BY CERTIFIED.eid HAVING COUNT(CERTIFIED.aid)>3;

/*iii. Find the names of pilots whose salary is less than the price of the cheapest route from Bengaluru to
Frankfurt.*/
SELECT DISTINCT(ename) FROM EMPLOYEES,CERTIFIED WHERE EMPLOYEES.eid=CERTIFIED.eid and EMPLOYEES.salary<(SELECT MIN(price) FROM FLIGHTS WHERE flights.ffrom='bangalore' AND flights.fto='frankfurt');
/*iv. For all aircraft with cruising range over 1000 Kms, find the name of the aircraft and the average
salary of all pilots certified for this aircraft.*/
SELECT aname,AVG(salary) FROM AIRCRAFT,EMPLOYEES,CERTIFIED WHERE AIRCRAFT.aid=CERTIFIED.aid and CERTIFIED.eid=EMPLOYEES.eid AND AIRCRAFT.cruisingrange>1000 GROUP BY aname;
/*v. Find the names of pilots certified for some Boeing aircraft.*/
SELECT DISTINCT(ename) FROM EMPLOYEES,CERTIFIED,AIRCRAFT WHERE AIRCRAFT.aid=CERTIFIED.aid and CERTIFIED.eid=EMPLOYEES.eid AND aname LIKE '%BOEING%';
/*vi. Find the aids of all aircraft that can be used on routes from Bengaluru to New Delhi.*/
SELECT DISTINCT(aid) FROM AIRCRAFT,FLIGHTS WHERE AIRCRAFT.cruisingrange>=(SELECT FLIGHTS.distance FROM FLIGHTS WHERE flights.ffrom='bangalore' AND flights.fto='delhi');
/*vii. A customer wants to travel from bangalore to mumbai with no more than two changes of flight. List
the choice of departure times from bangalore if the customer wants to arrive in mumbai by 6 p.m.*/
 SELECT F.departs FROM FLIGHTS F WHERE F.flno IN((SELECT F0.flno FROM FLIGHTS F0 WHERE F0.ffrom='bangalore' AND F0.fto='mumbai' AND EXTRACT(hour FROM F0.arrives)<18)
 UNION (SELECT F0.flno FROM FLIGHTS F0,FLIGHTS F1 WHERE F0.ffrom='bangalore' AND F1.ffrom=F0.fto AND F1.fto='mumbai' AND F1.departs>F0.arrives AND EXTRACT(hour FROM F1.arrives)<18) 
 UNION (SELECT F0.flno FROM FLIGHTS F0,FLIGHTS F1,FLIGHTS F2 WHERE F0.ffrom='bangalore' AND F1.ffrom=F0.fto AND F2.ffrom=F1.fto AND F2.fto='mumbai' AND F1.departs>F0.arrives AND F2.departs>F1.arrives AND EXTRACT(hour FROM F2.arrives)<18)); 
/*viii. Print the name and salary of every non-pilot whose salary is more than the average salary for pilots.*/
SELECT DISTINCT(ename),salary FROM EMPLOYEES WHERE EMPLOYEES.eid NOT IN(SELECT DISTINCT(CERTIFIED.eid) FROM CERTIFIED) AND EMPLOYEES.salary>(SELECT AVG(salary) FROM EMPLOYEES WHERE EMPLOYEES.eid IN(SELECT distinct(CERTIFIED.eid) FROM CERTIFIED));

SELECT*FROM flights;
