/* Create a table EXISTING_CUSTOMERS with 5 different columns and CUSTOMER_ID as primary key.  */
CREATE TABLE EXISTING_CUSTOMERS (
  CUSTOMER_ID NUMBER(5),
  FIRST_NAME VARCHAR2(100),
  LAST_NAME VARCHAR2(100),
  ADDRESS_STATE VARCHAR2(10),
  EMAIL_ADDRESS VARCHAR2(350),
  CONSTRAINT OLD_PK_CUST PRIMARY KEY (CUSTOMER_ID)
);

/* Use BEGIN and END to insert 10 different entries into the EXISTING_CUSTOMERS table.  */
BEGIN
	INSERT INTO EXISTING_CUSTOMERS (CUSTOMER_ID, FIRST_NAME, LAST_NAME, ADDRESS_STATE, EMAIL_ADDRESS)
	VALUES (1, 'Teresa', 'Hudson', 'NY', 'thudson@abc.com');
	INSERT INTO EXISTING_CUSTOMERS (CUSTOMER_ID, FIRST_NAME, LAST_NAME, ADDRESS_STATE, EMAIL_ADDRESS)
	VALUES (2, 'Fred', 'Montgomery', 'CA', 'fmont@gmail.com');
	INSERT INTO EXISTING_CUSTOMERS (CUSTOMER_ID, FIRST_NAME, LAST_NAME, ADDRESS_STATE, EMAIL_ADDRESS)
	VALUES (3, 'Lois', 'Lawson', 'OR', 'lois_law@outlook.com');
	INSERT INTO EXISTING_CUSTOMERS (CUSTOMER_ID, FIRST_NAME, LAST_NAME, ADDRESS_STATE, EMAIL_ADDRESS)
	VALUES (4, 'Alice', 'Perry', 'SC', 'aliceperry');
	INSERT INTO EXISTING_CUSTOMERS (CUSTOMER_ID, FIRST_NAME, LAST_NAME, ADDRESS_STATE, EMAIL_ADDRESS)
	VALUES (5, 'Ralph', 'Montgomery', 'TX', 'ralph_mont25@gmail.com');
	INSERT INTO EXISTING_CUSTOMERS (CUSTOMER_ID, FIRST_NAME, LAST_NAME, ADDRESS_STATE, EMAIL_ADDRESS)
	VALUES (6, 'Dorothy', 'Armstrong', 'OR', 'abc123@abc.com');
	INSERT INTO EXISTING_CUSTOMERS (CUSTOMER_ID, FIRST_NAME, LAST_NAME, ADDRESS_STATE, EMAIL_ADDRESS)
	VALUES (7, 'Fred', 'Wallace', 'NY', 'wallacef@testwebsite.co.uk');
	INSERT INTO EXISTING_CUSTOMERS (CUSTOMER_ID, FIRST_NAME, LAST_NAME, ADDRESS_STATE, EMAIL_ADDRESS)
	VALUES (8, 'Joseph', 'Bell', 'FL', 'jbell@comm.edu');
	INSERT INTO EXISTING_CUSTOMERS (CUSTOMER_ID, FIRST_NAME, LAST_NAME, ADDRESS_STATE, EMAIL_ADDRESS)
	VALUES (9, 'Lois', 'Martinez', 'CALIF', 'loismar@awe.com');
	INSERT INTO EXISTING_CUSTOMERS (CUSTOMER_ID, FIRST_NAME, LAST_NAME, ADDRESS_STATE, EMAIL_ADDRESS)
	VALUES (10, 'Robert', 'Rice', 'IN', 'robrice123');
END;

/* Display all entries in the EXISTING_CUSTOMERS table.  */
SELECT * FROM EXISTING_CUSTOMERS;

/* Create a table EXISTING_CUSTOMERS with 5 different columns and no primary key.  */
CREATE TABLE  NEW_CUSTOMERS(
  CUSTOMER_ID NUMBER(5),
  FIRST_NAME VARCHAR2(100),
  LAST_NAME VARCHAR2(100),
  ADDRESS_STATE VARCHAR2(10),
  EMAIL_ADDRESS VARCHAR2(350)
);

/* Insert 6 entries into the NEW_CUSTOMERS table, which has the same properties as the EXISTING_CUSTOMERS table.  Notice that some entries in NEW_CUSTOMERS table already exist in EXISTING_CUSTOMERS table.  */
BEGIN
	INSERT INTO NEW_CUSTOMERS (CUSTOMER_ID, FIRST_NAME, LAST_NAME, ADDRESS_STATE, EMAIL_ADDRESS)
	VALUES (15, 'John', 'Stock', 'ND', 'js1980@outlook.com');
	INSERT INTO NEW_CUSTOMERS (CUSTOMER_ID, FIRST_NAME, LAST_NAME, ADDRESS_STATE, EMAIL_ADDRESS)
	VALUES (12, 'Joseph', 'Bell', 'OR', 'thebell@yahoo.com');
	INSERT INTO NEW_CUSTOMERS (CUSTOMER_ID, FIRST_NAME, LAST_NAME, ADDRESS_STATE, EMAIL_ADDRESS)
	VALUES (3, 'Lois', 'Lawson', 'WA', 'lois_law@outlook.com');
	INSERT INTO NEW_CUSTOMERS (CUSTOMER_ID, FIRST_NAME, LAST_NAME, ADDRESS_STATE, EMAIL_ADDRESS)
	VALUES (8, 'Joseph', 'Bell', 'FL', 'jbell@gmail.com');
	INSERT INTO NEW_CUSTOMERS (CUSTOMER_ID, FIRST_NAME, LAST_NAME, ADDRESS_STATE, EMAIL_ADDRESS)
	VALUES (1, 'Teresa', 'Hudson', 'NY', 'thudson@abc.com');
	INSERT INTO NEW_CUSTOMERS (CUSTOMER_ID, FIRST_NAME, LAST_NAME, ADDRESS_STATE, EMAIL_ADDRESS)
	VALUES (4, 'Alice', 'Howard', 'SC', 'aliceperry@gmail.com');
END;

/* Display all entries in the NEW_CUSTOMERS table.  */
SELECT * FROM NEW_CUSTOMERS;

/* Use alias C for EXISTING_CUSTOMERS table and alias N for NEW_CUSTOMERS table.  If CUSTOMER_ID on both C and N tables are equal, update the C table's FIRST_NAME, LAST_NAME, ADDRESS_STATE, and EMAIL_ADDRESS 
equal to the N table's counterparts.  If the CUSTOMER_ID doesn't match from both C and N tables, insert entries from N table to C table.  Simply put, existing entries are updated on the EXISTING_CUSTOMERS table, 
while the new entries are added onto the EXISTING_CUSTOMERS table.  */
MERGE INTO EXISTING_CUSTOMERS C
USING NEW_CUSTOMERS N
ON (C.CUSTOMER_ID = N.CUSTOMER_ID)
WHEN MATCHED THEN
    UPDATE SET
    C.FIRST_NAME = N.FIRST_NAME,
    C.LAST_NAME = N.LAST_NAME,
    C.ADDRESS_STATE = N.ADDRESS_STATE,
    C.EMAIL_ADDRESS = N.EMAIL_ADDRESS
WHEN NOT MATCHED THEN
    INSERT (C.CUSTOMER_ID, C.FIRST_NAME, C.LAST_NAME, C.ADDRESS_STATE, C.EMAIL_ADDRESS)
    VALUES (N.CUSTOMER_ID, N.FIRST_NAME, N.LAST_NAME, N.ADDRESS_STATE, N.EMAIL_ADDRESS);
	
/* Same as above query, but now the entry with FIRST_NAME being 'John' is removed from the table.  */
MERGE INTO EXISTING_CUSTOMERS C
USING NEW_CUSTOMERS N
ON (C.CUSTOMER_ID = N.CUSTOMER_ID)
WHEN MATCHED THEN
    UPDATE SET
    C.FIRST_NAME = N.FIRST_NAME,
    C.LAST_NAME = N.LAST_NAME,
    C.ADDRESS_STATE = N.ADDRESS_STATE,
    C.EMAIL_ADDRESS = N.EMAIL_ADDRESS
DELETE WHERE C.FIRST_NAME = 'John'
WHEN NOT MATCHED THEN
    INSERT (C.CUSTOMER_ID, C.FIRST_NAME, C.LAST_NAME, C.ADDRESS_STATE, C.EMAIL_ADDRESS)
    VALUES (N.CUSTOMER_ID, N.FIRST_NAME, N.LAST_NAME, N.ADDRESS_STATE, N.EMAIL_ADDRESS);