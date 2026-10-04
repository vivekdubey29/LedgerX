# LedgerX

LedgerX is a MySQL project for managing users, bank accounts, financial transactions, categories, and payment details.

I built this project to practice SQL and understand how different tables are connected in a real-world type of database.

## What this project does

The database stores:

- User information
- Multiple accounts for users
- Income and expense transactions
- Transaction categories
- Payment details

It also includes SQL queries to analyze spending, income, savings, and transaction data.

## Database Tables

### 1. users
Stores basic information about users.

### 2. accounts
Stores accounts linked to users.

### 3. categories
Stores income and expense categories such as Salary, Food, Travel, etc.

### 4. transactions
Stores all income and expense transactions.

### 5. payments
Stores payment method and payment status for transactions.

## SQL Concepts Used

While building this project, I practiced:

- Primary Key
- Foreign Key
- UNIQUE constraint
- ENUM
- JOINs
- LEFT JOIN
- RIGHT JOIN
- GROUP BY
- HAVING
- ORDER BY
- Aggregate functions like `SUM()` and `AVG()`
- CASE statements
- Subqueries
- CTEs
- Window functions
- Views
- Indexes

## Project Files

```text
LedgerX/
│
├── 01_database.sql
├── 02_tables.sql
├── 03_sample_data.sql
├── 04_basic_queries.sql
├── 05_joins.sql
├── 06_advanced_queries.sql
├── 07_views.sql
├── 08_indexes.sql
└── README.md