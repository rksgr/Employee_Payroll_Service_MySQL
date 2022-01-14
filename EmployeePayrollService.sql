USE CASE 1: Create a payroll_service database


mysql> show databases
    -> ;
+----------------------+
| Database             |
+----------------------+
| address_book_service |
| db_emp               |
| db_emp_am            |
| information_schema   |
| mysql                |
| performance_schema   |
+----------------------+
6 rows in set (0.00 sec)

mysql> CREATE DATABASE payroll_service;
Query OK, 1 row affected (0.02 sec)

mysql> SHOW DATABASES;
+----------------------+
| Database             |
+----------------------+
| address_book_service |
| db_emp               |
| db_emp_am            |
| information_schema   |
| mysql                |
| payroll_service      |
| performance_schema   |
+----------------------+
7 rows in set (0.00 sec)

mysql> USE payroll_service;
Database changed


USE CASE 2: Create employee payroll table in payroll service database


mysql> CREATE TABLE employee_payroll(emp_id int PRIMARY KEY auto_increment,name VARCHAR(50) NOT NULL,salary double, start_date DATE NOT NULL);
Query OK, 0 rows affected (0.04 sec)

mysql> DESC employee_payroll;
+------------+-------------+------+-----+---------+----------------+
| Field      | Type        | Null | Key | Default | Extra          |
+------------+-------------+------+-----+---------+----------------+
| emp_id     | int         | NO   | PRI | NULL    | auto_increment |
| name       | varchar(50) | NO   |     | NULL    |                |
| salary     | double      | YES  |     | NULL    |                |
| start_date | date        | NO   |     | NULL    |                |
+------------+-------------+------+-----+---------+----------------+
4 rows in set (0.04 sec)


USE CASE 3: Create Employee payroll data as part of CRUD operation in payroll service database


mysql> INSERT INTO employee_payroll(name, salary, start_date) VALUES("ramesh",55000,'2021-10-10');
Query OK, 1 row affected (0.04 sec)

mysql> INSERT INTO employee_payroll(name,salary,start_date) VALUES("mukesh",56000,'2021-10-9');
Query OK, 1 row affected (0.04 sec)

mysql> INSERT INTO employee_payroll(name,salary,start_date) VALUES("ritesh",72000,'2021-10-8');
Query OK, 1 row affected (0.01 sec)


USE CASE 4: Retrieve the data inserted into the database


mysql> SELECT * FROM employee_payroll;
+--------+--------+--------+------------+
| emp_id | name   | salary | start_date |
+--------+--------+--------+------------+
|      1 | ramesh |  55000 | 2021-10-10 |
|      2 | mukesh |  56000 | 2021-10-09 |
|      3 | ritesh |  72000 | 2021-10-08 |
+--------+--------+--------+------------+
3 rows in set (0.00 sec)


USE CASE 5: Retrieve salary data for a particular employee as well as all employees who have joined in a particular
            date range


mysql> SELECT * FROM employee_payroll WHERE start_date BETWEEN '2021-10-09' AND '2021-10-10';
+--------+--------+--------+------------+
| emp_id | name   | salary | start_date |
+--------+--------+--------+------------+
|      1 | ramesh |  55000 | 2021-10-10 |
|      2 | mukesh |  56000 | 2021-10-09 |
+--------+--------+--------+------------+
2 rows in set (0.00 sec)

mysql> SELECT salary FROM employee_payroll WHERE start_date BETWEEN '2021-10-09' AND '2021-10-10';
+--------+
| salary |
+--------+
|  55000 |
|  56000 |
+--------+
2 rows in set (0.00 sec)

mysql> SELECT salary FROM employee_payroll WHERE name="ritesh";
+--------+
| salary |
+--------+
|  72000 |
+--------+
1 row in set (0.00 sec)

mysql> SELECT salary FROM employee_payroll WHERE name="Ritesh";
+--------+
| salary |
+--------+
|  72000 |
+--------+
1 row in set (0.00 sec)


USE CASE 6: Add gender to employee payroll table



mysql> ALTER TABLE employee_payroll ADD gender VARCHAR(25) ;
Query OK, 0 rows affected (0.03 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> DESC employee_payroll;
+------------+-------------+------+-----+---------+----------------+
| Field      | Type        | Null | Key | Default | Extra          |
+------------+-------------+------+-----+---------+----------------+
| emp_id     | int         | NO   | PRI | NULL    | auto_increment |
| name       | varchar(50) | NO   |     | NULL    |                |
| salary     | double      | YES  |     | NULL    |                |
| start_date | date        | NO   |     | NULL    |                |
| gender     | varchar(25) | YES  |     | NULL    |                |
+------------+-------------+------+-----+---------+----------------+
5 rows in set (0.01 sec)

mysql> SELECT * FROM employee_payroll;
+--------+--------+--------+------------+--------+
| emp_id | name   | salary | start_date | gender |
+--------+--------+--------+------------+--------+
|      1 | ramesh |  55000 | 2021-10-10 | NULL   |
|      2 | mukesh |  56000 | 2021-10-09 | NULL   |
|      3 | ritesh |  72000 | 2021-10-08 | NULL   |
+--------+--------+--------+------------+--------+
3 rows in set (0.01 sec)

-- Gender set as male for all the employees as all the employees as all the employees are male
mysql> UPDATE employee_payroll SET gender="male";
Query OK, 3 rows affected (0.04 sec)
Rows matched: 3  Changed: 3  Warnings: 0

mysql> SELECT * FROM employee_payroll;
+--------+--------+--------+------------+--------+
| emp_id | name   | salary | start_date | gender |
+--------+--------+--------+------------+--------+
|      1 | ramesh |  55000 | 2021-10-10 | male   |
|      2 | mukesh |  56000 | 2021-10-09 | male   |
|      3 | ritesh |  72000 | 2021-10-08 | male   |
+--------+--------+--------+------------+--------+
3 rows in set (0.01 sec)


USE CASE 7: Find Sum, average, minimum and maximum and number of male and female employees

-- Get the sum of salaries of female employees
mysql> SELECT SUM(salary) FROM employee_payroll WHERE gender="female" GROUP BY gender;
+-------------+
| SUM(salary) |
+-------------+
|      210000 |
+-------------+
1 row in set (0.00 sec)

-- Get the sum of salaries of male employees
mysql> SELECT SUM(salary) FROM employee_payroll WHERE gender="male" GROUP BY gender;
+-------------+
| SUM(salary) |
+-------------+
|      334000 |
+-------------+
1 row in set (0.00 sec)

-- Get the average salary of female employee
mysql> SELECT AVG(salary) FROM employee_payroll WHERE gender="female" GROUP BY gender;
      +-------------+
      | AVG(salary) |
      +-------------+
      |       52500 |
      +-------------+
      1 row in set (0.01 sec)

-- Get the average salary of male employee
mysql> SELECT AVG(salary) FROM employee_payroll WHERE gender="male" GROUP BY gender;
      +-------------+
      | AVG(salary) |
      +-------------+
      |       66800 |
      +-------------+
      1 row in set (0.00 sec)

-- Get the minimum salary of male employee
mysql> SELECT MIN(salary) FROM employee_payroll WHERE gender="male" GROUP BY gender;
+-------------+
| MIN(salary) |
+-------------+
|       55000 |
+-------------+
1 row in set (0.00 sec)

-- Get the minimum salary of female employee
mysql> SELECT MIN(salary) FROM employee_payroll WHERE gender="female" GROUP BY gender;
+-------------+
| MIN(salary) |
+-------------+
|       32000 |
+-------------+
1 row in set (0.00 sec)

-- get the maximum salary of female employee
mysql> SELECT MAX(salary) FROM employee_payroll WHERE gender="female" GROUP BY gender;
+-------------+
| MAX(salary) |
+-------------+
|       64000 |
+-------------+
1 row in set (0.00 sec)

-- Get the maximum salary of male employee
mysql> SELECT MAX(salary) FROM employee_payroll WHERE gender="male" GROUP BY gender;
+-------------+
| MAX(salary) |
+-------------+
|       77000 |
+-------------+
1 row in set (0.00 sec)

-- count the number of male employees
mysql> SELECT COUNT(*) FROM employee_payroll WHERE gender="male" GROUP BY gender;
+----------+
| COUNT(*) |
+----------+
|        5 |
+----------+
1 row in set (0.00 sec)

-- count the number of female employees
mysql> SELECT COUNT(*) FROM employee_payroll WHERE gender="female" GROUP BY gender;
+----------+
| COUNT(*) |
+----------+
|        4 |
+----------+
1 row in set (0.00 sec)


USE CASE 8: Extend employee_payroll data to store employee information like employee phone, address and department



mysql> ALTER TABLE employee_payroll ADD emp_phone double;
Query OK, 0 rows affected (0.04 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE employee_payroll ADD emp_addr ;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '' at line 1
mysql> ALTER TABLE employee_payroll ADD emp_addr VARCHAR(200);
Query OK, 0 rows affected (0.06 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE employee_payroll ADD emp_deptt VARCHAR(50)  DEFAULT "engineering" NOT NULL;
Query OK, 0 rows affected (0.06 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> DESC employee_payroll;
+------------+--------------+------+-----+-------------+----------------+
| Field      | Type         | Null | Key | Default     | Extra          |
+------------+--------------+------+-----+-------------+----------------+
| emp_id     | int          | NO   | PRI | NULL        | auto_increment |
| name       | varchar(50)  | NO   |     | NULL        |                |
| salary     | double       | YES  |     | NULL        |                |
| start_date | date         | NO   |     | NULL        |                |
| gender     | varchar(25)  | YES  |     | NULL        |                |
| emp_phone  | double       | YES  |     | NULL        |                |
| emp_addr   | varchar(200) | YES  |     | NULL        |                |
| emp_deptt  | varchar(50)  | NO   |     | engineering |                |
+------------+--------------+------+-----+-------------+----------------+
8 rows in set (0.04 sec)


USE CASE 9: Extend employee_payroll table to have basic pay, deductions, taxable pay,
                income tax, net pay.


mysql> ALTER TABLE employee_payroll ADD basic_pay double;
Query OK, 0 rows affected (0.02 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE employee_payroll ADD deductions double;
Query OK, 0 rows affected (0.02 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE employee_payroll ADD taxable_pay DOUBLE;
Query OK, 0 rows affected (0.03 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE employee_payroll ADD income_tax DOUBLE;
Query OK, 0 rows affected (0.02 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE employee_payroll ADD net_pay DOUBLE;
Query OK, 0 rows affected (0.03 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> DESC employee_payroll;
+-------------+--------------+------+-----+-------------+----------------+
| Field       | Type         | Null | Key | Default     | Extra          |
+-------------+--------------+------+-----+-------------+----------------+
| emp_id      | int          | NO   | PRI | NULL        | auto_increment |
| name        | varchar(50)  | NO   |     | NULL        |                |
| salary      | double       | YES  |     | NULL        |                |
| start_date  | date         | NO   |     | NULL        |                |
| gender      | varchar(25)  | YES  |     | NULL        |                |
| emp_phone   | double       | YES  |     | NULL        |                |
| emp_addr    | varchar(200) | YES  |     | NULL        |                |
| emp_deptt   | varchar(50)  | NO   |     | engineering |                |
| basic_pay   | double       | YES  |     | NULL        |                |
| deductions  | double       | YES  |     | NULL        |                |
| taxable_pay | double       | YES  |     | NULL        |                |
| income_tax  | double       | YES  |     | NULL        |                |
| net_pay     | double       | YES  |     | NULL        |                |
+-------------+--------------+------+-----+-------------+----------------+
13 rows in set (0.02 sec)

