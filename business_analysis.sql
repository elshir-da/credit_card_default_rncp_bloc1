USE credit_card_default_db;

-- Query 1: Overall Default Rate
SELECT
    COUNT(*) AS total_customers,
    SUM(default_next_month = 1) AS default_customers,
    SUM(default_next_month = 0) AS non_default_customers,
    ROUND(
        AVG(default_next_month) * 100, 2
    ) AS default_rate_percent
FROM customers;


-- Query 2: Default Rate by Education
SELECT
    education,
    COUNT(*) AS total_customers,
    SUM(default_next_month = 1) AS default_customers,
    ROUND(
        AVG(default_next_month) * 100, 2
    ) AS default_rate_percent
FROM customers
GROUP BY education
ORDER BY default_rate_percent DESC;



-- Query 3: Average Credit Limit by Default Status
SELECT
    default_next_month,
    COUNT(*) AS total_customers,
    ROUND(AVG(limit_bal), 2) AS avg_credit_limit
FROM customers
GROUP BY default_next_month
ORDER BY default_next_month;


-- Query 4: Repayment Delay vs Default Rate
SELECT
    r.payment_status,
    COUNT(*) AS total_customers,
    SUM(c.default_next_month = 1) AS default_customers,
    ROUND(
        AVG(c.default_next_month) * 100, 2
    ) AS default_rate_percent
FROM customers c
JOIN repayment_status r
    ON c.customer_id = r.customer_id
WHERE r.month_index = 1
GROUP BY r.payment_status
ORDER BY r.payment_status;



-- Query 5: Average Bill Amount vs Payment Amount
SELECT
    c.default_next_month,
    COUNT(*) AS total_customers,
    ROUND(AVG(b.bill_amount), 2) AS avg_bill_amount,
    ROUND(AVG(p.payment_amount), 2) AS avg_payment_amount
FROM customers c
JOIN billing_history b
    ON c.customer_id = b.customer_id
JOIN payment_history p
    ON c.customer_id = p.customer_id
    AND b.month_index = p.month_index
WHERE b.month_index = 1
GROUP BY c.default_next_month
ORDER BY c.default_next_month;




