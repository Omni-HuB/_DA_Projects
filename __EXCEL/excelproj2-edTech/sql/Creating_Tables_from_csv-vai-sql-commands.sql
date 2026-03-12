drop database if exists edtech_analytics;
CREATE DATABASE edtech_analytics;
USE edtech_analytics;


## NOTE :: 
 # 1. All columns in table should be in order as in csv so mapping is done without error
 # 2. Create Tables based on Relations(foreign key). eg. create table first whose primary key will be used as foreign key in later table , to avoid error
 # 3. Import the data first of the table which is created first
##


CREATE TABLE Students (
    Student_ID VARCHAR(10) PRIMARY KEY,
    Student_Name VARCHAR(100),
    Gender VARCHAR(10),
    City VARCHAR(50),
    Signup_Date DATETIME,
    Signup_Year VARCHAR(10),
    Signup_Month VARCHAR(10)
);

CREATE TABLE Instructors (
    Instructor_ID VARCHAR(10) primary key,
    Instructor_Name VARCHAR(100),
    Experience_years INT
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
	Enrollment_ID VARCHAR(20),
    Amount INT,
    Payment_Date DATETIME,
    Payment_Mode VARCHAR(20),
    foreign key (Enrollment_ID) references Enrollments(Enrollment_ID),
    foreign key (Student_ID) references Students(Student_ID)

);

CREATE TABLE Refunds (
    Refund_ID VARCHAR(10) PRIMARY KEY,
    Transaction_ID VARCHAR(10),
	Enrollment_ID VARCHAR(20),
    Refund_Amount INT,
    Refund_Date DATETIME,
	foreign key (Enrollment_ID) references Enrollments(Enrollment_ID),
	foreign key (Transaction_ID) references Transactions(Transaction_ID)
);

CREATE TABLE Campaigns (
    Campaign VARCHAR(10) PRIMARY KEY,
	Spend INT
);

CREATE TABLE Leads (
    Lead_ID VARCHAR(10) PRIMARY KEY,
    Student_ID VARCHAR(10),
    Lead_Source VARCHAR(20),
    Lead_Date datetime,
	foreign key (Student_ID) references Students(Student_ID),
	foreign key (Lead_Source) references Campaigns(Campaign)

);



LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Students.csv'
INTO TABLE Students
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Instructors.csv'
INTO TABLE Instructors
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Course_Master.csv'
INTO TABLE Course_Master
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Enrollments.csv'
INTO TABLE Enrollments
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Transactions.csv'
INTO TABLE Transactions
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Refunds.csv'
INTO TABLE Refunds
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Campaigns.csv'
INTO TABLE Campaigns
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Leads.csv'
INTO TABLE Leads
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;





select * from Students limit 20;
select * from refunds limit 20;


