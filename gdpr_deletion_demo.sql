-- GDPR: Demonstration of customer data deletion
-- Safe test using a transaction and ROLLBACK

USE credit_card_default_db;

START TRANSACTION;

-- Delete related historical records
DELETE FROM repayment_status WHERE customer_id = 1;
DELETE FROM billing_history WHERE customer_id = 1;
DELETE FROM payment_history WHERE customer_id = 1;

-- Delete the customer record
DELETE FROM customers WHERE customer_id = 1;

-- Undo all changes
ROLLBACK;

-- Verify the original customer remains
SELECT COUNT(*) AS customer_exists
FROM customers
WHERE customer_id = 1;
