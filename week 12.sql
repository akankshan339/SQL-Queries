-- Table: Patient
CREATE TABLE Patient (
    PatientID INT PRIMARY KEY,
    PatientName VARCHAR(11),
    Age INT,
    Gender CHAR(1),
    Address VARCHAR(10),
    ContactInfo VARCHAR(10),
    WardID INT,FOREIGN KEY (WardID) REFERENCES Ward(WardID),
    ConsultantID INT,FOREIGN KEY (ConsultantID) REFERENCES Consultant(ConsultantID)
);

-- Table: Ward
CREATE TABLE Ward (
    WardID INT PRIMARY KEY,
    Name VARCHAR(10)
);

-- Table: Consultant
CREATE TABLE Consultant (
    ConsultantID INT PRIMARY KEY,
    ConsultName VARCHAR(10),
    Specialisation VARCHAR(15),
    ContactInfo VARCHAR(10)
);

-- Table: Doctor
CREATE TABLE Doctor (
    DoctorID INT PRIMARY KEY,
    DoctName VARCHAR(100),
    Specialisation VARCHAR(15),
    ContactInfo VARCHAR(10)
);

-- Table: MedicalTest
CREATE TABLE MedicalTest (
    TestID INT PRIMARY KEY,
    TestName VARCHAR(100),
    TestDate DATE,
    Result VARCHAR(255),
    PatientID INT,
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);

-- Table: PatientDoctor (for Many-to-Many relationship between Patient and Doctor)
CREATE TABLE PatientDoctor (
    PatientID INT,
    DoctorID INT,
    PRIMARY KEY (PatientID, DoctorID),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID)
);

-- Inserting data into Ward
INSERT INTO Ward (WardID, Name) VALUES
(1, 'General'),
(2, 'Emergency'),
(3, 'Specific');

-- Inserting data into Consultant
INSERT INTO Consultant (ConsultantID, ConsultName, Specialisation, ContactInfo) VALUES
(1, 'Dr. Smith', 'Cardiology', '1234567890'),
(2, 'Dr. Jones', 'Neurology', '0987654321');

-- Inserting data into Doctor
INSERT INTO Doctor (DoctorID, DoctName, Specialisation, ContactInfo) VALUES
(1, 'Dr. Brown', 'Orthopedics', '1111111111'),
(2, 'Dr. Green', 'Dermatology', '2222222222');

-- Inserting data into Patient
INSERT INTO Patient (PatientID, PatientName, Age, Gender, Address, ContactInfo, WardID, ConsultantID) VALUES
(1, 'Alice', 25, 'F', 'Street 1', '5551112222', 1, 1),
(2, 'Bob', 40, 'M', 'Street 2', '5553334444', 2, 2);

-- Inserting data into MedicalTest
INSERT INTO MedicalTest (TestID, TestName, TestDate, Result, PatientID) VALUES
(1, 'X-Ray', '2024-12-01', 'Normal', 1),
(2, 'Blood Test', '2024-12-02', 'High Cholesterol', 2);

-- Inserting data into PatientDoctor
INSERT INTO PatientDoctor (PatientID, DoctorID) VALUES
(1, 1),
(1, 2),
(2, 1);

-- Queries

-- Query 1: Retrieve all patient details
SELECT * FROM Patient;

-- Query 2: List all wards and their details
SELECT * FROM Ward;

-- Query 3: Retrieve all consultants and their specialisations
SELECT ConsultName, Specialisation FROM Consultant;

-- Query 4: Fetch details of all doctors who treated a specific patient (e.g., PatientID = 1)
SELECT Doctor.DoctName, Doctor.Specialisation
FROM PatientDoctor
JOIN Doctor ON PatientDoctor.DoctorID = Doctor.DoctorID
WHERE PatientDoctor.PatientID = 1;

-- Query 5: Retrieve all medical tests conducted for a specific patient (e.g., PatientID = 2)
SELECT TestName, TestDate, Result
FROM MedicalTest
WHERE PatientID = 2;

-- Query 6: Find patients assigned to a specific consultant (e.g., ConsultantID = 1)
SELECT PatientName, Age, Gender
FROM Patient
WHERE ConsultantID = 1;

-- Query 7: List all doctors and the number of patients they have treated
SELECT Doctor.DoctName, COUNT(PatientDoctor.PatientID) AS PatientCount
FROM Doctor
LEFT JOIN PatientDoctor ON Doctor.DoctorID = PatientDoctor.DoctorID
GROUP BY Doctor.DoctName;

-- Query 8: Retrieve details of patients admitted to a specific ward (e.g., WardID = 1)
SELECT PatientName, Age, Gender
FROM Patient
WHERE WardID = 1;

-- Query 9: Find all patients who have undergone a specific test (e.g., TestName = 'X-Ray')
SELECT Patient.PatientName, Patient.Age, Patient.Gender
FROM MedicalTest
JOIN Patient ON MedicalTest.PatientID = Patient.PatientID
WHERE MedicalTest.TestName = 'X-Ray';

-- Query 10: List consultants along with the number of patients assigned to them
SELECT Consultant.ConsultName, COUNT(Patient.PatientID) AS PatientCount
FROM Consultant
LEFT JOIN Patient ON Consultant.ConsultantID = Patient.ConsultantID
GROUP BY Consultant.ConsultName;
