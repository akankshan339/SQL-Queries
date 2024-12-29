-- Q1. Create the Student table, Register table and Program table. Student table - ( Roll no. as primary key, Name as not null, city) 
--Program table - ( Program ID as primary key, Program Name as not null, Program Fee not less than 10000, Department) 
--Register table - ( Program ID and Roll no. as primary composite key)
-- Creating the Student table
CREATE TABLE Student (
    RollNo INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    City VARCHAR(50)
);

-- Creating the Program table
CREATE TABLE Program (
    ProgramID INT PRIMARY KEY,
    ProgramName VARCHAR(100) NOT NULL,
    ProgramFee DECIMAL(10, 2) CHECK (ProgramFee >= 10000),
    Department VARCHAR(50)
);

-- Creating the Register table
CREATE TABLE Register (
    ProgramID INT,
    RollNo INT,
    PRIMARY KEY (ProgramID, RollNo),
    FOREIGN KEY (ProgramID) REFERENCES Program(ProgramID),
    FOREIGN KEY (RollNo) REFERENCES Student(RollNo)
);

-- or
create table student(rollno number Primary Key, name varchar2(10) NOT NULL, city varchar2(10));
create table program(programid number Primary Key, Programname varchar2(10) NOT NULL, ProgrammeFee number check (ProgrammeFee >= 10000), Department varchar2(10));
create table register(programid number, rollno number, Primary Key(programid, rollno), FOREIGN KEY(programid) references program(programid), FOREIGN KEY(rollno) references student(rollno));

insert all
into student(rollno, name, city) values(11, 'Kiran', 'USA')
into student(rollno, name, city) values(12, 'Akanksha', 'Pauri')
into student(rollno, name, city) values(13, 'Gunjan', 'Kotdwar')
into student(rollno, name, city) values(14, 'Shikha', 'up')
into student(rollno, name, city) values(15, 'Swati', 'Bihar')
into student(rollno, name, city) values(16, 'Astha', 'Doon')
into student(rollno, name, city) values(17, 'Rajan', 'Roorkee')
into student(rollno, name, city) values(18, 'Amit', 'patna')
select* from dual;

insert all 
into program values(101, 'Btech', 190000, 'CS')
into program values(102, 'MCA', 80000, 'CS')
into program values(103, 'Bsc', 50000, 'Maths')
into program values(104, 'BBA', 45000, 'Commerce')
select* from dual;

insert all
into register values(104, 11)
into register values(102, 14)
into register values(101, 12)
into register values(104, 13)
into register values(102, 17)
into register values(101, 15)
into register values(103, 16)
into register values(102, 11)
select* from dual;

--Q2. Display the details of students who are registered in the "MCA" program.
select s.* from student s JOIN register r on s.rollno = r.rollno JOIN 
program p on r.programid = p.programid where p.Programname = 'MCA';
-- or
select* from student where rollno in(select r1.rollno from register r1 inner join 
program p1 on r1.programid = p1.programid where p1.Programname = 'MCA')

-- Q3. Display the list of all students, who are registered in at least one program.
select rollno, name from student where rollno in( select rollno from register);

-- or
SELECT DISTINCT s.rollno, s.name, s.city
FROM student s
JOIN register r ON s.rollno = r.rollno;


-- Q4. Display the details of programs that have fees greater than the average fee.
select* from program where programfee > (select avg(programfee) from program);
SELECT * FROM program WHERE programme_fee > (SELECT AVG(programme_fee) FROM program);

-- select name from student where ProgrammeFee > (select avg(ProgrammeFee) from program);

-- Q5. Display the names of students who are registered in a program having fees less than 30000.
select name from student s inner join register r on s.rollno = r.rollno where r.programid in(select programid from program where programfee < 30000)

-- Q6. Display the details of students who have not registered in any course.
select* from student where rollno not in(select rollno from register);

-- Q7. Display the names of programs in which a maximum number of students are registered.
--select Programname from program where programid in (select programid from register GROUP BY programid having count(*) = (select max(program)))


SELECT programname
FROM program
WHERE programid IN (
    SELECT programid
    FROM register
    GROUP BY programid
    HAVING COUNT(*) = (
        SELECT MAX(student_count)
        FROM (
            SELECT programid, COUNT(*) AS student_count
            FROM register
            GROUP BY programid
        ) subquery
    )
);


--Q8. Display the names of programs in which a minimum number of students are registered.

SELECT programname
FROM program
WHERE programid IN (
    SELECT programid
    FROM register
    GROUP BY programid
    HAVING COUNT(*) = (
        SELECT MIN(student_count)
        FROM (
            SELECT programid, COUNT(*) AS student_count
            FROM register
            GROUP BY programid
        ) subquery
    )
);







