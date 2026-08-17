USE gram_panchayat_db;
SHOW TABLES;
SELECT * FROM citizen;
SELECT * FROM certificate_application;
SELECT * FROM certificate_type;
SELECT * FROM panchayat_office;
DESC citizen;
DESC certificate_type;
DESC panchayat_office;
DESC certificate_application;
ALTER TABLE certificate_application
ADD certificate_id INT,
ADD office_id INT;
UPDATE certificate_application ca
JOIN certificate_type ct
on ca.certificate_name=ct.certificate_name
SET ca.certificate_id=ct.certificate_type_id;
UPDATE certificate_application
SET office_id = 1
WHERE application_id = 1001;
UPDATE certificate_application
SET office_id = 2
WHERE application_id = 1002;
UPDATE certificate_application
SET office_id = 3
WHERE application_id = 1003;
UPDATE certificate_application
SET office_id = 4
WHERE application_id = 1004;
UPDATE certificate_application
SET office_id = 5
WHERE application_id = 1005;
UPDATE certificate_application
SET office_id = 6
WHERE application_id = 1006;
SELECT application_id, certificate_id, office_id
FROM certificate_application;
ALTER TABLE certificate_application
DROP COLUMN certificate_name;
ALTER TABLE certificate_application
ADD CONSTRAINT fk_citizen
FOREIGN KEY (citizen_id)
REFERENCES citizen(citizen_id);
ALTER TABLE certificate_application
ADD CONSTRAINT fk_certificate
FOREIGN KEY (certificate_id)
REFERENCES certificate_type(certificate_type_id);
ALTER TABLE certificate_application
ADD CONSTRAINT fk_office
FOREIGN KEY (office_id)
REFERENCES panchayat_office(office_id);
SHOW CREATE TABLE certificate_application;
INSERT INTO certificate_application
(application_id, citizen_id, application_date, purpose, application_status,
fee_paid, reference_number, certificate_id, office_id)
VALUES
(2001, 999, '2026-08-03', 'Testing', 'Submitted',
30.00, 'TEST001', 1, 1);
INSERT INTO certificate_application
(application_id, citizen_id, application_date, purpose, application_status,
fee_paid, reference_number, certificate_id, office_id)
VALUES
(2002, 101, '2026-08-03', 'Testing', 'Submitted',
30.00, 'TEST002', 999, 1);
DELETE FROM citizen
WHERE citizen_id = 101;
DELETE FROM certificate_type
WHERE certificate_type_id = 1;
SELECT * from citizen;
SELECT * from certificate_application;
SELECT full_name
FROM citizen
ORDER BY full_name ASC;
SELECT DISTINCT village_name
FROM citizen;
SELECT DISTINCT certificate_name
FROM certificate_type;
SELECT DISTINCT office_name
FROM panchayat_office;
SELECT *
FROM certificate_application
WHERE application_status = 'Pending';
SELECT *
FROM citizen
WHERE village_name = 'Ramapuram';
SELECT *
FROM certificate_application
WHERE YEAR(application_date) = 2026;
SELECT *
FROM certificate_application
ORDER BY application_date DESC;
SELECT ca.*
FROM certificate_application ca
JOIN panchayat_office po
ON ca.office_id = po.office_id
WHERE po.office_name = 'Nuzvid Panchayat Office';
SELECT c.full_name
FROM citizen c
JOIN certificate_application ca
ON c.citizen_id = ca.citizen_id
JOIN certificate_type ct
ON ca.certificate_id = ct.certificate_type_id
WHERE ct.certificate_name = 'Income Certificate';
SELECT c.full_name
FROM citizen c
JOIN certificate_application ca
ON c.citizen_id = ca.citizen_id
JOIN certificate_type ct
ON ca.certificate_id = ct.certificate_type_id
WHERE ct.certificate_name = 'Income Certificate'

UNION

SELECT c.full_name
FROM citizen c
JOIN certificate_application ca
ON c.citizen_id = ca.citizen_id
JOIN certificate_type ct
ON ca.certificate_id = ct.certificate_type_id
WHERE ct.certificate_name = 'Residence Certificate';
SELECT *
FROM citizen
WHERE village_name = 'Ramapuram'

UNION

SELECT *
FROM citizen
WHERE village_name = 'Lakshmipuram';
SELECT c.full_name
FROM citizen c
JOIN certificate_application ca
ON c.citizen_id = ca.citizen_id
JOIN certificate_type ct
ON ca.certificate_id = ct.certificate_type_id
WHERE ct.certificate_name = 'Income Certificate'

AND c.citizen_id IN (
    SELECT ca.citizen_id
    FROM certificate_application ca
    JOIN certificate_type ct
    ON ca.certificate_id = ct.certificate_type_id
    WHERE ct.certificate_name = 'Residence Certificate'
);
SELECT c.full_name
FROM citizen c
JOIN certificate_application ca
ON c.citizen_id = ca.citizen_id
WHERE YEAR(ca.application_date) = 2025

AND c.citizen_id IN (
    SELECT citizen_id
    FROM certificate_application
    WHERE YEAR(application_date) = 2026
);
SELECT c.full_name
FROM citizen c
JOIN certificate_application ca
ON c.citizen_id = ca.citizen_id
JOIN certificate_type ct
ON ca.certificate_id = ct.certificate_type_id
WHERE ct.certificate_name = 'Income Certificate'

AND c.citizen_id NOT IN (
    SELECT ca.citizen_id
    FROM certificate_application ca
    JOIN certificate_type ct
    ON ca.certificate_id = ct.certificate_type_id
    WHERE ct.certificate_name = 'Residence Certificate'
);
SELECT *
FROM certificate_application
WHERE YEAR(application_date) = 2026
AND citizen_id NOT IN (
    SELECT citizen_id
    FROM certificate_application
    WHERE YEAR(application_date) = 2025
);
INSERT INTO certificate_application
(application_id, citizen_id, application_date, purpose, application_status,
fee_paid, reference_number, certificate_id, office_id)
VALUES
(3001, 999, '2026-08-03', 'Testing', 'Submitted',
30.00, 'TEST3001', 1, 1);
DELETE FROM citizen
WHERE citizen_id = 101;
SELECT full_name
FROM citizen
WHERE citizen_id IN (
    SELECT citizen_id
    FROM certificate_application
);
SELECT *
FROM citizen
WHERE village_name IN (
    SELECT c.village_name
    FROM citizen c
    JOIN certificate_application ca
    ON c.citizen_id = ca.citizen_id
    JOIN certificate_type ct
    ON ca.certificate_id = ct.certificate_type_id
    WHERE ct.certificate_name = 'Income Certificate'
);
SELECT *
FROM citizen
WHERE citizen_id NOT IN (
    SELECT citizen_id
    FROM certificate_application
);
SELECT *
FROM panchayat_office
WHERE office_id NOT IN (
    SELECT office_id
    FROM certificate_application
);
SELECT *
FROM citizen c
WHERE EXISTS (
    SELECT 1
    FROM certificate_application ca
    WHERE ca.citizen_id = c.citizen_id
);
SELECT *
FROM certificate_type ct
WHERE EXISTS (
    SELECT 1
    FROM certificate_application ca
    WHERE ca.certificate_id = ct.certificate_type_id
);
SELECT *
FROM citizen c
WHERE NOT EXISTS (
    SELECT 1
    FROM certificate_application ca
    WHERE ca.citizen_id = c.citizen_id
);
SELECT *
FROM certificate_type ct
WHERE NOT EXISTS (
    SELECT 1
    FROM certificate_application ca
    WHERE ca.certificate_id = ct.certificate_type_id
);
SELECT *
FROM citizen
WHERE date_of_birth > ANY (
    SELECT date_of_birth
    FROM citizen
    WHERE village_name = 'Ramapuram'
);
SELECT c.full_name, COUNT(*) AS total_applications
FROM citizen c
JOIN certificate_application ca
ON c.citizen_id = ca.citizen_id
GROUP BY c.citizen_id, c.full_name
HAVING COUNT(*) =(
   SELECT MAX(app_count)
   FROM (
       SELECT COUNT(*) AS app_count
       FROM certificate_application
       GROUP BY citizen_id
       ) AS t
);
SELECT p.office_name, COUNT(*) AS total
FROM panchayat_office p
JOIN certificate_application ca
ON p.office_id = ca.office_id
GROUP BY p.office_id, p.office_name
ORDER BY total DESC
;
SELECT ct.certificate_name, COUNT(*) AS total
FROM certificate_type ct
JOIN certificate_application ca
ON ct.certificate_type_id = ca.certificate_id
GROUP BY ct.certificate_type_id, ct.certificate_name
HAVING COUNT(*) > 5;
SELECT DISTINCT village_name
FROM citizen
WHERE citizen_id NOT IN (
    SELECT citizen_id
    FROM certificate_application
);
SELECT c.full_name
FROM citizen c
WHERE NOT EXISTS (
    SELECT certificate_type_id
    FROM certificate_type ct
    WHERE NOT EXISTS (
        SELECT 1
        FROM certificate_application ca
        WHERE ca.citizen_id = c.citizen_id
        AND ca.certificate_id = ct.certificate_type_id
    )
);USE gram_panchayat_db;
SHOW TABLES;
SELECT * FROM citizen;
SELECT * FROM certificate_application;
SELECT * FROM certificate_type;
SELECT * FROM panchayat_office;
DESC citizen;
DESC certificate_type;
DESC panchayat_office;
DESC certificate_application;
ALTER TABLE certificate_application
ADD certificate_id INT,
ADD office_id INT;
UPDATE certificate_application ca
JOIN certificate_type ct
on ca.certificate_name=ct.certificate_name
SET ca.certificate_id=ct.certificate_type_id;
UPDATE certificate_application
SET office_id = 1
WHERE application_id = 1001;
UPDATE certificate_application
SET office_id = 2
WHERE application_id = 1002;
UPDATE certificate_application
SET office_id = 3
WHERE application_id = 1003;
UPDATE certificate_application
SET office_id = 4
WHERE application_id = 1004;
UPDATE certificate_application
SET office_id = 5
WHERE application_id = 1005;
UPDATE certificate_application
SET office_id = 6
WHERE application_id = 1006;
SELECT application_id, certificate_id, office_id
FROM certificate_application;
ALTER TABLE certificate_application
DROP COLUMN certificate_name;
ALTER TABLE certificate_application
ADD CONSTRAINT fk_citizen
FOREIGN KEY (citizen_id)
REFERENCES citizen(citizen_id);
ALTER TABLE certificate_application
ADD CONSTRAINT fk_certificate
FOREIGN KEY (certificate_id)
REFERENCES certificate_type(certificate_type_id);
ALTER TABLE certificate_application
ADD CONSTRAINT fk_office
FOREIGN KEY (office_id)
REFERENCES panchayat_office(office_id);
SHOW CREATE TABLE certificate_application;
INSERT INTO certificate_application
(application_id, citizen_id, application_date, purpose, application_status,
fee_paid, reference_number, certificate_id, office_id)
VALUES
(2001, 999, '2026-08-03', 'Testing', 'Submitted',
30.00, 'TEST001', 1, 1);
INSERT INTO certificate_application
(application_id, citizen_id, application_date, purpose, application_status,
fee_paid, reference_number, certificate_id, office_id)
VALUES
(2002, 101, '2026-08-03', 'Testing', 'Submitted',
30.00, 'TEST002', 999, 1);
DELETE FROM citizen
WHERE citizen_id = 101;
DELETE FROM certificate_type
WHERE certificate_type_id = 1;
SELECT * from citizen;
SELECT * from certificate_application;
SELECT full_name
FROM citizen
ORDER BY full_name ASC;
SELECT DISTINCT village_name
FROM citizen;
SELECT DISTINCT certificate_name
FROM certificate_type;
SELECT DISTINCT office_name
FROM panchayat_office;
SELECT *
FROM certificate_application
WHERE application_status = 'Pending';
SELECT *
FROM citizen
WHERE village_name = 'Ramapuram';
SELECT *
FROM certificate_application
WHERE YEAR(application_date) = 2026;
SELECT *
FROM certificate_application
ORDER BY application_date DESC;
SELECT ca.*
FROM certificate_application ca
JOIN panchayat_office po
ON ca.office_id = po.office_id
WHERE po.office_name = 'Nuzvid Panchayat Office';
SELECT c.full_name
FROM citizen c
JOIN certificate_application ca
ON c.citizen_id = ca.citizen_id
JOIN certificate_type ct
ON ca.certificate_id = ct.certificate_type_id
WHERE ct.certificate_name = 'Income Certificate';
SELECT c.full_name
FROM citizen c
JOIN certificate_application ca
ON c.citizen_id = ca.citizen_id
JOIN certificate_type ct
ON ca.certificate_id = ct.certificate_type_id
WHERE ct.certificate_name = 'Income Certificate'

UNION

SELECT c.full_name
FROM citizen c
JOIN certificate_application ca
ON c.citizen_id = ca.citizen_id
JOIN certificate_type ct
ON ca.certificate_id = ct.certificate_type_id
WHERE ct.certificate_name = 'Residence Certificate';
SELECT *
FROM citizen
WHERE village_name = 'Ramapuram'

UNION

SELECT *
FROM citizen
WHERE village_name = 'Lakshmipuram';
SELECT c.full_name
FROM citizen c
JOIN certificate_application ca
ON c.citizen_id = ca.citizen_id
JOIN certificate_type ct
ON ca.certificate_id = ct.certificate_type_id
WHERE ct.certificate_name = 'Income Certificate'

AND c.citizen_id IN (
    SELECT ca.citizen_id
    FROM certificate_application ca
    JOIN certificate_type ct
    ON ca.certificate_id = ct.certificate_type_id
    WHERE ct.certificate_name = 'Residence Certificate'
);
SELECT c.full_name
FROM citizen c
JOIN certificate_application ca
ON c.citizen_id = ca.citizen_id
WHERE YEAR(ca.application_date) = 2025

AND c.citizen_id IN (
    SELECT citizen_id
    FROM certificate_application
    WHERE YEAR(application_date) = 2026
);
SELECT c.full_name
FROM citizen c
JOIN certificate_application ca
ON c.citizen_id = ca.citizen_id
JOIN certificate_type ct
ON ca.certificate_id = ct.certificate_type_id
WHERE ct.certificate_name = 'Income Certificate'

AND c.citizen_id NOT IN (
    SELECT ca.citizen_id
    FROM certificate_application ca
    JOIN certificate_type ct
    ON ca.certificate_id = ct.certificate_type_id
    WHERE ct.certificate_name = 'Residence Certificate'
);
SELECT *
FROM certificate_application
WHERE YEAR(application_date) = 2026
AND citizen_id NOT IN (
    SELECT citizen_id
    FROM certificate_application
    WHERE YEAR(application_date) = 2025
);
INSERT INTO certificate_application
(application_id, citizen_id, application_date, purpose, application_status,
fee_paid, reference_number, certificate_id, office_id)
VALUES
(3001, 999, '2026-08-03', 'Testing', 'Submitted',
30.00, 'TEST3001', 1, 1);
DELETE FROM citizen
WHERE citizen_id = 101;
SELECT full_name
FROM citizen
WHERE citizen_id IN (
    SELECT citizen_id
    FROM certificate_application
);
SELECT *
FROM citizen
WHERE village_name IN (
    SELECT c.village_name
    FROM citizen c
    JOIN certificate_application ca
    ON c.citizen_id = ca.citizen_id
    JOIN certificate_type ct
    ON ca.certificate_id = ct.certificate_type_id
    WHERE ct.certificate_name = 'Income Certificate'
);
SELECT *
FROM citizen
WHERE citizen_id NOT IN (
    SELECT citizen_id
    FROM certificate_application
);
SELECT *
FROM panchayat_office
WHERE office_id NOT IN (
    SELECT office_id
    FROM certificate_application
);
SELECT *
FROM citizen c
WHERE EXISTS (
    SELECT 1
    FROM certificate_application ca
    WHERE ca.citizen_id = c.citizen_id
);
SELECT *
FROM certificate_type ct
WHERE EXISTS (
    SELECT 1
    FROM certificate_application ca
    WHERE ca.certificate_id = ct.certificate_type_id
);
SELECT *
FROM citizen c
WHERE NOT EXISTS (
    SELECT 1
    FROM certificate_application ca
    WHERE ca.citizen_id = c.citizen_id
);
SELECT *
FROM certificate_type ct
WHERE NOT EXISTS (
    SELECT 1
    FROM certificate_application ca
    WHERE ca.certificate_id = ct.certificate_type_id
);
SELECT *
FROM citizen
WHERE date_of_birth > ANY (
    SELECT date_of_birth
    FROM citizen
    WHERE village_name = 'Ramapuram'
);
SELECT c.full_name, COUNT(*) AS total_applications
FROM citizen c
JOIN certificate_application ca
ON c.citizen_id = ca.citizen_id
GROUP BY c.citizen_id, c.full_name
HAVING COUNT(*) =(
   SELECT MAX(app_count)
   FROM (
       SELECT COUNT(*) AS app_count
       FROM certificate_application
       GROUP BY citizen_id
       ) AS t
);
SELECT p.office_name, COUNT(*) AS total
FROM panchayat_office p
JOIN certificate_application ca
ON p.office_id = ca.office_id
GROUP BY p.office_id, p.office_name
ORDER BY total DESC
;
SELECT ct.certificate_name, COUNT(*) AS total
FROM certificate_type ct
JOIN certificate_application ca
ON ct.certificate_type_id = ca.certificate_id
GROUP BY ct.certificate_type_id, ct.certificate_name
HAVING COUNT(*) > 5;
SELECT DISTINCT village_name
FROM citizen
WHERE citizen_id NOT IN (
    SELECT citizen_id
    FROM certificate_application
);
SELECT c.full_name
FROM citizen c
WHERE NOT EXISTS (
    SELECT certificate_type_id
    FROM certificate_type ct
    WHERE NOT EXISTS (
        SELECT 1
        FROM certificate_application ca
        WHERE ca.citizen_id = c.citizen_id
        AND ca.certificate_id = ct.certificate_type_id
    )
);