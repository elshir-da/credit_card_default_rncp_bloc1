# RNCP C4 — Merise Data Modeling

## 1. Database Objective

The objective of the relational database is to organize historical credit card customer information into a structured format that supports SQL analysis and data access through the Flask API.

The database uses the UCI Default of Credit Card Clients dataset, containing 30,000 customer records.

## 2. Conceptual Data Model (MCD)

The Merise approach is used to identify the main entities, their attributes, and the relationships between them.

Four entities were identified:

| Entity | Description |
|---|---|
| Customers | Customer characteristics, credit limits, and next-month default status |
| Repayment Status | Historical repayment status for each customer |
| Billing History | Monthly credit card bill amounts |
| Payment History | Monthly payment amounts |

The conceptual relationships are:

- One customer can have multiple repayment status records.
- One customer can have multiple billing history records.
- One customer can have multiple payment history records.

Each historical record belongs to one customer.

## 3. Logical Data Model (MLD)

The conceptual entities were translated into four relational tables.

| Table | Primary Key | Foreign Key |
|---|---|---|
| customers | customer_id | — |
| repayment_status | status_id | customer_id |
| billing_history | bill_id | customer_id |
| payment_history | payment_id | customer_id |

Three one-to-many relationships connect the historical tables to the customers table.

The `customer_id` foreign keys ensure referential integrity.

A unique constraint on `(customer_id, month_index)` prevents duplicate monthly records within each historical table.

## 4. Physical Data Model (MPD)

The physical model was implemented in MySQL using InnoDB tables.

The database is named `credit_card_default_db`.

The dataset was imported using Python, pandas, and SQLAlchemy.

| Table | Imported Records |
|---|---:|
| customers | 30,000 |
| repayment_status | 180,000 |
| billing_history | 180,000 |
| payment_history | 180,000 |

**Total: 570,000 records.**

The `month_index` column identifies the six historical reporting positions in the original dataset and does not represent actual calendar dates.

## 5. Data Integrity

The database applies:

- Primary keys to uniquely identify records.
- Foreign keys to maintain relationships between tables.
- Unique constraints to prevent duplicate monthly history records.
- Structured numerical data types for amounts and repayment statuses.

## 6. Database Design Rationale

Separating customer characteristics, repayment statuses, billing amounts, and payment amounts into related tables reduces repeated customer information and makes SQL analysis more structured.

The model also supports joins across customer attributes and historical financial behavior.

This is a simplified educational implementation of Merise modeling, based on the existing MySQL database structure.

## 7. Supporting Evidence

- `create_database.sql` — MySQL database creation script.
- `ERD1.png` and `ERD2.png` — Database relationship diagrams.
- `import_to_mysql.ipynb` — Python data import workflow.
- `business_analysis.sql` — SQL queries demonstrating data retrieval and joins.