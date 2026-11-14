
-- Step 1: Create database
CREATE DATABASE IF NOT EXISTS credit_card_default_db;

USE credit_card_default_db;

-- Table 1: Customers
CREATE TABLE IF NOT EXISTS customers (
    customer_id INT PRIMARY KEY,
    limit_bal DECIMAL(14,2),
    sex INT,
    education INT,
    marriage INT,
    age INT,
    default_next_month INT
) ENGINE=InnoDB;

-- Table 2: Repayment Status
CREATE TABLE IF NOT EXISTS repayment_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    month_index INT NOT NULL,
    payment_status INT,
    UNIQUE (customer_id, month_index),
    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
) ENGINE=InnoDB;

-- Table 3: Billing History
CREATE TABLE IF NOT EXISTS billing_history (
    bill_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    month_index INT NOT NULL,
    bill_amount DECIMAL(14,2),
    UNIQUE (customer_id, month_index),
    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
) ENGINE=InnoDB;

-- Table 4: Payment History
CREATE TABLE IF NOT EXISTS payment_history (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    month_index INT NOT NULL,
    payment_amount DECIMAL(14,2),
    UNIQUE (customer_id, month_index),
    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
) ENGINE=InnoDB;


USE credit_card_default_db;

-- Display all tables
SHOW TABLES;

-- Check table structures
DESCRIBE customers;
DESCRIBE repayment_status;
DESCRIBE billing_history;
DESCRIBE payment_history;


SELECT
    TABLE_NAME,
    COLUMN_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'credit_card_default_db'
  AND REFERENCED_TABLE_NAME IS NOT NULL;
