

-- =========================================================
-- Credit Card Database (ccdb)
-- FINAL WORKING VERSION (secure_file_priv)
-- =========================================================

CREATE DATABASE IF NOT EXISTS ccdb;
USE ccdb;

-- =========================================================
-- Drop tables (safe re-run)
-- =========================================================
DROP TABLE IF EXISTS cc_detail;
DROP TABLE IF EXISTS cust_detail;

-- =========================================================
-- Customer Detail Table
-- =========================================================
CREATE TABLE cust_detail (
    Client_Num INT NOT NULL,
    Customer_Age INT,
    Gender VARCHAR(5),
    Dependent_Count INT,
    Education_Level VARCHAR(50),
    Marital_Status VARCHAR(20),
    State_cd VARCHAR(50),
    Zipcode VARCHAR(20),
    Car_Owner VARCHAR(5),
    House_Owner VARCHAR(5),
    Personal_Loan VARCHAR(5),
    Contact VARCHAR(50),
    Customer_Job VARCHAR(50),
    Income INT,
    Cust_Satisfaction_Score INT,
    PRIMARY KEY (Client_Num)
) ENGINE=InnoDB;

-- =========================================================
-- Credit Card Detail Table
-- =========================================================
CREATE TABLE cc_detail (
    cc_id INT AUTO_INCREMENT PRIMARY KEY,
    Client_Num INT NOT NULL,
    Card_Category VARCHAR(20),
    Annual_Fees INT,
    Activation_30_Days INT,
    Customer_Acq_Cost INT,
    Week_Start_Date DATE,
    Week_Num VARCHAR(20),
    Qtr VARCHAR(10),
    current_year INT,
    Credit_Limit DECIMAL(10,2),
    Total_Revolving_Bal INT,
    Total_Trans_Amt INT,
    Total_Trans_Ct INT,
    Avg_Utilization_Ratio DECIMAL(10,3),
    Use_Chip VARCHAR(10),
    Exp_Type VARCHAR(50),
    Interest_Earned DECIMAL(10,3),
    Delinquent_Acc VARCHAR(5),
    CONSTRAINT fk_cc_client
        FOREIGN KEY (Client_Num)
        REFERENCES cust_detail (Client_Num)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- =========================================================
-- Indexes
-- =========================================================
CREATE INDEX idx_cc_client ON cc_detail (Client_Num);
CREATE INDEX idx_cc_week ON cc_detail (Week_Start_Date);
CREATE INDEX idx_cc_card_category ON cc_detail (Card_Category);

-- =========================================================
-- DATA LOAD (SERVER-SIDE, NO LOCAL)
-- =========================================================

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/customer.csv'
INTO TABLE cust_detail
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/credit_card.csv'
INTO TABLE cc_detail
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/cc_add.csv'
INTO TABLE cc_detail
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/cust_add.csv'
INTO TABLE cust_detail
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- =========================================================
-- Validation
-- =========================================================
SELECT COUNT(*) AS customers FROM cust_detail;
SELECT COUNT(*) AS transactions FROM cc_detail;

-- =========================================================
-- END
-- =========================================================


SHOW VARIABLES LIKE 'secure_file_priv';
