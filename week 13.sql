CREATE TABLE Department1 (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100),
    ManagerID INT,
    Location VARCHAR(100),
    FOREIGN KEY (ManagerID) REFERENCES Employee5(EmployeeID)
);


CREATE TABLE Employee5 (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(100),
    BirthDate DATE,
    Address VARCHAR(255),
    Gender CHAR(1),
    Salary DECIMAL(10, 2),
    DepartmentID INT,
    SupervisorID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Department1(DepartmentID),
    FOREIGN KEY (SupervisorID) REFERENCES Employee5(EmployeeID)
);


CREATE TABLE Project (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100),
    Location VARCHAR(100),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Department1(DepartmentID)
);


CREATE TABLE Works_On (
    EmployeeID INT,
    ProjectID INT,
    HoursWorked DECIMAL(10, 2),
    PRIMARY KEY (EmployeeID, ProjectID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee5(EmployeeID),
    FOREIGN KEY (ProjectID) REFERENCES Project(ProjectID)
);


INSERT INTO Department1 (DepartmentID, DepartmentName, ManagerID, Location) VALUES
    (1, 'IT', 101, 'New York'),
    (2, 'HR', 102, 'Chicago'),
    (3, 'Finance', 103, 'San Francisco');


INSERT INTO Employee5 (EmployeeID, Name, BirthDate, Address, Gender, Salary, DepartmentID, SupervisorID) VALUES
    (101, 'Alice', '1985-04-23', '123 Main St, New York', 'F', 80000, 1, NULL), -- Manager of IT
    (102, 'Bob', '1978-12-11', '456 Elm St, Chicago', 'M', 75000, 2, NULL), -- Manager of HR
    (103, 'Charlie', '1980-07-15', '789 Pine St, San Francisco', 'M', 90000, 3, NULL), -- Manager of Finance
    (104, 'David', '1990-01-05', '321 Oak St, New York', 'M', 60000, 1, 101), -- Employee in IT, supervised by Alice
    (105, 'Eve', '1992-05-18', '654 Maple St, Chicago', 'F', 55000, 2, 102), -- Employee in HR, supervised by Bob
    (106, 'Frank', '1988-11-25', '987 Birch St, San Francisco', 'M', 50000, 3, 103), -- Employee in Finance, supervised by Charlie
    (107, 'Grace', '1995-03-09', '147 Cedar St, New York', 'F', 45000, 1, 101); -- Employee in IT, supervised by Alice


INSERT INTO Project (ProjectID, ProjectName, Location, DepartmentID) VALUES
    (201, 'Project A', 'New York', 1), -- Managed by IT
    (202, 'Project B', 'Chicago', 2), -- Managed by HR
    (203, 'Project C', 'San Francisco', 3); -- Managed by Finance


INSERT INTO Works_On (EmployeeID, ProjectID, HoursWorked) VALUES
    (101, 201, 40), -- Alice working on Project A
    (104, 201, 35), -- David working on Project A
    (107, 201, 30), -- Grace working on Project A
    (102, 202, 20), -- Bob working on Project B
    (105, 202, 25), -- Eve working on Project B
    (103, 203, 50), -- Charlie working on Project C
    (106, 203, 45); -- Frank working on Project C

