USE gram_panchayat_db;

# 1. Display all citizen names in uppercase.
SELECT UPPER(full_name) FROM citizen_details;

# 2. Display all village names in lowercase.
SELECT LOWER(village_name) FROM citizen_details;

# 3. Find the length of each citizen's full name.
SELECT full_name, LENGTH(full_name) FROM citizen_details;

# 4. Display the first four characters of every reference number.
SELECT reference_number, LEFT(reference_number,4)
FROM Certificate_Application;

# 5. Concatenate the citizen name with village name.
SELECT CONCAT(full_name,' - ',village_name)
FROM citizen_details;

# 6. Replace "Certificate" with "Cert."
SELECT REPLACE(certificate_name,'Certificate','Cert.')
FROM Certificate_Type;

# 7. Remove leading/trailing spaces.
SELECT TRIM(certificate_name)
FROM Certificate_Type;

# 8. Display only the first name.
SELECT SUBSTRING_INDEX(full_name,' ',1)
FROM citizen_details;

# 9. Generate display string.
SELECT CONCAT('Citizen : ',full_name |'Village : ',village_name) 
FROM citizen_details;

# 10. Reference number begins with GP2026.
SELECT *
FROM Certificate_Application
WHERE reference_number LIKE 'GP2026%';


-- PART C – NUMERIC FUNCTIONS

# 11. Round application fee.
SELECT fee_paid,
       ROUND(fee_paid)
FROM Certificate_Application;

# 12. Absolute value of processing_days - 10.
SELECT processing_days,
       ABS(processing_days-10)
FROM Certificate_Type;

# 13. Square of processing days.
SELECT processing_days,
       POWER(processing_days,2)
FROM Certificate_Type;

# 14. Remainder when divided by 3.
SELECT processing_days,
       MOD(processing_days,3)
FROM Certificate_Type;

# 15. Round fee to one decimal place.
SELECT fee_paid,
       ROUND(fee_paid,1)
FROM Certificate_Application;

# 16. Ceiling and Floor values.
SELECT fee_paid,
       CEIL(fee_paid),
       FLOOR(fee_paid)
FROM Certificate_Application;

# 17. Random integer (1-100).
SELECT FLOOR(1 + RAND()*100);

# 18. Square root of processing days.
SELECT processing_days,
       SQRT(processing_days)
FROM Certificate_Type;

# 19. processing_days × 2.
SELECT processing_days,
       processing_days*2 AS Double_Days
FROM Certificate_Type;


-- PART D – DATE FUNCTIONS

# 20. Today's date.
SELECT CURDATE();

# 21. Current date and time.
SELECT NOW();

# 22. Year from application date.
SELECT YEAR(application_date)
FROM Certificate_Application;

# 23. Month from application date.
SELECT MONTH(application_date)
FROM Certificate_Application;

# 24. Day from application date.
SELECT DAY(application_date)
FROM Certificate_Application;

# 25. Expected issue date.
SELECT application_date,
       DATE_ADD(application_date,
       INTERVAL processing_days DAY) AS Date_add
FROM Certificate_Application
JOIN Certificate_Type
USING(certificate_name);

# 26. Add 30 days.
SELECT application_date,
       DATE_ADD(application_date,
       INTERVAL 30 DAY)
FROM Certificate_Application;

# 27. Subtract 7 days.
SELECT application_date,
       DATE_SUB(application_date,
       INTERVAL 7 DAY)
FROM Certificate_Application;

# 28. Days between today and application date.
SELECT application_date,
       DATEDIFF(CURDATE(),application_date)
FROM Certificate_Application;

# 29. Applications submitted this year.
SELECT *
FROM Certificate_Application
WHERE YEAR(application_date)=YEAR(CURDATE());


-- PART E – CONVERSION FUNCTIONS

# 30. Convert application_fee to INTEGER.
SELECT CAST(fee_paid AS SIGNED)
FROM Certificate_Application;

# 31. Convert processing_days to CHAR.
SELECT CAST(processing_days AS CHAR)
FROM Certificate_Type;

# 32. Convert application_date to DATETIME.
SELECT CAST(application_date AS DATETIME)
FROM Certificate_Application;

# 33. Convert processing_days to DECIMAL.
SELECT CAST(processing_days AS DECIMAL(10,2))
FROM Certificate_Type;

# 34. Display fees as character strings.
SELECT CAST(fee_paid AS CHAR)
FROM Certificate_Application;

# 35. Convert numeric values before arithmetic.
SELECT CAST(fee_paid AS DECIMAL(10,2))*2
FROM Certificate_Application