create database Insurance;
use Insurance;
CREATE TABLE PERSON(DRIVER_ID VARCHAR(10),NAME VARCHAR(20),ADDRESS VARCHAR(15),PRIMARY KEY(DRIVER_ID));
show tables;
SELECT *FROM PERSON;
create table car(regno varchar(10),Model varchar(20),Year date,Primary key(Regno));
create table Accident(report_no int,ADATE DATE,Location varchar(15),Primary key(report_no));
create table owns(driver_id varchar(10),regno varchar(10),primary key(driver_id,regno),
 foreign key(driver_id) references person(driver_id) on delete cascade, foreign key(regno) references car(regno) on delete cascade);
 CREATE TABLE PARTICIPATED(driver_id varchar(10),regno varchar(10),report_no int, damage_amt float, 
foreign key (driver_id,regno) references OWNS(driver_id,regno) ON DELETE CASCADE, 
foreign key (REPORT_NO) references ACCIDENT(REPORT_NO) ON DELETE CASCADE);
show tables;
insert into PERSON(DRIVER_ID,NAME,ADDRESS)values('1111','RAMU', 'K.S.LAYOUT');
insert into PERSON(DRIVER_ID,NAME,ADDRESS)values('2222','JOHN', 'INDIRANAGAR');
insert into PERSON(DRIVER_ID,NAME,ADDRESS)values('3333','PRIYA','JAYANAGAR');
insert into PERSON(DRIVER_ID,NAME,ADDRESS)values('4444','GOPAL','WHITEFIELD');
insert into PERSON(DRIVER_ID,NAME,ADDRESS)values('5555','LATHA',' VIJAYANAGAR');
COMMIT;
SELECT *FROM PERSON;
insert into car(regno,Model,Year)values('KA04Q2301','MARUTHI-DX', '2000-10-11');
insert into car(regno,Model,Year)values('KA05P1000',' FORDICON','2000-09-08');
insert into car(regno,Model,Year)values('KA03L1234','ZEN-VXI', '1999-07-06');
insert into car(regno,Model,Year)values('KA03L9999',' MARUTH-DX', '2002-06-05');
insert into car(regno,Model,Year)values('KA01P4020',' INDICA-VX', '2002-05-04');
COMMIT;
desc car;
SELECT *FROM car;
insert into Accident(report_no,ADATE,Location)values('12',' 2002-06-02',' M G ROAD');
insert into Accident(report_no,ADATE,Location)values('200',' 2002-12-10',' DOUBLEROAD');
insert into Accident(report_no,ADATE,Location)values('300',' 1999-07-10','M G ROAD');
insert into Accident(report_no,ADATE,Location)values('25000',' 2000-06-11',' RESIDENCY ROAD');
insert into Accident(report_no,ADATE,Location)values('26500',' 2001-08-12',' RICHMOND ROAD');
COMMIT;
desc Accident;
SELECT *FROM Accident;
insert into owns(driver_id,regno)values('1111', 'KA04Q2301');
insert into owns(driver_id,regno)values('1111','KA05P1000');
insert into owns(driver_id,regno)values('2222','KA03L1234');
insert into owns(driver_id,regno)values('3333','KA03L9999');
insert into owns(driver_id,regno)values('4444','KA01P4020');
COMMIT;
SELECT *FROM owns;
insert into PARTICIPATED(driver_id,regno,report_no,damage_amt)values('1111', 'KA04Q2301',' 12',' 20000');
insert into PARTICIPATED(driver_id,regno,report_no,damage_amt)values('2222','KA03L1234','200',' 500');
insert into PARTICIPATED(driver_id,regno,report_no,damage_amt)values('3333','KA03L9999','300',' 10000');
insert into PARTICIPATED(driver_id,regno,report_no,damage_amt)values('4444','KA01P4020','25000 ','2375');
insert into PARTICIPATED(driver_id,regno,report_no,damage_amt)values('1111','KA05P1000','26500','70000');
COMMIT;
desc PARTICIPATED ;
SELECT *FROM PARTICIPATED;
/*
a. Update the damage amount for the car with a specific Regno in the accident with report number 12 to
25000.
*/
UPDATE PARTICIPATED SET DAMAGE_AMT=25000 WHERE REPORT_NO =12 AND REGNO='KA04Q2301';
COMMIT;
desc PARTICIPATED ;
SELECT *FROM PARTICIPATED;
/*
b. Add a new accident to the database
*/
insert into Accident(report_no,ADATE,Location)values('500',' 2005-06-02','Mysore Road');
desc Accident;
SELECT *FROM Accident;

/*
iv. Find the total number of people who owned cars that involved in accidents in 2008
*/
select count(*) from Accident where year(ADATE)=2008;

/*
V. Find the number of accidents in which cars belonging to a specific model were involved
*/
SELECT COUNT(A.REPORT_NO) FROM ACCIDENT A, PARTICIPATED P, CAR C
 WHERE A.REPORT_NO=P.REPORT_NO AND
 P.REGNO=C.REGNO AND C.MODEL='MARUTHI-DX';