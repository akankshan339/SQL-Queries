-- Create the Trainees table
CREATE TABLE Trainees (
    Trainee_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Address VARCHAR(255),
    Program_ID INT,
    Performance VARCHAR(50)
);

-- Create the Programs table
CREATE TABLE Programs (
    Program_ID INT PRIMARY KEY,
    Program_Name VARCHAR(100)
);

-- Create the Courses table
CREATE TABLE Courses (
    Course_Code INT PRIMARY KEY,
    Title VARCHAR(100),
    Credit_Hours INT,
    Prerequisites INT,
    Instructor_ID INT,
    Department VARCHAR(100),
    FOREIGN KEY (Prerequisites) REFERENCES Courses(Course_Code)
);

-- Create the Instructors table
CREATE TABLE Instructors (
    Instructor_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Department VARCHAR(100)
);

-- Create the Teaching Assistants table
CREATE TABLE Teaching_Assistants (
    TA_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Department VARCHAR(100)
);

-- Create the Enrollments table to track trainees' courses and grades
CREATE TABLE Enrollments (
    Trainee_ID INT,
    Course_Code INT,
    Grade VARCHAR(10),
    PRIMARY KEY (Trainee_ID, Course_Code),
    FOREIGN KEY (Trainee_ID) REFERENCES Trainees(Trainee_ID),
    FOREIGN KEY (Course_Code) REFERENCES Courses(Course_Code)
);

INSERT all
--INTO Trainees (Trainee_ID, Name, Address, Program_ID, Performance) VALUES
INTO Trainees values(1, 'John Doe', '123 Main St, City', 101, 'Excellent')
INTO Trainees values(2, 'Jane Smith', '456 Oak Rd, City', 102, 'Good')
INTO Trainees values(3, 'Sam Brown', '789 Pine Ave, City', 101, 'Average')
INTO Trainees values(4, 'Lucy Green', '101 Maple Dr, City', 103, 'Excellent')
select* from dual;

INSERT all
--INTO Programs (Program_ID, Program_Name) VALUES
INTO Programs values(101, 'Java Developer')
INTO Programs values(102, 'Full Stack Developer')
INTO Programs values(103, 'Data Scientist')
select* from dual;

insert all
--INSERT INTO Courses (Course_Code, Title, Credit_Hours, Prerequisites, Instructor_ID, Department) VALUES
INTO Courses values(1001, 'Java Basics', 4, NULL, 1, 'Software Engineering')
INTO Courses values(1002, 'Advanced Java', 3, 1001, 1, 'Software Engineering')
INTO Courses values(1003, 'Full Stack Development', 5, NULL, 2, 'Web Development')
INTO Courses values(1004, 'Data Analysis with Python', 4, NULL, 3, 'Data Science')
INTO Courses values(1005, 'Machine Learning', 3, 1004, 3, 'Data Science')
select* from dual;

insert all
--INSERT INTO Instructors (Instructor_ID, Name, Department) VALUES
INTO Instructors values(1, 'Dr. Michael Scott', 'Software Engineering')
INTO Instructors values(2, 'Prof. Emma White', 'Web Development')
INTO Instructors values(3, 'Dr. Daniel Black', 'Data Science')
select* from dual;

insert all
--INSERT INTO Teaching_Assistants (TA_ID, Name, Department) VALUES
INTO Teaching_Assistants values(1, 'Chris Harris', 'Software Engineering')
INTO Teaching_Assistants values(2, 'Amanda Blue', 'Web Development')
INTO Teaching_Assistants values(3, 'David Green', 'Data Science')
select* from dual;

insert all
--INSERT INTO Enrollments (Trainee_ID, Course_Code, Grade) VALUES
INTO Enrollments values(1, 1001, 'A')
INTO Enrollments values(1, 1002, 'B')
INTO Enrollments values(2, 1003, 'A')
INTO Enrollments values(3, 1001, 'B')
INTO Enrollments values(3, 1003, 'C')
INTO Enrollments values(4, 1004, 'A')
INTO Enrollments values(4, 1005, 'B')
select* from dual;

--Question1. Write an SQL query to show the names and IDs of trainees who have completed all the required courses for their program.
SELECT T.Trainee_ID, T.Name
FROM Trainees T
WHERE NOT EXISTS (
    SELECT C.Course_Code
    FROM Courses C
    WHERE C.Program_ID = T.Program_ID 
      AND C.Mandatory = 'Yes'
      AND C.Course_Code NOT IN (
          SELECT E.Course_Code
          FROM Enrollments E
          WHERE E.Trainee_ID = T.Trainee_ID AND E.Grade IS NOT NULL)
);

SELECT T.Trainee_ID, T.Name
FROM Trainees T
WHERE NOT EXISTS (
    SELECT C.Course_Code
    FROM Courses C
    WHERE C.Program_ID = T.Program_ID 
      AND C.Course_Code NOT IN (
          SELECT E.Course_Code
          FROM Enrollments E
          WHERE E.Trainee_ID = T.Trainee_ID AND E.Grade IS NOT NULL
      )
);


