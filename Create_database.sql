
-- mysqlds2_create_db.sql: DVD Store Database Version 2.1 Build Script - MySQL version
-- Copyright (C) 2005 Dell, Inc. <dave_jaffe@dell.com> and <tmuirhead@vmware.com>
-- Last updated 5/13/05


-- Database

DROP DATABASE IF EXISTS DS2;
CREATE DATABASE DS2;
USE DS2;


-- Tables

CREATE TABLE CUSTOMERS
  (
  CUSTOMERID INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  FIRSTNAME VARCHAR(50) NOT NULL, 
  LASTNAME VARCHAR(50) NOT NULL, 
  ADDRESS1 VARCHAR(50) NOT NULL, 
  ADDRESS2 VARCHAR(50), 
  CITY VARCHAR(50) NOT NULL, 
  STATE VARCHAR(50), 
  ZIP INT, 
  COUNTRY VARCHAR(50) NOT NULL, 
  REGION TINYINT NOT NULL,
  EMAIL VARCHAR(50),
  PHONE VARCHAR(50),
  CREDITCARDTYPE INT NOT NULL,
  CREDITCARD VARCHAR(50) NOT NULL, 
  CREDITCARDEXPIRATION VARCHAR(50) NOT NULL, 
  USERNAME VARCHAR(50) NOT NULL, 
  PASSWORD VARCHAR(50) NOT NULL, 
  AGE TINYINT, 
  INCOME INT,
  GENDER VARCHAR(1) 
  )
  ENGINE=InnoDB; 
  
CREATE TABLE CUST_HIST
  (
  CUSTOMERID INT NOT NULL,
  FOREIGN KEY (CUSTOMERID) REFERENCES CUSTOMERS(CUSTOMERID), #EDITED
  ORDERID INT NOT NULL, 
  PROD_ID INT NOT NULL 
  )
  ENGINE=InnoDB; #EDITED
  
CREATE TABLE ORDERS
  (
  ORDERID INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  ORDERDATE DATE NOT NULL, 
  CUSTOMERID INT, 
  FOREIGN KEY (CUSTOMERID) REFERENCES CUSTOMERS(CUSTOMERID), #EDITED
  NETAMOUNT NUMERIC(12,2) NOT NULL, 
  TAX NUMERIC(12,2) NOT NULL, 
  TOTALAMOUNT NUMERIC(12,2) NOT NULL
  )
  ENGINE=InnoDB; 
  

   

CREATE TABLE CATEGORIES
  (
  CATEGORY TINYINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  CATEGORYNAME VARCHAR(50) NOT NULL  
  )
  ENGINE=InnoDB;
   
  
  INSERT INTO CATEGORIES (CATEGORY, CATEGORYNAME) VALUES (1,'Action');
  INSERT INTO CATEGORIES (CATEGORY, CATEGORYNAME) VALUES (2,'Animation');
  INSERT INTO CATEGORIES (CATEGORY, CATEGORYNAME) VALUES (3,'Children');
  INSERT INTO CATEGORIES (CATEGORY, CATEGORYNAME) VALUES (4,'Classics');
  INSERT INTO CATEGORIES (CATEGORY, CATEGORYNAME) VALUES (5,'Comedy');
  INSERT INTO CATEGORIES (CATEGORY, CATEGORYNAME) VALUES (6,'Documentary');
  INSERT INTO CATEGORIES (CATEGORY, CATEGORYNAME) VALUES (7,'Drama');
  INSERT INTO CATEGORIES (CATEGORY, CATEGORYNAME) VALUES (8,'Family');
  INSERT INTO CATEGORIES (CATEGORY, CATEGORYNAME) VALUES (9,'Foreign');
  INSERT INTO CATEGORIES (CATEGORY, CATEGORYNAME) VALUES (10,'Games');
  INSERT INTO CATEGORIES (CATEGORY, CATEGORYNAME) VALUES (11,'Horror');
  INSERT INTO CATEGORIES (CATEGORY, CATEGORYNAME) VALUES (12,'Music');
  INSERT INTO CATEGORIES (CATEGORY, CATEGORYNAME) VALUES (13,'New');
  INSERT INTO CATEGORIES (CATEGORY, CATEGORYNAME) VALUES (14,'Sci-Fi');
  INSERT INTO CATEGORIES (CATEGORY, CATEGORYNAME) VALUES (15,'Sports');
  INSERT INTO CATEGORIES (CATEGORY, CATEGORYNAME) VALUES (16,'Travel');
  
  
CREATE TABLE PRODUCTS
  (
  PROD_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  CATEGORY TINYINT NOT NULL, 
  FOREIGN KEY (CATEGORY) REFERENCES CATEGORIES(CATEGORY), #EDITED
  TITLE VARCHAR(50) NOT NULL, 
  ACTOR VARCHAR(50) NOT NULL, 
  PRICE NUMERIC(12,2) NOT NULL, 
  SPECIAL TINYINT,
  COMMON_PROD_ID INT NOT NULL 
  )
  ENGINE=InnoDB;
  
CREATE TABLE ORDERLINES
  (
  ORDERLINEID SMALLINT NOT NULL, 
  ORDERID INT NOT NULL, 
  FOREIGN KEY (ORDERID) REFERENCES ORDERS(ORDERID), #EDITED
  PROD_ID INT NOT NULL, 
  FOREIGN KEY (PROD_ID) REFERENCES PRODUCTS(PROD_ID), #EDITED
  QUANTITY SMALLINT NOT NULL, 
  ORDERDATE DATE NOT NULL
  )
  ENGINE=InnoDB; 

CREATE TABLE INVENTORY
  (
  PROD_ID INT NOT NULL PRIMARY KEY,
  QUAN_IN_STOCK INT NOT NULL,
  SALES INT NOT NULL
  )
  ENGINE=InnoDB;

CREATE TABLE REORDER
  (
  PROD_ID INT NOT NULL,
  FOREIGN KEY (PROD_ID) REFERENCES PRODUCTS(PROD_ID), #EDITED
  DATE_LOW DATE NOT NULL,
  QUAN_LOW INT NOT NULL,
  DATE_REORDERED DATE,
  QUAN_REORDERED INT,
  DATE_EXPECTED DATE
  )
  ENGINE=InnoDB;
  
  
#----------load data------------
set global local_infile = 1;
#SET @@GLOBAL.local_infile=1;


use DS2;
SET UNIQUE_CHECKS=0;
SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE CUSTOMERS DISABLE KEYS;
LOAD DATA LOCAL INFILE "C:/Users/Anthony/Desktop/CreditNinja/ds2/data_files/cust/us_cust.csv" INTO TABLE CUSTOMERS FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';
LOAD DATA LOCAL INFILE "C:/Users/Anthony/Desktop/CreditNinja/ds2/data_files/cust/row_cust.csv" INTO TABLE CUSTOMERS FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';
ALTER TABLE CUSTOMERS ENABLE KEYS;
SET UNIQUE_CHECKS=1;
SET FOREIGN_KEY_CHECKS=1;


SET UNIQUE_CHECKS=0;
SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE CUSTOMERS DISABLE KEYS;
LOAD DATA LOCAL INFILE "C:/Users/Anthony/Desktop/CreditNinja/ds2/data_files/cust/us_cust.csv" INTO TABLE CUSTOMERS FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';
LOAD DATA LOCAL INFILE "C:/Users/Anthony/Desktop/CreditNinja/ds2/data_files/cust/row_cust.csv" INTO TABLE CUSTOMERS FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';
ALTER TABLE CUSTOMERS ENABLE KEYS;
SET UNIQUE_CHECKS=1;
SET FOREIGN_KEY_CHECKS=1;


SET UNIQUE_CHECKS=0;
SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE CUST_HIST DISABLE KEYS;
LOAD DATA LOCAL INFILE "C:/Users/Anthony/Desktop/CreditNinja/ds2/data_files/orders/jan_cust_hist.csv" INTO TABLE CUST_HIST FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';
LOAD DATA LOCAL INFILE "C:/Users/Anthony/Desktop/CreditNinja/ds2/data_files/orders/feb_cust_hist.csv" INTO TABLE CUST_HIST FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';
LOAD DATA LOCAL INFILE "C:/Users/Anthony/Desktop/CreditNinja/ds2/data_files/orders/mar_cust_hist.csv" INTO TABLE CUST_HIST FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';
LOAD DATA LOCAL INFILE "C:/Users/Anthony/Desktop/CreditNinja/ds2/data_files/orders/apr_cust_hist.csv" INTO TABLE CUST_HIST FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';
LOAD DATA LOCAL INFILE "C:/Users/Anthony/Desktop/CreditNinja/ds2/data_files/orders/may_cust_hist.csv" INTO TABLE CUST_HIST FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';
LOAD DATA LOCAL INFILE "C:/Users/Anthony/Desktop/CreditNinja/ds2/data_files/orders/jun_cust_hist.csv" INTO TABLE CUST_HIST FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';
LOAD DATA LOCAL INFILE "C:/Users/Anthony/Desktop/CreditNinja/ds2/data_files/orders/jul_cust_hist.csv" INTO TABLE CUST_HIST FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';
LOAD DATA LOCAL INFILE "C:/Users/Anthony/Desktop/CreditNinja/ds2/data_files/orders/aug_cust_hist.csv" INTO TABLE CUST_HIST FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';
LOAD DATA LOCAL INFILE "C:/Users/Anthony/Desktop/CreditNinja/ds2/data_files/orders/sep_cust_hist.csv" INTO TABLE CUST_HIST FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';
LOAD DATA LOCAL INFILE "C:/Users/Anthony/Desktop/CreditNinja/ds2/data_files/orders/oct_cust_hist.csv" INTO TABLE CUST_HIST FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';
LOAD DATA LOCAL INFILE "C:/Users/Anthony/Desktop/CreditNinja/ds2/data_files/orders/nov_cust_hist.csv" INTO TABLE CUST_HIST FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';
LOAD DATA LOCAL INFILE "C:/Users/Anthony/Desktop/CreditNinja/ds2/data_files/orders/dec_cust_hist.csv" INTO TABLE CUST_HIST FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';
ALTER TABLE CUST_HIST ENABLE KEYS;
SET UNIQUE_CHECKS=1;
SET FOREIGN_KEY_CHECKS=1;


SET UNIQUE_CHECKS=0;
SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE ORDERLINES DISABLE KEYS;
LOAD DATA LOCAL  INFILE "C:/Users/Anthony/Desktop/CreditNinja/ds2/data_files/orders/jan_orderlines.csv" INTO TABLE ORDERLINES FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';
LOAD DATA LOCAL  INFILE "C:/Users/Anthony/Desktop/CreditNinja/ds2/data_files/orders/feb_orderlines.csv" INTO TABLE ORDERLINES FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';
LOAD DATA LOCAL  INFILE "C:/Users/Anthony/Desktop/CreditNinja/ds2/data_files/orders/mar_orderlines.csv" INTO TABLE ORDERLINES FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';
LOAD DATA LOCAL  INFILE "C:/Users/Anthony/Desktop/CreditNinja/ds2/data_files/orders/apr_orderlines.csv" INTO TABLE ORDERLINES FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';
LOAD DATA LOCAL  INFILE "C:/Users/Anthony/Desktop/CreditNinja/ds2/data_files/orders/may_orderlines.csv" INTO TABLE ORDERLINES FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';
LOAD DATA LOCAL  INFILE "C:/Users/Anthony/Desktop/CreditNinja/ds2/data_files/orders/jun_orderlines.csv" INTO TABLE ORDERLINES FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';
LOAD DATA LOCAL  INFILE "C:/Users/Anthony/Desktop/CreditNinja/ds2/data_files/orders/jul_orderlines.csv" INTO TABLE ORDERLINES FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';
LOAD DATA LOCAL  INFILE "C:/Users/Anthony/Desktop/CreditNinja/ds2/data_files/orders/aug_orderlines.csv" INTO TABLE ORDERLINES FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';
LOAD DATA LOCAL  INFILE "C:/Users/Anthony/Desktop/CreditNinja/ds2/data_files/orders/sep_orderlines.csv" INTO TABLE ORDERLINES FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';
LOAD DATA LOCAL  INFILE "C:/Users/Anthony/Desktop/CreditNinja/ds2/data_files/orders/oct_orderlines.csv" INTO TABLE ORDERLINES FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';
LOAD DATA LOCAL  INFILE "C:/Users/Anthony/Desktop/CreditNinja/ds2/data_files/orders/nov_orderlines.csv" INTO TABLE ORDERLINES FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';
LOAD DATA LOCAL  INFILE "C:/Users/Anthony/Desktop/CreditNinja/ds2/data_files/orders/dec_orderlines.csv" INTO TABLE ORDERLINES FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';
ALTER TABLE ORDERLINES ENABLE KEYS;
SET UNIQUE_CHECKS=1;
SET FOREIGN_KEY_CHECKS=1;


SET UNIQUE_CHECKS=0;
SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE ORDERS DISABLE KEYS;
LOAD DATA LOCAL  INFILE "C:/Users/Anthony/Desktop/CreditNinja/ds2/data_files/orders/jan_orders.csv" INTO TABLE ORDERS FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';
LOAD DATA LOCAL  INFILE "C:/Users/Anthony/Desktop/CreditNinja/ds2/data_files/orders/feb_orders.csv" INTO TABLE ORDERS FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';
LOAD DATA LOCAL  INFILE "C:/Users/Anthony/Desktop/CreditNinja/ds2/data_files/orders/mar_orders.csv" INTO TABLE ORDERS FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';
LOAD DATA LOCAL  INFILE "C:/Users/Anthony/Desktop/CreditNinja/ds2/data_files/orders/apr_orders.csv" INTO TABLE ORDERS FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';
LOAD DATA LOCAL  INFILE "C:/Users/Anthony/Desktop/CreditNinja/ds2/data_files/orders/may_orders.csv" INTO TABLE ORDERS FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';
LOAD DATA LOCAL  INFILE "C:/Users/Anthony/Desktop/CreditNinja/ds2/data_files/orders/jun_orders.csv" INTO TABLE ORDERS FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';
LOAD DATA LOCAL  INFILE "C:/Users/Anthony/Desktop/CreditNinja/ds2/data_files/orders/jul_orders.csv" INTO TABLE ORDERS FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';
LOAD DATA LOCAL  INFILE "C:/Users/Anthony/Desktop/CreditNinja/ds2/data_files/orders/aug_orders.csv" INTO TABLE ORDERS FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';
LOAD DATA LOCAL  INFILE "C:/Users/Anthony/Desktop/CreditNinja/ds2/data_files/orders/sep_orders.csv" INTO TABLE ORDERS FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';
LOAD DATA LOCAL  INFILE "C:/Users/Anthony/Desktop/CreditNinja/ds2/data_files/orders/oct_orders.csv" INTO TABLE ORDERS FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';
LOAD DATA LOCAL  INFILE "C:/Users/Anthony/Desktop/CreditNinja/ds2/data_files/orders/nov_orders.csv" INTO TABLE ORDERS FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';
LOAD DATA LOCAL  INFILE "C:/Users/Anthony/Desktop/CreditNinja/ds2/data_files/orders/dec_orders.csv" INTO TABLE ORDERS FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';
ALTER TABLE ORDERS ENABLE KEYS;
SET UNIQUE_CHECKS=1;
SET FOREIGN_KEY_CHECKS=1;


SET UNIQUE_CHECKS=0;
SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE INVENTORY DISABLE KEYS;
LOAD DATA LOCAL  INFILE "C:/Users/Anthony/Desktop/CreditNinja/ds2/data_files/prod/inv.csv" INTO TABLE INVENTORY FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';
ALTER TABLE INVENTORY ENABLE KEYS;
SET UNIQUE_CHECKS=1;
SET FOREIGN_KEY_CHECKS=1;


SET UNIQUE_CHECKS=0;
SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE PRODUCTS DISABLE KEYS;
LOAD DATA LOCAL  INFILE "C:/Users/Anthony/Desktop/CreditNinja/ds2/data_files/prod/prod.csv" INTO TABLE PRODUCTS FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"';
ALTER TABLE PRODUCTS ENABLE KEYS;
SET UNIQUE_CHECKS=1;
SET FOREIGN_KEY_CHECKS=1;












