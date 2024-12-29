create table department(deptid INT PRIMARY KEY, deptname varchar2(8));

create table employee3(empid int primary key, empname varchar2(10), emp_age int, sal int, deptid int, Foreign Key (deptid) references department (deptid));

insert all
into department(deptid, deptname) values(101, 'CSE')
into department(deptid, deptname) values(102, 'HR')
into department(deptid, deptname) values(103, 'IT')
select* from dual;

select* from department

insert all
into employee3 values(1, 'Akanksha', 21, 80000, 102)
into employee3 values(2, 'Kiran', 22, 100000, 101)
into employee3 values(3, 'Gunjan', 20, 50000, 101)
into employee3 values(4, 'Shikha', 23, 60000, 102)
into employee3 values(5, 'Ayush', 25, 40000, 103)
into employee3 values(6, 'Swati', 22, 70000, 103)
into employee3 values(7, 'Astha', 24, 65000, 101)
select* from dual;

select* from employee3

--	Find out the second minimum salary of an employee.
SELECT MIN(salary) AS second_min_salary
FROM employee
WHERE salary > (SELECT MIN(salary) FROM employee);
-- or
SELECT sal AS "second_min_sal"
FROM (
    SELECT sal, DENSE_RANK() OVER (ORDER BY sal ASC) AS RANKING
    FROM employee3
) 
WHERE RANKING = 2;



--	Find out the second minimum salary of an employee without using limit, dense range, and order by clause.
SELECT MIN(salary) AS second_min_salary
FROM employee
WHERE salary > (SELECT MIN(salary) FROM employee);
--or
select MIN(sal) as "second_min_sal" from employee3 where sal NOT IN (select MIN(sal) from employee3);

--	Find out the third maximum salary of an employee. 
select sal as "third_max_salary" from (select sal, DENSE_RANK() OVER  (ORDER BY sal DESC) RANKING from employee3) where RANKING = 3;
--	Find out the third maximum salary of an employee without using limit, dense range, and order by clause. 

 select MAX(sal) as "Third_max_sal" from employee3
    where sal < (select MAX(sal) from employee3 where sal < (select MAX(sal) from employee3));
--	Display the names and salaries of employees who earn more than the average salary of their department. 
select empname, sal, deptid from employee3 e
  2  where sal > ( select AVG(sal) from employee3 where deptid = e.deptid);
  -- or 
  select empname, sal, deptid from employee3 
  2  where sal > ( select AVG(sal) from employee3 where deptid = deptid);

--	Fetch the list of the employee who belongs to the same department but earns less than the second employee.
SELECT empname, sal, deptid
FROM employee3 e1
WHERE sal < (
    SELECT DISTINCT sal
    FROM (
        SELECT sal
        FROM employee3 e2
        WHERE e2.deptid = e1.deptid
        ORDER BY sal DESC
    ) WHERE ROWNUM = 2
);
--or
SELECT emp_name
FROM employee3 e1
WHERE sal < (
    SELECT sal
    FROM (
        SELECT sal, DENSE_RANK() OVER (PARTITION BY dept_id ORDER BY sal DESC) AS RANKING
        FROM employee3
    )
    WHERE RANKING = 2
      AND dept_id = e1.dept_id
);


--Fetch the list of the employee who earns less than the second employee.
select empname from employee3 where sal < (select sal from (select sal, DENSE_RANK() OVER (ORDER BY sal DESC)
  2  RANKING from employee3 ) where RANKING =2);

--	Display the names of employees who are older than their colleagues in the same department.


 select e1.empname from employee3 e1 where e1.emp_age > ALL(select e2.emp_age
from Employee3 e2
  2  where e1.deptid = e2.deptid AND e1.empid != e2.empid);

-- or using self join
  SELECT e1.emp_name
FROM employee3 e1
WHERE e1.age > (
    SELECT e2.age
    FROM employee3 e2
    WHERE e2.dept_id = e1.dept_id
      AND e2.emp_id != e1.emp_id
);





