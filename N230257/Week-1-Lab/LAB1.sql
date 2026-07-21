CREATE TABLE Certificate_Type
(certificate_type_id INT  Primary Key,
certificate_name VARCHAR(100) Unique,
descriptin VARCHAR(200) Not Null,
processing_days INT Not Null,
application_fee DECIMAL(8,2) Not Null,
is_available BOOLEAN Not Null);

insert into Certificate_Type 
(certificate_type_id,certificate_name,descriptin,processing_days,application_fee,is_available)
values
(1,"residence Certificate","Certifies the declared place of residence",7,30.00,TRUE),
(2,"Birth Record Request","Request for a locally maintained birth record",5,20.00,TRUE),
(3,"Death Record Request","Request for a locally maintained death record",5,20.00,TRUE),
(4,"Family Member Certificate","Records declared family-member information",10,40.00,TRUE),
(5,"Property Certificate","Certificate related to locally maintained property records",15,50.00,TRUE),
(6,"No-Dues Certificate","Indicates applicable local dues status",7,25.00,FALSE);

CREATE TABLE Certificate_Application
(application_id INT Primary Key,
citizen_id INT Not Null,
certificate_name VARCHAR(100) Not Null,
application_date DATE Not Null,
purpose VARCHAR(200) Not Null,
application_status VARCHAR(30) Not Null,
fee_paid DECIMAL(8,2) Not Null,
reference_number VARCHAR(30) Unique);

insert into Certificate_Application 
(application_id,citizen_id,certificate_name,application_date,purpose,application_status,fee_paid,reference_number)
values
(1001,101,"Residence Certificate","2026-07-01","Bank account documentation","Submitted",30.00,"GP20260001"),
(1002,102,"Family Member Certificate","2026-07-02","Welfare scheme application","Under review",40.00,"GP20260002"),
(1003,103,"Property certificate","2026-07-03","Property documentation","Submitted",50.00,"GP20260003"),
(1004,104,"Residence Certificate","2026-07-04","College admission","Approved",30.00,"GP20260004"),
(1005,105,"No-Dues Certificate","2026-07-05","Local service requirement","Under Review",25.00,"GP20260005"),
(1006,106,"Birth Record Request","2026-07-06","Personal documentation","Rejected",20.00,"GP20260006");

CREATE TABLE panchayat_office
(office_id INT Primary Key,
office_name VARCHAR(100) Not Null,
village_name VARCHAR(50) Not Null,
pincode VARCHAR(6) Not Null,
contact_number VARCHAR(15) Unique,
office_email VARCHAR(100) Unique,
opening_name TIME Not Null,
is_operational BOOLEAN Not Null
);


insert into panchayat_office 
(office_id,office_name,village_name,pincode,contact_number,office_email,opening_name,is_operational)
values
(1,"Ramapuram Gram Panchayat","Ramapuram","521101","0866000001","ramapuram@gp.example","09:00:00",TRUE),
(2,"Seethampeta Gram panchayat","Seethampeta","521102","0866000002","seethampeta@gp.example","09:30:00",TRUE),
(3,"Lakshmipuram Gram Panchayat","Lakshmipuram","521103","0866000003","lakshmipuram@gp.example","09:00:00",TRUE),
(4,"Krishnapuram Gram Panchayat","Krishna puram","521104","0866000004","krishnapuram@gp.example","10:00:00",TRUE),
(5,"Venkatapuram Gram Panchayat","Venkatapuram","521105","0866000005","venkatapuram@gp.example","09:30:00",TRUE),
(6,"Gopalapuram Gram Panchayat ","Gopalapuram","521106","0866000006","gopalapuram@gp.example","09:00:00",TRUE);



CREATE TABLE citizen_details(
citizen_id INT PRIMARY KEY,
full_name VARCHAR(100) NOT NULL,
dob DATE NOT NULL,
gender VARCHAR(10) NOT NULL,
mobile_number VARCHAR(15) UNIQUE NOT NULL,
occupation VARCHAR(50) NOT NULL,
village_name VARCHAR(50) NOT NULL,
is_active BOOLEAN NOT NULL
);

INSERT INTO citizen_details VALUES(101,"ravi kumar","1995-06-15","male","9876500001","farmer","ramapuram",TRUE),
(102,"lakshmi devi","1988-11-22","female","9876500002","tailor","ramapuram",TRUE),
(103,"suresh babu","1992-03-10","male","9876500003","shopkeeper","seethampeta",TRUE),
(104,"anjali","2000-08-05","female","9876500004","student","ramapuram",TRUE),
(105,"kiran kumar","1985-01-18","male","9876500005","electrician","seethampeta",TRUE),
(106,"meena kumari","1998-12-30","female","9876500006","teacher","lakshmipuram",FALSE);

INSERT INTO citizen_details VALUES(107,"SATYA","2000-09-21","MALE","9876500007","STUDENT","AMALAPURAM",TRUE);

INSERT INTO Certificate_Type VALUES(7,"INCOME CERTIFICATE","certifies the income of perosn",4,50.00,TRUE);

UPDATE Certificate_Application SET application_status="UNDER REVIEW" WHERE application_id=1001;

UPDATE Certificate_Application SET application_status="APPROVED" WHERE application_id=1002;

UPDATE citizen_details SET occupation="ELECTRICAL TECHICIAN" WHERE citizen_id=105;

UPDATE Certificate_Type SET processing_days=12 WHERE certificate_type_id=5;

UPDATE Certificate_Type SET is_available=TRUE WHERE certificate_type_id=6;

DELETE FROM citizen_details WHERE citizen_id=107;

ALTER TABLE citizen_details ADD COLUMN address VARCHAR(100);

ALTER TABLE Certificate_Application  ADD COLUMN issued_date DATE;

ALTER TABLE Certificate_Application MODIFY COLUMN purpose VARCHAR(200);

ALTER TABLE panchayat_office  ADD COLUMN closing_time TIME;

CREATE TABLE temporary_request(
request_id INT PRIMARY KEY,
request_name VARCHAR(100) NOT NULL,
request_date DATE NOT NULL);

INSERT INTO temporary_request VALUES(101,"LAPTOP ISSUE","2026-10-11"),
(102," ID ISSUE","2026-12-21"),
(103,"ATTENDANCE ISSUE","2026-09-17");

SELECT * FROM temporary_request;

--PRACTICE--

TRUNCATE temporary_request;

DROP TABLE temporary_request;

--CONSTRAINT EXPERIMENT--

INSERT INTO citizen_details VALUES(101,"LIKHITHA","2007-01-21","FEMALE",7981274705,"STUDENT","VIZAG",TRUE);

INSERT INTO citizen_details VALUES(107,"LIKHITHA","2007-01-21","FEMALE",7981274705,"STUDENT",TRUE,"GUNTUR");

INSERT INTO  Certificate_Type VALUES(8,"CERTIFIES THE DECLARED PLACE OF RESIDENCE",7,30.00,TRUE);

CREATE TABLE Certificate(
application_id INT PRIMARY KEY,
citizen_id INT NOT NULL,
certificate_name VARCHAR(50)
);

INSERT INTO Certificate VALUES(1001,999,"UNKNOWN CERIFICATE");