-- Database: Company 

-- DROP DATABASE "Company ";

CREATE DATABASE "Company "
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_India.1252'
    LC_CTYPE = 'English_India.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;
	
----------------------------------Crating Comapny's Data Base---------------------------------------------
---Creating employ table

Create Table employee(
emp_id INT Primary key,
first_name Varchar (40),
last_name Varchar (40),
birth_day Date,
sex Varchar(1),
salary Int,
super_id Int,
branch_id Int);



---Creating Branch table

Create Table branch(
branch_id Int Primary Key,
branch_name Varchar (30),
mgr_id Int,
mgr_start_date Date,
Foreign Key (mgr_id) References employee(emp_id) on Delete set NULL );

--now we set super_id as foregin Key

Alter Table employee
Add Foreign Key (super_id)
References employee(emp_id)
On Delete Set NULL;

--now we set branch_id as foregin Key

Alter Table employee
Add Foreign Key (branch_id)
References branch(branch_id)
On Delete Set NULl;

--creating Table client 
CREATE TABLE client (
  client_id INT PRIMARY KEY,
  client_name VARCHAR(40),
  branch_id INT,
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL
);

--creating Table works_with 

CREATE TABLE works_with (
  emp_id INT,
  client_id INT,
  total_sales INT,
  PRIMARY KEY(emp_id, client_id),
  FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
  FOREIGN KEY(client_id) REFERENCES client(client_id) ON DELETE CASCADE
);

--creating table branch_supplier 
CREATE TABLE branch_supplier (
  branch_id INT,
  supplier_name VARCHAR(40),
  supply_type VARCHAR(40),
  PRIMARY KEY(branch_id, supplier_name),
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
);


--adding Values of Corporate branch employees

Insert Into employee Values(
	100, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL, NULL);

Insert Into branch Values( 
	1,'Corporate',100,'2006-02-09');
	
UPDATE employee
SET branch_id = 1
WHERE emp_id = 100;

INSERT INTO employee VALUES(101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);


--Deleing tables
DROP TABLE branch_supplier;
DROP TABLE works_with;
DROP TABLE client;
DROP TABLE employee Cascade;
DROP TABLE branch Cascade;

--adding values of Scranton branch employee

Insert Into employee Values(102, 'Michael', 'Scott', '1964-03-15','M', 75000,100,Null );


INSERT INTO branch VALUES(2, 'Scranton', 102, '1992-04-06');
UPDATE employee
SET branch_id = 2
WHERE emp_id = 102;

INSERT INTO employee VALUES(103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2);
INSERT INTO employee VALUES(104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2);
INSERT INTO employee VALUES(105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2);


--adding values of Stamford branch employee
INSERT INTO employee VALUES(106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, Null);

INSERT INTO branch VALUES(3, 'Stamford', 106, '1998-02-13');
UPDATE employee
SET branch_id = 3
WHERE emp_id = 106;
INSERT INTO employee VALUES(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
INSERT INTO employee VALUES(108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);


--adding values on branch suppliers
INSERT INTO branch_supplier VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'J.T. Forms & Labels', 'Custom Forms');
INSERT INTO branch_supplier VALUES(3, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(3, 'Stamford Lables', 'Custom Forms');

--adding values on client 
INSERT INTO client VALUES(400, 'Dunmore Highschool', 2);
INSERT INTO client VALUES(401, 'Lackawana Country', 2);
INSERT INTO client VALUES(402, 'FedEx', 3);
INSERT INTO client VALUES(403, 'John Daly Law, LLC', 3);
INSERT INTO client VALUES(404, 'Scranton Whitepages', 2);
INSERT INTO client VALUES(405, 'Times Newspaper', 3);
INSERT INTO client VALUES(406, 'FedEx', 2);


---adding values on WORKS_WITH
INSERT INTO works_with VALUES(105, 400, 55000);
INSERT INTO works_with VALUES(102, 401, 267000);
INSERT INTO works_with VALUES(108, 402, 22500);
INSERT INTO works_with VALUES(107, 403, 5000);
INSERT INTO works_with VALUES(108, 403, 12000);
INSERT INTO works_with VALUES(105, 404, 33000);
INSERT INTO works_with VALUES(107, 405, 26000);
INSERT INTO works_with VALUES(102, 406, 15000);
INSERT INTO works_with VALUES(105, 406, 130000);

---------------------------------------------------Some Basic quaries----------------------------------------------------- 

Select *
from  employee;

Select * from employee
where sex='F';

-- Find all clients
Select * from client;

-- Find all employees ordered by salary

Select * from employee 
Order by salary ASC;

Select * from employee 
Order by salary DESC;

-- Find all employees ordered by sex then name

Select * from employee 
Order By Sex ,first_name;

-- Find the first 5 employees in the table
Select * from employee
limit 5;

-- Find the first and last names of all employees
Select first_name,last_name
from employee;

-- Find the forename and surnames names of all employees
Select first_name As Forename,last_name As Surname
from employee;

-- Find out all the different genders
Select Distinct sex
From employee;

-- Find all employees at branch 2
Select * From employee
where branch_id=2;

-- Find all employees at branch 2 and Sex is male
Select * From employee 
where branch_id=2 and sex='M';

-- Find all employee's id's and names who were born after 1969
Select * From employee 
where birth_day >='1970-01-01';


-- Find all employees who are female & born after 1969 or who make over 80000
Select * From employee 
where (sex='F' and birth_day>='1970-01-01') OR salary>=80000;

-----------------------------Functions-------------------

-- Find the number of employees
Select Count (emp_id)
From employee;

-- Find the average of all employee's salaries
Select AVG(salary)
from employee;

-- Find the sum of all employee's salaries
Select Sum(salary)
from employee;

-- Find out how many males and females there are
Select count(Sex),sex
from employee
Group By sex;

-- Find the total sales of each salesman
SELECT SUM(total_sales)
FROM works_with
GROUP BY client_id;


-- Find the total amount of money spent by each client
SELECT SUM(total_sales), client_id
FROM works_with
GROUP BY client_id;

----------------------------------------------Wild Card----------------------------

-- % = any # characters, _ = one character


-- Find any client's who are an LLC
select * from client 
where client_name Like '%LLC';            ---(here % mean any thing before LLC)

-- Find any branch suppliers who are in the label business
Select * from branch_supplier 
where supplier_name Like '%Lable%';  ---(here % % means word lable anywhere in sentance)

-------------------------------------Joints----------------------
-- Add the extra branch
INSERT INTO branch VALUES(4, 'Buffalo', NULL, NULL);

SELECT employee.emp_id, employee.first_name, branch.branch_name
FROM employee
JOIN branch  
ON employee.emp_id = branch.mgr_id;

---Left joint

SELECT employee.emp_id, employee.first_name, branch.branch_name
FROM employee
Left JOIN branch  
ON employee.emp_id = branch.mgr_id;

----right Joint
SELECT employee.emp_id, employee.first_name, branch.branch_name
FROM employee
Right JOIN branch  
ON employee.emp_id = branch.mgr_id;


----------------------------------------------Subquaries(Nested quary)-----------------------------------------------------
-- Find names of all employees who have sold over 50,000

Select employee.first_name,employee.last_name
From employee 
Where employee.emp_id In
                        (Select works_with.emp_id
						 From works_with
						 Where works_with.Total_sales>=50000);


-- Find all clients who are handles by the branch that Michael Scott manages
-- Assume you know Michael's ID

Select client.client_id ,client.client_name
From client
Where Client.branch_id In(
                          Select branch.branch_id
                          From Branch Where branch.mgr_id=102);
						  
-- Find all clients who are handles by the branch that Michael Scott manages
 -- Assume you DONT'T know Michael's ID
SELECT client.client_id, client.client_name
FROM client
WHERE client.branch_id =(Select branch.branch_id
                          From branch Where branch.mgr_id=(Select employee.emp_id
                                                           From employee 
	                                                       Where employee.first_name='Michael' 
														   And employee.last_name='Scott'
														   Limit 1));
												
-- Find the names of employees who work with clients handled by the scranton branch
SELECT employee.first_name, employee.last_name
FROM employee
WHERE employee.emp_id IN (
                         SELECT works_with.emp_id
                         FROM works_with
                         )
AND employee.branch_id = 2;



-- Find the names of all clients who have spent more than 100,000 dollars
SELECT client.client_name
FROM client
WHERE client.client_id IN (
                          SELECT client_id
                          FROM (
                                SELECT SUM(works_with.total_sales) AS totals, client_id
                                FROM works_with
                                GROUP BY client_id) AS total_client_sales
                          WHERE totals > 100000
);
