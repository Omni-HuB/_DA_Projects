drop database if exists edtech_analytics;
CREATE DATABASE edtech_analytics;
USE edtech_analytics;

CREATE TABLE Students (
    Student_ID VARCHAR(10) PRIMARY KEY,
    Student_Name VARCHAR(100),
    Gender VARCHAR(10),
    City VARCHAR(50),
    Signup_Date DATETIME,
    Signup_Year DATETIME,
    Signup_Month DATETIME
);

CREATE TABLE Course_Master (
    Course_ID VARCHAR(10) PRIMARY KEY,
    Course_Name VARCHAR(100),
    Fee INT,
    Instructor_ID VARCHAR(10)
);

CREATE TABLE Enrollments (
    Enrollment_ID VARCHAR(10) PRIMARY KEY,
    Student_ID VARCHAR(10),
    Course_ID VARCHAR(10),
    Enrollment_Date DATETIME,
    Enrollment_Status VARCHAR(20),
    FOREIGN KEY (Student_ID) REFERENCES Students(Student_ID),
	FOREIGN KEY (Course_ID) REFERENCES Course_Master(Course_ID)

);



CREATE TABLE Transactions (
    Transaction_ID VARCHAR(10) PRIMARY KEY,
    Student_ID VARCHAR(10),
    Enrollment_ID VARCHAR(10),
    Amount INT,
    Payment_Date DATETIME,
    Payment_Mode VARCHAR(20),
    Enrollment_ID VARCHAR(20),
    foreign key (Enrollment_ID) references Enrollments(Enrollment_ID),
    foreign key (Student_ID) references Students(Student_ID)

);

CREATE TABLE Refunds (
    Refund_ID VARCHAR(10) PRIMARY KEY,
    Transaction_ID VARCHAR(10),
    Refund_Amount INT,
    Refund_Date DATETIME,
    Enrollment_ID VARCHAR(10),
	foreign key (Enrollment_ID) references Enrollments(Enrollment_ID),
	foreign key (Transaction_ID) references Transactions(Transaction_ID)
);
