-- =========================================================
-- Credit Card Database (ccdb)
-- FINAL ETL + FK SAFE VERSION
-- MySQL 8 | Windows | secure_file_priv
-- =========================================================

-- =========================================================
-- Credit Card Database (ccdb)
-- Purpose:
--   1. Create database and tables
--   2. Load customer (dimension) data
--   3. Load credit card transaction (fact) data
--   4. Handle date format issues
--   5. Maintain foreign key integrity
-- =========================================================


-- =========================================================
-- 0. CREATE DATABASE
-- =========================================================

-- Create database only if it does not already exist
CREATE DATABASE IF NOT EXISTS ccdb;

-- Select the database so all tables are created inside it
USE ccdb;


-- =========================================================
-- 1. DROP TABLES (FOR SAFE RE-RUN)
-- =========================================================

-- Drop fact table first (because it depends on customer table)
DROP TABLE IF EXISTS cc_detail;

-- Drop dimension table
DROP TABLE IF EXISTS cust_detail;


-- =========================================================
-- 2. CUSTOMER DETAIL TABLE (DIMENSION TABLE)
-- =========================================================

-- Create customer dimension table
-- Each row represents ONE customer
CREATE TABLE cust_detail (

    -- Unique customer identifier (Primary Key)
    Client_Num INT NOT NULL,

    -- Demographic information
    Customer_Age INT,
    Gender VARCHAR(5),
    Dependent_Count INT,
    Education_Level VARCHAR(50),
    Marital_Status VARCHAR(20),

    -- Address-related info
    State_cd VARCHAR(50),
    Zipcode VARCHAR(20),

    -- Asset & loan info
    Car_Owner VARCHAR(5),
    House_Owner VARCHAR(5),
    Personal_Loan VARCHAR(5),

    -- Contact & employment info
    Contact VARCHAR(50),
    Customer_Job VARCHAR(50),

    -- Financial & satisfaction data
    Income INT,
    Cust_Satisfaction_Score INT,

    -- Declare primary key
    PRIMARY KEY (Client_Num)
) ENGINE=InnoDB;


-- =========================================================
-- 3. CREDIT CARD DETAIL TABLE (FACT TABLE)
-- =========================================================

-- Create transaction fact table
-- Each row represents ONE credit card activity
CREATE TABLE cc_detail (

    -- Surrogate key (auto-generated)
    cc_id INT AUTO_INCREMENT PRIMARY KEY,

    -- Business key (foreign key to customer table)
    Client_Num INT NOT NULL,

    -- Credit card attributes
    Card_Category VARCHAR(20),
    Annual_Fees INT,
    Activation_30_Days INT,
    Customer_Acq_Cost INT,

    -- Date when the transaction week started
    Week_Start_Date DATE,

    -- Time dimensions
    Week_Num VARCHAR(20),
    Qtr VARCHAR(10),
    current_year INT,

    -- Financial metrics
    Credit_Limit DECIMAL(10,2),
    Total_Revolving_Bal INT,
    Total_Trans_Amt INT,
    Total_Trans_Ct INT,
    Avg_Utilization_Ratio DECIMAL(10,3),

    -- Usage & expense info
    Use_Chip VARCHAR(10),
    Exp_Type VARCHAR(50),
    Interest_Earned DECIMAL(10,3),
    Delinquent_Acc VARCHAR(5),

    -- Foreign key constraint to enforce data integrity
    CONSTRAINT fk_cc_client
        FOREIGN KEY (Client_Num)
        REFERENCES cust_detail (Client_Num)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;


-- =========================================================
-- 4. INDEXES (FOR PERFORMANCE)
-- =========================================================

-- Index to speed up joins between fact and dimension
CREATE INDEX idx_cc_client ON cc_detail (Client_Num);

-- Index for date-based queries (time series analysis)
CREATE INDEX idx_cc_week ON cc_detail (Week_Start_Date);

-- Index for card category filtering
CREATE INDEX idx_cc_card_category ON cc_detail (Card_Category);


-- =========================================================
-- 5. DATA LOADING (ETL PROCESS)
-- NOTE:
--   CSV files must be placed in MySQL's secure directory:
--   C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/
-- =========================================================


-- =========================================================
-- STEP 1: LOAD ALL CUSTOMERS FIRST
-- (Dimension must be loaded before fact table)
-- =========================================================

-- Load base customer data
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/customer.csv'
INTO TABLE cust_detail
FIELDS TERMINATED BY ','       -- Columns are comma-separated
ENCLOSED BY '"'               -- Text values are enclosed in quotes
LINES TERMINATED BY '\n'       -- Each row ends with newline
IGNORE 1 ROWS                 -- Skip header row
(
    Client_Num,
    Customer_Age,
    Gender,
    Dependent_Count,
    Education_Level,
    Marital_Status,
    State_cd,
    Zipcode,
    Car_Owner,
    House_Owner,
    Personal_Loan,
    Contact,
    Customer_Job,
    Income,
    Cust_Satisfaction_Score
);

-- Load additional customers (new customers for week 53)
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/cust_add.csv'
INTO TABLE cust_detail
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    Client_Num,
    Customer_Age,
    Gender,
    Dependent_Count,
    Education_Level,
    Marital_Status,
    State_cd,
    Zipcode,
    Car_Owner,
    House_Owner,
    Personal_Loan,
    Contact,
    Customer_Job,
    Income,
    Cust_Satisfaction_Score
);


-- =========================================================
-- STEP 2: LOAD ALL CREDIT CARD TRANSACTIONS
-- (FACT TABLE)
-- =========================================================

-- Load main credit card transaction data
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/credit_card.csv'
INTO TABLE cc_detail
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    Client_Num,
    Card_Category,
    Annual_Fees,
    Activation_30_Days,
    Customer_Acq_Cost,

    -- Store date temporarily in variable
    @Week_Start_Date,

    Week_Num,
    Qtr,
    current_year,
    Credit_Limit,
    Total_Revolving_Bal,
    Total_Trans_Amt,
    Total_Trans_Ct,
    Avg_Utilization_Ratio,
    Use_Chip,
    Exp_Type,
    Interest_Earned,
    Delinquent_Acc
)

-- Convert date from DD-MM-YYYY → MySQL DATE format
SET Week_Start_Date = STR_TO_DATE(@Week_Start_Date, '%d-%m-%Y');


-- Load additional transactions (Week 53 data)
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/cc_add.csv'
INTO TABLE cc_detail
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    Client_Num,
    Card_Category,
    Annual_Fees,
    Activation_30_Days,
    Customer_Acq_Cost,
    @Week_Start_Date,
    Week_Num,
    Qtr,
    current_year,
    Credit_Limit,
    Total_Revolving_Bal,
    Total_Trans_Amt,
    Total_Trans_Ct,
    Avg_Utilization_Ratio,
    Use_Chip,
    Exp_Type,
    Interest_Earned,
    Delinquent_Acc
)
SET Week_Start_Date = STR_TO_DATE(@Week_Start_Date, '%d-%m-%Y');


-- =========================================================
-- 6. VALIDATION & DATA QUALITY CHECKS
-- =========================================================

-- Total number of customers loaded
SELECT COUNT(*) AS total_customers FROM cust_detail;

-- Total number of transactions loaded
SELECT COUNT(*) AS total_transactions FROM cc_detail;

-- Check for orphan records (should return 0)
SELECT COUNT(*) AS orphan_records
FROM cc_detail c
LEFT JOIN cust_detail d
ON c.Client_Num = d.Client_Num
WHERE d.Client_Num IS NULL;

-- View sample records
SELECT * FROM cust_detail LIMIT 5;
SELECT * FROM cc_detail LIMIT 5;


-- =========================================================
-- END OF SCRIPT
-- =========================================================

