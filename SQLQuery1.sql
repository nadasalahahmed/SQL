Create database Fitness_System;
USE Fitness_System;
Go

CREATE TABLE Instructor (
    InstructorID INT PRIMARY KEY,
    Fname VARCHAR(50),
    Lname VARCHAR(50),
    Specialization VARCHAR(100),
    Email VARCHAR(100)
);
 
 alter table Instructor ADD Salary Int;

 CREATE TABLE InstructorPhone (
    PhoneNum Bigint,
    InstructorID INT,
    PRIMARY KEY (PhoneNum),
    FOREIGN KEY (InstructorID) REFERENCES Instructor(InstructorID)
);


CREATE TABLE Class (
    ClassID INT PRIMARY KEY,
    ClassName VARCHAR(100),
    Duration INT,
    Time TIME,
    MaxParticipant INT,
    InstructorID INT,
    FOREIGN KEY (InstructorID) REFERENCES Instructor(InstructorID)
);

Insert into Class ( ClassID , ClassName , MaxParticipant , InstructorID ) values 
(1 , 'yoga' , 40 , 1 ),
(2 , 'wight lefting ' , 50 , 2 ),
(3 , 'back ' , 15 , 1 );

select Class.ClassID , Class.ClassName , Class.MaxParticipant , Instructor.Fname +' ' +Instructor.Lname as Instructor_Name
from Class
right join Instructor 
On Class.InstructorID = Instructor.InstructorID;


CREATE TABLE Schedule (
    ScheduleID INT PRIMARY KEY,
    location VARCHAR(100),
    start_date_time DATETIME,
    end_date_time DATETIME,
    ClassID INT,
    FOREIGN KEY (ClassID) REFERENCES Class(ClassID)
);


CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    AttendanceStatus VARCHAR(20),
    ClassID INT,
    FOREIGN KEY (ClassID) REFERENCES Class(ClassID)
);

CREATE TABLE Member (
    MemberID INT PRIMARY KEY,
    Email VARCHAR(100),
    Firstname VARCHAR(50),
    City VARCHAR(50),
    Street VARCHAR(50),
    State VARCHAR(50),
    Name VARCHAR(100)
);

alter table Member Drop column Name ;
alter table Member add EmergancyNum BIGINT;


CREATE TABLE MemberPhone (
    PhoneNum bigint,
    MemberID INT,
    PRIMARY KEY (PhoneNum),
    FOREIGN KEY (MemberID) REFERENCES Member(MemberID)
);



CREATE TABLE Assessment (
    AssessmentID INT PRIMARY KEY,
    assessDate DATE,
    weight DECIMAL(5, 2),
    fitnessLevel VARCHAR(50),
    MemberID INT,
    FOREIGN KEY (MemberID) REFERENCES Member(MemberID)
);

CREATE TABLE WorkoutLogs (
    LogID INT PRIMARY KEY,
    CaloriesBurned INT,
    Notes TEXT,
    Date DATE,
    MemberID INT,
    FOREIGN KEY (MemberID) REFERENCES Member(MemberID)
);


CREATE TABLE Registrations (
    MemberID INT,
    ClassID INT,
    PRIMARY KEY (MemberID, ClassID),
    FOREIGN KEY (MemberID) REFERENCES Member(MemberID),
    FOREIGN KEY (ClassID) REFERENCES Class(ClassID)
);

CREATE TABLE HealthGoals (
    M_ID INT PRIMARY KEY,
    TagValue VARCHAR(100),
    GoalType VARCHAR(100),
    Progress VARCHAR(100),
    MemberID INT,
    FOREIGN KEY (MemberID) REFERENCES Member(MemberID)
);

CREATE TABLE SignUp (
    MemberID INT,
    planName VARCHAR(100),
    PRIMARY KEY (MemberID, planName),
    FOREIGN KEY (MemberID) REFERENCES Member(MemberID)
);

CREATE TABLE MemberShipPlans (
    MemberID INT,
    planName VARCHAR(100),
    price DECIMAL(10, 2),
    PRIMARY KEY (MemberID, planName),
    FOREIGN KEY (MemberID) REFERENCES Member(MemberID)
);

CREATE TABLE MemberShipPlansBenefits (
    MemberID INT,
    planName VARCHAR(100),
    benefits TEXT,
    PRIMARY KEY (MemberID, planName),
    FOREIGN KEY (MemberID) REFERENCES Member(MemberID)
);

INSERT INTO Instructor (InstructorID, Fname, Lname, Specialization, Email , Salary ) 
VALUES (1, 'John', 'Doe', 'Yoga Instructor', 'john.doe@example.com' , 5000),
       (2, 'Jane', 'Smith', 'Pilates Instructor', 'jane.smith@example.com' , 4500),
       (3, 'Mark', 'Johnson', 'Spin Instructor', 'mark.johnson@example.com', 4000 );


select * from Instructor; 

INSERT INTO InstructorPhone (PhoneNum, InstructorID) 
VALUES (123456789 , 1),
       (112233445 , 2),
       (987654321 , 3);


select Instructor.InstructorID,
    Instructor.FName,
    Instructor.LName,
    Instructor.Specialization,
	STRING_AGG(InstructorPhone.PhoneNum, ', ') AS PhoneNumbers
	from Instructor  
left join InstructorPhone
on Instructor.InstructorID = InstructorPhone.InstructorID
GROUP BY Instructor.InstructorID, Instructor.FName, Instructor.LName, Instructor.Specialization;

SELECT Fname + '  ' + Lname as full_name  , 1.1 *Salary from Instructor
where InstructorID = 3;










