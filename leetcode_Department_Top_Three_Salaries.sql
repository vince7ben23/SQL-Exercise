-- ## leetcode_Department_Top_Three_Salaries
--    Write a SQL query to find employees who earn the top three salaries in each of the department. 




Create table  Employee (Id int, Name varchar(255), Salary int, DepartmentId int);
insert into Employee (Id, Name, Salary, DepartmentId) values ('1', 'Joe', '85000', '1');
insert into Employee (Id, Name, Salary, DepartmentId) values ('2', 'Henry', '80000', '2');
insert into Employee (Id, Name, Salary, DepartmentId) values ('3', 'Sam', '60000', '2');
insert into Employee (Id, Name, Salary, DepartmentId) values ('4', 'Max', '90000', '1');
insert into Employee (Id, Name, Salary, DepartmentId) values ('5', 'Janet', '69000', '1');
insert into Employee (Id, Name, Salary, DepartmentId) values ('6', 'Randy', '85000', '1');
insert into Employee (Id, Name, Salary, DepartmentId) values ('7', 'Will', '70000', '1');

Create table  Department (Id int, Name varchar(255));
insert into Department (Id, Name) values ('1', 'IT');
insert into Department (Id, Name) values ('2', 'Sales');




-- ##Method 1. Use subquery
SELECT Department.Name AS Department, a.Name AS Employee, a.Salary AS Salary
FROM Employee AS a
JOIN Department 
ON a.DepartmentId = Department.Id
WHERE 3 >   (
                SELECT COUNT(DISTINCT(b.Salary))
                FROM Employee AS b
                WHERE b.DepartmentId = a.DepartmentId
                AND b.Salary > a.Salary
            )
ORDER BY Department.Name, a.Salary DESC


-- ##Method 2. Use Join 
SELECT d.Name AS Department, a.name AS Employee, a.Salary AS Salary
FROM employee AS a
JOIN employee AS b
ON a.salary <= b.salary AND a.departmentid = b.departmentid
JOIN department AS d
ON a.departmentid = d.id
GROUP BY a.name, a.departmentid, a.Salary, d.Name
HAVING COUNT(DISTINCT(b.Salary)) <=3
ORDER BY Department, Salary DESC


-- ##Method 3. Use DENSE_RANK
SELECT b.Department, b.Employee, b.Salary FROM
    (
        SELECT Department.Name AS Department, a.Name AS Employee, a.Salary AS Salary,
        DENSE_RANK() OVER (PARTITION BY a.DepartmentId ORDER BY a.Salary DESC) AS Rank
        FROM Employee AS a
        JOIN Department
        ON a.DepartmentId  = Department.Id
    ) AS b
WHERE b.Rank <=3
ORDER BY b.Department, b.Salary DESC