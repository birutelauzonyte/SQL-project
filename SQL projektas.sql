-- Select all employees: Write an SQL query to retrieve all employee records from the Employees table.
USE hrcompany;

SELECT *
FROM hrcompany.Employees;

-- Select specific columns: Show all first names and last names from the Employees table.

SELECT firstname, lastname
FROM hrcompany.Employees;

-- Filter by department
SELECT *
FROM hrcompany.Departments
WHERE departmentName = 'HR';

-- Sort employees by their hire date
SELECT employeeid, firstname, lastname,hiredate
FROM hrcompany.Employees
ORDER BY hiredate;

-- Count the employees: find the total number of employees in the company.
SELECT COUNT(*) AS darbuotoju_skaicius
FROM hrcompany.Employees;

-- Combine employees with departments: display a general list of employees, next to
-- each employee indicating the department in which he works.
SELECT employeeID, firstname, lastname,departmentname
FROM hrcompany.Employees
LEFT JOIN Departments
ON Employees.DepartmentID = Departments.DepartmentID; 
  
-- Calculate the average salary: find what the average salary is among all employees in the company.
SELECT ROUND(AVG(salaryamount), 2) AS vidutinis_atlyginimas
FROM hrcompany.Salaries;

-- Filter and count: find how many employees work in the IT department.
SELECT COUNT(DepartmentName) AS darbuotoju_skaicius
FROM hrcompany.Departments
LEFT JOIN Employees
ON Departments.DepartmentID = Employees.DepartmentID
WHERE DepartmentName = 'IT'

-- Select unique values: Get a list of unique job positions offered from the
-- jobpositions table.
SELECT DISTINCT positionTitle
FROM hrcompany.JobPositions;

-- Select by date range: get employees who were hired between 2020-02-
-- 01 and 2020-11-01.
SELECT employeeID,firstname, lastname, hiredate
FROM hrcompany.Employees
WHERE hiredate BETWEEN '2020-02-01' AND '2020-11-01';

-- Employee Age
SELECT employeeid, firstname, lastname,
      YEAR(CURDATE()) - YEAR(DateOfBirth) - (DATE_FORMAT(CURDATE(), '%m%d') <DATE_FORMAT(DateOfBirth, '%m%d')) AS age
FROM hrcompany.Employees;

-- Employee Email Address List: Get a list of all employee email addresses
-- in alphabetical order.
SELECT  email
FROM hrcompany.Employees
ORDER BY email;

-- Number of employees by department: find how many employees work in each department.
SELECT Departmentname, COUNT(EmployeeID) AS darbuotoju_skaicius
FROM Departments
LEFT JOIN Employees
ON  Departments.DepartmentID = Employees.DepartmentID
GROUP BY Departmentname;

-- select all employees who have more than 3 skills
SELECT EmployeeSkills.EmployeeID AS EmployeeID,
       firstname, lastname, EmployeeSkills.SkillID 
FROM Employees
LEFT JOIN EmployeeSkills
ON Employees.EmployeeID = EmployeeSkills.EmployeeID
LEFT JOIN Skills
ON EmployeeSkills.SkillID = Skills.SkillID
WHERE EmployeeSkills.skillID > 3;

-- Average Cost of Perks: Calculate the average cost of perks
-- employee benefit costs.
SELECT AVG(cost) AS vidutine_papildomos_naudos_kaina
FROM hrcompany.Benefits;

-- Employee phone numbers: Output all employee IDs with their phone
-- numbers.
SELECT employeeID, phone
FROM hrcompany.Employees;

-- Employee hiring month: find which month the most employees were hired.
SELECT MONTH(Hiredate) AS hire_month, COUNT(employeeID) AS how_many_employees
FROM hrcompany.Employees
GROUP BY hire_month
LIMIT 1;

-- get all employees who have the skill “Communication”.
SELECT Employees.EmployeeID, firstname, lastname, skillname
FROM Employees
LEFT JOIN EmployeeSkills
ON Employees.EmployeeID = EmployeeSkills.EmployeeID
LEFT JOIN Skills
ON EmployeeSkills.SkillID = Skills.SkillID
WHERE skillname = 'Communication';

-- Sub-queries: find which employee in the company earns the most and output
-- his information.
SELECT e.FirstName, e.LastName, s.SalaryAmount
FROM hrcompany.Salaries s
JOIN hrcompany.Employees e 
ON e.EmployeeID = s.EmployeeID
WHERE s.SalaryAmount = (SELECT MAX(SalaryAmount) FROM hrcompany.Salaries);

--  Calculate all company benefits costs
SELECT benefitID, sum(cost) AS ismoku_islaidos
FROM hrcompany.Benefits
GROUP BY benefitID;

-- Update records: Update the phone number of the employee whose id is 1.
UPDATE Employees
SET phone = 123
WHERE EmployeeID = 1; 

--  display a list of requests that are pending
-- approval.
SELECT Employees.EmployeeID AS employeeID, firstname, lastname, status
FROM Employees
LEFT JOIN LeaveRequests
ON Employees.EmployeeID = LeaveRequests.EmployeeID
WHERE status = 'pending';

-- display employees who received 5 points in their performance feedback.
SELECT Employees.EmployeeID AS employeeID, 
	   firstname, lastname, rating
FROM Employees
LEFT JOIN PerformanceReviews
ON Employees.EmployeeID = PerformanceReviews.ReviewerID
WHERE rating = 5;

-- Benefits Enrollment: List all employees who are enrolled in the Health Insurance benefit
SELECT Employees.EmployeeID AS EmployeeID, firstname, lastname,benefitname
FROM Employees
LEFT JOIN EmployeeBenefits
ON Employees.EmployeeID = EmployeeBenefits.EmployeeID
LEFT JOIN Benefits
ON EmployeeBenefits.BenefitID = Benefits.BenefitID
WHERE benefitname = 'Health Insurance';

-- Find the 5 employees who have the highest job evaluation rating.
SELECT Employees.EmployeeID AS employeeID, 
       firstname, lastname, rating
FROM Employees
LEFT JOIN PerformanceReviews
ON Employees.EmployeeID = PerformanceReviews.EmployeeID
WHERE rating = 5
LIMIT 5;

-- Get the entire history of leave requests for the employee with id 1.
SELECT Employees.EmployeeID, firstname, lastname, LeaveStartDate,LeaveEndDate, LeaveType, status
FROM Employees
LEFT JOIN LeaveRequests
ON Employees.EmployeeID = LeaveRequests.EmployeeID
WHERE Employees.EmployeeID = 1;

-- Get the full history of job reviews for the employee with id 2.
SELECT Employees.EmployeeID, firstname, lastname, ReviewText
FROM Employees
LEFT JOIN PerformanceReviews
ON Employees.EmployeeID = PerformanceReviews.EmployeeID
WHERE Employees.EmployeeID = 2;

-- Employee Salary Analysis: Find each employee's compensation + overtime payments and rank employees by total salary in descending order
SELECT Employees.EmployeeID, firstname, lastname, Cost, SalaryAmount , Cost + SalaryAmount AS total_salary
FROM Employees
LEFT JOIN EmployeeBenefits
ON Employees.EmployeeID = EmployeeBenefits.EmployeeID
LEFT JOIN Benefits
ON EmployeeBenefits.BenefitID = Benefits.BenefitID
LEFT JOIN Salaries
ON Employees.EmployeeID = Salaries.EmployeeID
ORDER BY total_salary DESC;
