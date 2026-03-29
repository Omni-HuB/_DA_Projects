

# 📊 Project Overview

### Excel Data Modeling & Analysis Project

This project demonstrates how to build a **data model in Excel using Power Pivot** to analyze business data from multiple related tables.
The goal was to simulate a **real-world analytics scenario** involving students, course enrollments, transactions, refunds, and marketing campaigns.

The dataset was structured into **multiple tables**, and relationships were created between them to perform **cross-table analysis using Pivot Tables**.

This project focuses on:

* Data modeling
* Creating relationships between tables
* Handling many-to-one relationships
* Fixing ambiguous filter paths
* Performing business analysis using Pivot Tables

---

## 🗂 Dataset Structure

The dataset is divided into the following tables:

### 1. Students

Contains information about students.

Columns:

* Student_ID
* Student_Name
* Gender
* City
* Signup_Date

---

### 2. Enrollments

Represents course enrollments made by students.

Columns:

* Enrollment_ID
* Student_ID
* Course_ID
* Enrollment_Date
* Status (Active / Cancelled)

---

### 3. Course_Master

Contains course details.

Columns:

* Course_ID
* Course_Name
* Fee
* Instructor_ID

---

### 4. Instructors

Instructor information.

Columns:

* Instructor_ID
* Instructor_Name
* Experience_Years

---

### 5. Transactions

Payment records made by students for courses.

Columns:

* Transaction_ID
* Student_ID
* Enrollment_ID
* Amount
* Payment_Date
* Payment_Mode

---

### 6. Refunds

Refunds issued for transactions.

Columns:

* Refund_ID
* Transaction_ID
* Refund_Amount
* Refund_Date

---

### 7. Leads

Marketing leads generated for students.

Columns:

* Lead_ID
* Student_ID
* Lead_Source
* Lead_Date

---

### 8. Campaigns

Marketing campaign spending.

Columns:

* Campaign
* Spend

---

## 🧩 Data Model

The project uses a **star schema data model** in Excel Power Pivot.

Relationship flow:

Course_Master → Enrollments → Transactions → Refunds
Students → Enrollments
Students → Leads → Campaigns
Instructors → Course_Master

This structure allows filtering and aggregation across multiple tables.

---

## ⚙️ Key Challenges Solved

### 1. Ambiguous Relationship Paths

Excel does not allow multiple filtering paths between tables.
This was resolved by removing redundant relationships and ensuring a single filtering path.

Example problem:

Students → Transactions
Students → Enrollments → Transactions

Solution:
Removed the direct Students → Transactions relationship.

---

### 2. Missing Foreign Keys

To correctly calculate revenue by course, the **Enrollment_ID** field was added to the Transactions table so payments could be linked directly to enrollments.

---

### 3. Refund Aggregation Issue

Refund totals initially appeared identical across courses because filtering could not propagate correctly.
This was addressed by improving table relationships and ensuring proper foreign key connections.

---

## 📈 Analysis Performed

Using Pivot Tables and the data model, the following analyses were created:

* Course-wise revenue
* Refund amounts by course
* Active vs cancelled enrollments
* Student signups by city
* Marketing lead source analysis
* Revenue distribution across courses
* Enrollment counts per course

---

## 🛠 Tools Used

* Microsoft Excel
* Power Pivot
* Pivot Tables
* Data Modeling
* XLOOKUP
* Conditional Formatting
* Data Validation Techniques

---

## 📚 Learning Outcomes

Through this project, the following concepts were practiced:

* Building relational data models in Excel
* Understanding fact vs dimension tables
* Handling many-to-one relationships
* Preventing ambiguous filter paths
* Designing a star schema
* Creating advanced Pivot Table analysis

---

## 🚀 Future Improvements

Possible enhancements include:

* Creating an interactive Excel dashboard
* Adding Power Query transformations
* Implementing DAX measures
* Automating data cleaning workflows
* Expanding dataset size for large-scale analysis

---

## 👨‍💻 Author

Mohammad Shariq

This project was created as a practice exercise to develop **data analytics and data modeling skills using Excel**.
