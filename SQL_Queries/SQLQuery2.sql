USE Fitness_Center;
Go


CREATE TABLE Instructors (
    InstructorID INT PRIMARY KEY,
    Fname VARCHAR(50),
    Lname VARCHAR(50),
    Specialization VARCHAR(100),
    Email VARCHAR(100),
	Salary Int,
);

ALTER TABLE Instructors ADD contract_type VARCHAR(100);


INSERT INTO Instructors (InstructorID, Fname, Lname, Specialization, Email, Salary, contract_type)
VALUES 
(1, 'Sarah', 'Johnson', 'Yoga and Meditation', 'sarah.j@fitness.com', 5200, 'Full-time'),
(2, 'Michael', 'Brown', 'Weight Training', 'michael.b@fitness.com', 4800, 'Full-time');

TRUNCATE TABLE Instructors;

DROP TABLE Instructors;

CREATE TABLE Instructor (
    InstructorID INT PRIMARY KEY,
    Fname VARCHAR(50),
    Lname VARCHAR(50),
    Specialization VARCHAR(100),
    Email VARCHAR(100),
	Salary Int,
	contract_type VARCHAR(100)
);



CREATE TABLE InstructorPhone (
    PhoneNum Bigint,
    InstructorID INT,
    PRIMARY KEY (PhoneNum),
    FOREIGN KEY (InstructorID) REFERENCES Instructor(InstructorID) on delete Set null
);

CREATE TABLE Class (
    ClassID INT PRIMARY KEY,
    ClassName VARCHAR(100),
    Duration INT,
    Time DATETIME,
    MaxParticipant INT,
    InstructorID INT,
    FOREIGN KEY (InstructorID) REFERENCES Instructor(InstructorID) on delete set null
);

CREATE TABLE Schedule (
    ScheduleID INT PRIMARY KEY,
    location VARCHAR(100),
    start_date_time DATETIME,
    end_date_time DATETIME,
    ClassID INT,
	InstructorID INT,
    FOREIGN KEY (InstructorID) REFERENCES Instructor(InstructorID) on delete set Null,
    FOREIGN KEY (ClassID) REFERENCES Class(ClassID) on delete set Null
);

CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    AttendanceStatus VARCHAR(20),
    ClassID INT,
    FOREIGN KEY (ClassID) REFERENCES Class(ClassID) on delete set null
);

CREATE TABLE Members (
    MemberID INT PRIMARY KEY,
    Email VARCHAR(100),
    Firstname VARCHAR(50),
    City VARCHAR(50),
    Street VARCHAR(50),
    State VARCHAR(50),
    EmergencyNum BIGINT
);

CREATE TABLE MemberPhone (
    PhoneNum bigint,
    MemberID INT,
    PRIMARY KEY (PhoneNum),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID) ON DELETE SET NULL
);

CREATE TABLE Assessment (
    AssessmentID INT PRIMARY KEY,
    assessDate DATE,
    weight DECIMAL(5, 2),
    fitnessLevel VARCHAR(50),
    MemberID INT,
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID) ON DELETE SET NULL
);

CREATE TABLE WorkoutLogs (
    LogID INT PRIMARY KEY,
    CaloriesBurned INT,
    Notes TEXT,
    Date DATE,
    MemberID INT,
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID) ON DELETE SET NULL
);

CREATE TABLE HealthGoals (
    M_ID INT PRIMARY KEY,
    TagValue VARCHAR(100),
    GoalType VARCHAR(100),
    Progress VARCHAR(100),
    MemberID INT,
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID) ON DELETE SET NULL
);

CREATE TABLE Registrations (
    MemberID INT,
    ClassID INT,
    PRIMARY KEY (MemberID, ClassID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID) ,
    FOREIGN KEY (ClassID) REFERENCES Class(ClassID)
);

CREATE TABLE MemberShipPlans (
    MemberID INT,
    planName VARCHAR(100),
    price DECIMAL(10, 2),
    PRIMARY KEY (MemberID, planName),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);

CREATE TABLE MemberShipPlansBenefits (
    MemberID INT,
    planName VARCHAR(100),
    benefits TEXT,
    PRIMARY KEY (MemberID, planName),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID) 
);

CREATE TABLE SignUp (
    MemberID INT,
    planName VARCHAR(100),
    PRIMARY KEY (MemberID, planName),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID) 
);


-- 1. Insert Instructors
INSERT INTO Instructor (InstructorID, Fname, Lname, Specialization, Email, Salary, contract_type)
VALUES 
(1, 'Sarah', 'Johnson', 'Yoga and Meditation', 'sarah.j@fitness.com', 5200, 'Full-time'),
(2, 'Michael', 'Brown', 'Weight Training', 'michael.b@fitness.com', 4800, 'Full-time'),
(3, 'Emily', 'Davis', 'Pilates and Core', 'emily.d@fitness.com', 4500, 'Part-time'),
(4, 'David', 'Wilson', 'HIIT and Cardio', 'david.w@fitness.com', 5000, 'Full-time');

-- 2. Insert Instructor Phone Numbers
INSERT INTO InstructorPhone (PhoneNum, InstructorID)
VALUES
(15551234567, 1),
(15552345678, 2),
(15553456789, 3),
(15554567890, 4);

-- 3. Insert Classes
INSERT INTO Class (ClassID, ClassName, Duration, Time, MaxParticipant, InstructorID)
VALUES
(101, 'Morning Yoga', 60, '07:00:00', 20, 1),
(102, 'Power Lifting', 90, '18:00:00', 15, 2),
(103, 'Core Pilates', 45, '12:00:00', 10, 3),
(104, 'HIIT Blast', 60, '17:30:00', 25, 4),
(105, 'Evening Relaxation', 30, '20:00:00', 30, 1);

-- 4. Insert Members
INSERT INTO Members (MemberID, Email, Firstname, City, Street, State, EmergencyNum)
VALUES
(1001, 'john.doe@email.com', 'John', 'Boston', '123 Main St', 'MA', 15559876543),
(1002, 'jane.smith@email.com', 'Jane', 'Cambridge', '456 Oak Ave', 'MA', 15558765432),
(1003, 'robert.j@email.com', 'Robert', 'Boston', '789 Pine Rd', 'MA', 15557654321),
(1004, 'lisa.w@email.com', 'Lisa', 'Somerville', '321 Elm St', 'MA', 15556543210);


UPDATE Members
SET City = 'New York'
WHERE 
MemberID = 1001;

DELETE FROM Members 
WHERE MemberID = 1001;

-- 5. Insert Member Phone Numbers
INSERT INTO MemberPhone (PhoneNum, MemberID)
VALUES
(15551112222, 1001),
(15552223333, 1002),
(15553334444, 1003),
(15554445555, 1004),
(15556667777, 1001);

-- 6. Insert Schedules
INSERT INTO Schedule (ScheduleID, location, start_date_time, end_date_time, ClassID, InstructorID)
VALUES
(501, 'Main Studio', '2023-11-01 07:00:00', '2023-11-01 08:00:00', 101, 1),
(502, 'Weight Room', '2023-11-01 18:00:00', '2023-11-01 19:30:00', 102, 2),
(503, 'Studio B', '2023-11-02 12:00:00', '2023-11-02 12:45:00', 103, 3),
(504, 'Main Studio', '2023-11-02 17:30:00', '2023-11-02 18:30:00', 104, 4),
(505, 'Studio A', '2023-11-02 20:00:00', '2023-11-02 20:30:00', 105, 1);

-- 7. Insert Enrollments
INSERT INTO Enrollments (EnrollmentID, AttendanceStatus, ClassID)
VALUES
(601, 'Present', 101),
(602, 'Present', 102),
(603, 'Absent', 103),
(604, 'Present', 104),
(605, 'Present', 105);

-- 8. Insert Assessments
INSERT INTO Assessment (AssessmentID, assessDate, weight, fitnessLevel, MemberID)
VALUES
(701, '2023-10-01', 185.5, 'Intermediate', 1001),
(702, '2023-10-01', 132.0, 'Beginner', 1002),
(703, '2023-10-02', 210.0, 'Advanced', 1003),
(704, '2023-10-02', 155.5, 'Intermediate', 1004);

-- 9. Insert Workout Logs
INSERT INTO WorkoutLogs (LogID, CaloriesBurned, Notes, Date, MemberID)
VALUES
(801, 350, 'Great session, focused on core', '2023-10-15', 1001),
(802, 420, 'Intense cardio workout', '2023-10-16', 1002),
(803, 380, 'Weight training - legs focus', '2023-10-17', 1003),
(804, 290, 'Recovery yoga session', '2023-10-18', 1004);

-- 10. Insert Health Goals
INSERT INTO HealthGoals (M_ID, TagValue, GoalType, Progress, MemberID)
VALUES
(901, 'Weight Loss', 'Fitness', '25% achieved', 1001),
(902, 'Muscle Gain', 'Strength', '40% achieved', 1002),
(903, 'Endurance', 'Cardio', '15% achieved', 1003),
(904, 'Flexibility', 'Mobility', '30% achieved', 1004);

-- 11. Insert Membership Plans
INSERT INTO MemberShipPlans (MemberID, planName, price)
VALUES
(1001, 'Premium', 99.99),
(1002, 'Basic', 59.99),
(1003, 'Premium', 99.99),
(1004, 'Student', 39.99);

-- 12. Insert Membership Benefits
INSERT INTO MemberShipPlansBenefits (MemberID, planName, benefits)
VALUES
(1001, 'Premium', 'Unlimited classes, personal trainer discount'),
(1002, 'Basic', '3 classes per week, gym access'),
(1003, 'Premium', 'Unlimited classes, personal trainer discount'),
(1004, 'Student', '2 classes per week, gym access with student ID');

-- 13. Insert SignUps
INSERT INTO SignUp (MemberID, planName)
VALUES
(1001, 'Premium'),
(1002, 'Basic'),
(1003, 'Premium'),
(1004, 'Student');

-- 14. Insert Registrations (Members to Classes)
INSERT INTO Registrations (MemberID, ClassID)
VALUES
(1001, 101),
(1001, 102),
(1002, 103),
(1003, 104),
(1004, 105),
(1002, 101);

SELECT m.Firstname, m.Email
FROM Members m
JOIN Registrations r ON m.MemberID = r.MemberID
JOIN Class c ON r.ClassID = c.ClassID
WHERE c.ClassName = 'Morning Yoga';


SELECT i.Fname + ' ' + i.Lname AS InstructorName, 
       c.ClassName, c.Duration, c.Time
FROM Instructor i
LEFT JOIN Class c ON i.InstructorID = c.InstructorID;


SELECT c.ClassName, s.location, 
       s.start_date_time, s.end_date_time
FROM Schedule s
JOIN Class c ON s.ClassID = c.ClassID;


SELECT c.ClassName, COUNT(r.MemberID) AS MemberCount
FROM Class c
LEFT JOIN Registrations r ON c.ClassID = r.ClassID
GROUP BY c.ClassName
ORDER BY MemberCount DESC;

SELECT contract_type, AVG(Salary) AS AvgSalary
FROM Instructor
GROUP BY contract_type;

SELECT m.Firstname, SUM(w.CaloriesBurned) AS TotalCaloriesBurned
FROM Members m
JOIN WorkoutLogs w ON m.MemberID = w.MemberID
GROUP BY m.Firstname
ORDER BY TotalCaloriesBurned DESC;

SELECT fitnessLevel, AVG(weight) AS AvgWeight
FROM Assessment
GROUP BY fitnessLevel;


SELECT planName, 
       COUNT(*) AS MemberCount,
       SUM(price) AS TotalRevenue,
       AVG(price) AS AvgRevenuePerMember
FROM MemberShipPlans
GROUP BY planName
ORDER BY TotalRevenue DESC;


SELECT i.Fname + ' ' + i.Lname AS Instructor,
       COUNT(c.ClassID) AS ClassesTaught,
       SUM(c.Duration) AS TotalMinutesTeaching
FROM Instructor i
LEFT JOIN Class c ON i.InstructorID = c.InstructorID
GROUP BY i.Fname, i.Lname
ORDER BY ClassesTaught DESC;


SELECT 
    a.fitnessLevel,
    COUNT(w.LogID) AS NumberOfWorkouts,
    AVG(w.CaloriesBurned) AS AvgCaloriesBurned,
    MIN(w.CaloriesBurned) AS MinCalories,
    MAX(w.CaloriesBurned) AS MaxCalories
FROM 
    Assessment a
JOIN 
    Members m ON a.MemberID = m.MemberID
JOIN 
    WorkoutLogs w ON m.MemberID = w.MemberID
GROUP BY 
    a.fitnessLevel
ORDER BY 
    AvgCaloriesBurned DESC;


SELECT 
    m.Firstname AS MemberName,
    c.ClassName,
    c.Time AS ClassTime
FROM 
    Registrations r
RIGHT JOIN 
    Members m ON r.MemberID = m.MemberID
LEFT JOIN 
    Class c ON r.ClassID = c.ClassID



SELECT 
    i.Fname + ' ' + i.Lname AS InstructorName,
    c.ClassName,
    s.location,
    s.start_date_time
FROM 
    Instructor i
FULL JOIN 
    Class c ON i.InstructorID = c.InstructorID
FULL JOIN 
    Schedule s ON c.ClassID = s.ClassID


