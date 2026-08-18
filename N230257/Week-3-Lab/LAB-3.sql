USE gram_panchayat_db;

SHOW TABLES;

SELECT * FROM citizen_details;
SELECT * FROM Certificate_Type;
SELECT * FROM panchayat_office;
SELECT * FROM Certificate_Application;

ALTER TABLE Certificate_Application
ADD COLUMN certificate_id INT;

ALTER TABLE Certificate_Application
ADD COLUMN office_id INT;

UPDATE Certificate_Application ca
JOIN Certificate_Type ct 
ON ca.certificate_name = ct.certificate_name
SET ca.certificate_id = ct.certificate_type_id;

UPDATE Certificate_Application ca
JOIN citizen_details c 
ON ca.citizen_id = c.citizen_id
JOIN panchayat_office po 
ON c.village_name = po.village_name
SET ca.office_id = po.office_id;

ALTER TABLE Certificate_Application
DROP COLUMN certificate_name;

ALTER TABLE Certificate_Application
ADD CONSTRAINT fk_citizen
FOREIGN KEY (citizen_id) REFERENCES citizen_details(citizen_id);

ALTER TABLE Certificate_Application
ADD CONSTRAINT fk_certificate
FOREIGN KEY (certificate_id) REFERENCES Certificate_Type(certificate_type_id);

ALTER TABLE Certificate_Application
ADD CONSTRAINT fk_office
FOREIGN KEY (office_id) REFERENCES panchayat_office(office_id);

SHOW CREATE TABLE Certificate_Application;


INSERT INTO Certificate_Application
(application_id, citizen_id, application_date, purpose, application_status, fee_paid, reference_number, certificate_id, office_id)
VALUES
(2001, 999, '2026-08-01', 'Test invalid citizen', 'Submitted', 30.00, 'GP20260010', 1, 1);


INSERT INTO Certificate_Application
(application_id, citizen_id, application_date, purpose, application_status, fee_paid, reference_number, certificate_id, office_id)
VALUES
(2002, 101, '2026-08-01', 'Test invalid certificate', 'Submitted', 30.00, 'GP20260011', 999, 1);


DELETE FROM citizen_details
WHERE citizen_id = 101;

DELETE FROM Certificate_Type
WHERE certificate_type_id = 1;


SELECT * FROM citizen_details;

SELECT * FROM Certificate_Application;

SELECT full_name 
FROM citizen_details
ORDER BY full_name ASC;

SELECT DISTINCT village_name 
FROM citizen_details;

SELECT DISTINCT certificate_name 
FROM Certificate_Type;

SELECT DISTINCT office_name 
FROM panchayat_office;


SELECT * 
FROM Certificate_Application
WHERE application_status = 'Pending';


SELECT * 
FROM citizen_details
WHERE village_name = 'Ramapuram';


SELECT * 
FROM Certificate_Application
WHERE YEAR(application_date) = 2026;


SELECT * 
FROM Certificate_Application
ORDER BY application_date DESC;


SELECT ca.*
FROM Certificate_Application ca
JOIN panchayat_office po 
ON ca.office_id = po.office_id
WHERE po.office_name = 'Nuzvid Panchayat Office';


SELECT c.full_name
FROM citizen_details c
JOIN Certificate_Application ca 
ON c.citizen_id = ca.citizen_id
JOIN Certificate_Type ct 
ON ca.certificate_id = ct.certificate_type_id
WHERE ct.certificate_name = 'Income Certificate';


SELECT c.full_name
FROM citizen_details c
JOIN Certificate_Application ca 
ON c.citizen_id = ca.citizen_id
JOIN Certificate_Type ct 
ON ca.certificate_id = ct.certificate_type_id
WHERE ct.certificate_name = 'Income Certificate'

UNION

SELECT c.full_name
FROM citizen_details c
JOIN Certificate_Application ca 
ON c.citizen_id = ca.citizen_id
JOIN Certificate_Type ct 
ON ca.certificate_id = ct.certificate_type_id
WHERE ct.certificate_name = 'Residence Certificate';


SELECT * 
FROM Certificate_Application
WHERE MONTH(application_date) = 1

UNION

SELECT * 
FROM Certificate_Application
WHERE MONTH(application_date) = 2;


SELECT * 
FROM citizen_details
WHERE village_name = 'Ramapuram'

UNION

SELECT * 
FROM citizen_details
WHERE village_name = 'Lakshmipuram';


SELECT c.full_name
FROM citizen_details c
JOIN Certificate_Application ca 
ON c.citizen_id = ca.citizen_id
JOIN Certificate_Type ct 
ON ca.certificate_id = ct.certificate_type_id
WHERE ct.certificate_name = 'Income Certificate'

INTERSECT

SELECT c.full_name
FROM citizen_details c
JOIN Certificate_Application ca 
ON c.citizen_id = ca.citizen_id
JOIN Certificate_Type ct 
ON ca.certificate_id = ct.certificate_type_id
WHERE ct.certificate_name = 'Residence Certificate';


SELECT c.full_name
FROM citizen_details c
JOIN Certificate_Application ca 
ON c.citizen_id = ca.citizen_id
WHERE YEAR(ca.application_date) = 2025

INTERSECT

SELECT c.full_name
FROM citizen_details c
JOIN Certificate_Application ca 
ON c.citizen_id = ca.citizen_id
WHERE YEAR(ca.application_date) = 2026;


SELECT c.full_name
FROM citizen_details c
JOIN Certificate_Application ca 
ON c.citizen_id = ca.citizen_id
JOIN Certificate_Type ct 
ON ca.certificate_id = ct.certificate_type_id
WHERE ct.certificate_name = 'Income Certificate'

EXCEPT

SELECT c.full_name
FROM citizen_details c
JOIN Certificate_Application ca 
ON c.citizen_id = ca.citizen_id
JOIN Certificate_Type ct 
ON ca.certificate_id = ct.certificate_type_id
WHERE ct.certificate_name = 'Residence Certificate';


SELECT * 
FROM Certificate_Application
WHERE YEAR(application_date) = 2026

EXCEPT

SELECT * 
FROM Certificate_Application
WHERE YEAR(application_date) = 2025;


SELECT full_name
FROM citizen_details
WHERE citizen_id IN (
    SELECT DISTINCT citizen_id
    FROM Certificate_Application
);


SELECT * 
FROM citizen_details
WHERE village_name IN (
    SELECT c.village_name
    FROM citizen_details c
    JOIN Certificate_Application ca 
    ON c.citizen_id = ca.citizen_id
    JOIN Certificate_Type ct 
    ON ca.certificate_id = ct.certificate_type_id
    WHERE ct.certificate_name = 'Income Certificate'
);


SELECT full_name
FROM citizen_details
WHERE citizen_id NOT IN (
    SELECT DISTINCT citizen_id
    FROM Certificate_Application
);


SELECT * 
FROM panchayat_office
WHERE office_id NOT IN (
    SELECT DISTINCT office_id
    FROM Certificate_Application
    WHERE office_id IS NOT NULL
);


SELECT full_name
FROM citizen_details c
WHERE EXISTS (
    SELECT 1
    FROM Certificate_Application ca
    WHERE ca.citizen_id = c.citizen_id
);


SELECT * 
FROM Certificate_Type ct
WHERE EXISTS (
    SELECT 1
    FROM Certificate_Application ca
    WHERE ca.certificate_id = ct.certificate_type_id
);


SELECT full_name
FROM citizen_details c
WHERE NOT EXISTS (
    SELECT 1
    FROM Certificate_Application ca
    WHERE ca.citizen_id = c.citizen_id
);


SELECT * 
FROM Certificate_Type ct
WHERE NOT EXISTS (
    SELECT 1
    FROM Certificate_Application ca
    WHERE ca.certificate_id = ct.certificate_type_id
);


SELECT * 
FROM citizen_details
WHERE TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) > ANY (
    SELECT TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE())
    FROM citizen_details
    WHERE village_name = 'Ramapuram'
);


SELECT ca.*
FROM Certificate_Application ca
JOIN Certificate_Type ct 
ON ca.certificate_id = ct.certificate_type_id
WHERE ct.processing_days > ANY (
    SELECT ct2.processing_days
    FROM Certificate_Application ca2
    JOIN Certificate_Type ct2 
    ON ca2.certificate_id = ct2.certificate_type_id
    JOIN panchayat_office po 
    ON ca2.office_id = po.office_id
    WHERE po.office_name = 'Nuzvid Panchayat Office'
);


SELECT * 
FROM citizen_details
WHERE TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) > ALL (
    SELECT TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE())
    FROM citizen_details
    WHERE village_name = 'Ramapuram'
);


SELECT ca.*
FROM Certificate_Application ca
JOIN Certificate_Type ct 
ON ca.certificate_id = ct.certificate_type_id
WHERE ct.processing_days > ALL (
    SELECT ct2.processing_days
    FROM Certificate_Application ca2
    JOIN Certificate_Type ct2 
    ON ca2.certificate_id = ct2.certificate_type_id
    JOIN panchayat_office po 
    ON ca2.office_id = po.office_id
    WHERE po.office_name = 'Nuzvid Panchayat Office'
);


SELECT c.full_name,
       COUNT(ca.application_id) AS total_applications
FROM citizen_details c
JOIN Certificate_Application ca 
ON c.citizen_id = ca.citizen_id
GROUP BY c.full_name
ORDER BY total_applications DESC
LIMIT 1;


SELECT po.office_name,
       COUNT(ca.application_id) AS total_applications
FROM panchayat_office po
JOIN Certificate_Application ca 
ON po.office_id = ca.office_id
GROUP BY po.office_name
ORDER BY total_applications DESC
LIMIT 1;


SELECT ct.certificate_name,
       COUNT(ca.application_id) AS total_applications
FROM Certificate_Type ct
JOIN Certificate_Application ca 
ON ct.certificate_type_id = ca.certificate_id
GROUP BY ct.certificate_name
HAVING COUNT(ca.application_id) > 5;


SELECT village_name
FROM citizen_details
WHERE citizen_id NOT IN (
    SELECT DISTINCT citizen_id
    FROM Certificate_Application
);


SELECT c.full_name
FROM citizen_details c
JOIN Certificate_Application ca 
ON c.citizen_id = ca.citizen_id
GROUP BY c.full_name
HAVING COUNT(DISTINCT ca.certificate_id) = (
    SELECT COUNT(*)
    FROM Certificate_Type
);


SELECT c.full_name,
       po.office_name
FROM citizen_details c
JOIN Certificate_Application ca 
ON c.citizen_id = ca.citizen_id
JOIN panchayat_office po 
ON ca.office_id = po.office_id
WHERE po.is_operational = TRUE;