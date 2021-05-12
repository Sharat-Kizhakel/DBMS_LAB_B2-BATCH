show databases;
create database ORDER_DB;
USE ORDER_DB;
show tables;
/*i) Create the above tables by properly specifying the primary keys and the foreign keys and the foreign
 keys.
ii) Enter at least five tuples for each relation.
*/
CREATE TABLE CUSTOMER(CUST_ID INT PRIMARY KEY,cname VARCHAR(50),city VARCHAR(50));
DESC CUSTOMER;
CREATE TABLE ORDERS(ORDER_ID INT PRIMARY KEY,odate VARCHAR(15),CUST_ID INT,order_amt INT,FOREIGN KEY(CUST_ID) REFERENCES CUSTOMER(CUST_ID));
CREATE TABLE ITEM(ITEM_ID INT PRIMARY KEY,PRICE INT);
CREATE TABLE ORDERS_ITEM(ORDER_ID INT,ITEM_ID INT,QTY INT,FOREIGN KEY(ORDER_ID) REFERENCES ORDERS(ORDER_ID),FOREIGN KEY(ITEM_ID) REFERENCES ITEM(ITEM_ID) ON DELETE SET NULL);
CREATE TABLE WAREHOUSE(warehouse INT PRIMARY KEY,city VARCHAR(50));
CREATE TABLE SHIPMENT(ORDER_ID INT,warehouse INT,ship_date VARCHAR(20),FOREIGN KEY(ORDER_ID) REFERENCES ORDERS(ORDER_ID),FOREIGN KEY(warehouse) REFERENCES WAREHOUSE(warehouse));
INSERT INTO CUSTOMER(CUST_ID,cname,city) VALUES
       (771,'PUSHPA K','BANGALORE'),
       (772,'SUMAN','MUMBAI'),
       (773,'SOURAV','CALICUT'),
       (774,'LAILA','HYDERABAD'),
       (775,'FAIZAL','BANGALORE');
INSERT INTO ORDERS(ORDER_ID,odate,CUST_ID,order_amt) VALUES
       (111,'22-JAN-02',771,18000),
       (112,'30-JUL-02',774,6000),
       (113,'03-APR-03',775,9000),
       (114,'03-NOV-03',775,29000),
       (115,'10-DEC-03',773,29000),
       (116,'19-AUG-04',772, 56000),
       (117,'10-SEP-04',771,20000),
       (118,'20-NOV-04',775,29000),
       (119,'13-FEB-05',774,29000),
       (120,'13-OCT-05',775,29000);

INSERT INTO ITEM(ITEM_ID,PRICE) VALUES
      (5001,503),
      (5002,750),
      (5003,150),
      (5004,600),
      (5005,890);
INSERT INTO ORDERS_ITEM(ORDER_ID,ITEM_ID,QTY) VALUES
       (111,5001,50),
       (112,5003,20),
       (113,5002,50),
       (114,5005,60),
       (115,5004,90),
       (116,5001,10),
       (117,5003,80),
       (118,5005,50),
       (119,5002,10),
       (120,5004,45);
INSERT INTO WAREHOUSE(warehouse,city) VALUES
         (1,'DELHI'),
          (2,'BOMBAY'),
          (3,'CHENNAI'),
          (4,'BANGALORE'),
          (5,'BANGALORE'),
          (6,'DELHI'),
          (7,'BOMBAY'),
          (8,'CHENNAI'),
          (9,'DELHI'),
        (10,'BANGALORE');
        INSERT INTO SHIPMENT(ORDER_ID,warehouse,ship_date) VALUES
        (111,1,'10-FEB-02'),
       (112,5,'10-SEP-02'),
       (113,8,'10-FEB-03'),
       (114,3,'10-DEC-03'),
       (115,9,'19-JAN-04'),
       (116,1,'20-SEP-04'),
       (117,5,'10-SEP-04'),
       (118,7,'30-NOV-04'),
       (119,7,'30-APR-05'),
       (120,6,'21-DEC-05');
       
       SELECT*FROM CUSTOMER;
       SELECT*FROM ORDERS;
       SELECT*FROM ITEM;
       SELECT*FROM orders_item;
       SELECT*FROM shipment;
       SELECT*FROM warehouse;
       
/*iii) Produce a listing: CUSTNAME, #oforders, AVG_ORDER_AMT, where the middle column is the total
numbers of orders by the customer and the last column is the average order amount for that customer.*/
SELECT customer.cname AS CUSTNAME,COUNT(*) AS NO_OF_ORDERS,AVG(order_amt) AS AVG_ORDER_AMT FROM customer,orders WHERE customer.CUST_ID=orders.CUST_ID GROUP BY customer.CUST_ID;
/*iv) List the order# for orders that were shipped from all warehouses that the company has in a specific city.*/
SELECT ORDER_ID,city AS ALL_ORDERS_FROM_A_CITY FROM shipment LEFT JOIN warehouse ON shipment.warehouse=warehouse.warehouse GROUP BY ORDER_ID ORDER BY city;
/* v) Demonstrate how you delete item# 10 from the ITEM table and make that field null in the ORDER_ITEM
table.*/
DELETE FROM ITEM WHERE ITEM_ID=5005;
SELECT*FROM ITEM;
SELECT*FROM orders_item;


       
       
