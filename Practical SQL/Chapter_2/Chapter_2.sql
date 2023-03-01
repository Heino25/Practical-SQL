-- SELECT
SELECT * FROM teachers;

-- SELECT subset of columns
SELECT last_name, first_name, salary FROM teachers;

-- Using DISTICT to find unique values
SELECT DISTINCT school
FROM teachers;

-- Sorting data with ORDER BY
SELECT first_name, last_name, salary
FROM teachers
ORDER BY salary DESC;

-- Sorting using multiple columns
SELECT last_name, school, hire_date
FROM teachers
ORDER BY school ASC, hire_date DESC;

-- Filter rows with WHERE
SELECT last_name, school, hire_date
FROM teachers
WHERE school = 'Myers Middle School';

-- Filter using WHERE and Comparison operators
SELECT first_name, last_name, school
FROM teachers
WHERE first_name = 'Janet'; -- EQUAL operator

SELECT school
FROM teachers
WHERE school != 'F.D. Roosevelt HS'; -- NOT EQUAL operator

SELECT first_name, last_name, hire_date
FROM teachers
WHERE hire_date < '2000-01-01'; -- LESS THAN operator

SELECT first_name, last_name, salary
FROM teachers
WHERE salary >= 43500; -- GREATER OR EQUAL operator

SELECT first_name, last_name, school, salary
FROM teachers
WHERE salary BETWEEN 40000 AND 65000; -- BETWEEN (inclusive)

SELECT first_name
FROM teachers
WHERE first_name LIKE 'sam%'; -- case sensitive

SELECT first_name
FROM teachers
WHERE first_name ILIKE 'sam%'; -- case insensitive

-- AND and OR
SELECT * FROM teachers
WHERE school = 'Myers Middle School' AND salary < 40000;

SELECT * FROM teachers
WHERE last_name = 'Cole' OR last_name = 'Bush';

SELECT * FROM teachers
WHERE school = 'F.D. Roosevelt HS' AND (salary < 38000 OR salary > 40000);

SELECT first_name, last_name, school, hire_date, salary
FROM teachers
WHERE school LIKE '%Roos%'
ORDER BY hire_date DESC;