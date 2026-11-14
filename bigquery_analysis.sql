
-- Query 1: Overall Default Rate
SELECT
    COUNT(*) AS total_customers,
    COUNTIF(`default payment next month` = 1) AS default_customers,
    COUNTIF(`default payment next month` = 0) AS non_default_customers,
    ROUND(
        AVG(`default payment next month`) * 100, 2
    ) AS default_rate_percent
FROM `credit-card-default-project.credit_card_default.customers`;



-- Query 2: Average Credit Limit by Default Status
SELECT
    `default payment next month` AS default_status,
    COUNT(*) AS total_customers,
    ROUND(AVG(LIMIT_BAL), 2) AS avg_credit_limit
FROM `credit-card-default-project.credit_card_default.customers`
GROUP BY default_status
ORDER BY default_status;


-- Query 3: Repayment Status vs Default Rate
SELECT
    PAY_0 AS repayment_status,
    COUNT(*) AS total_customers,
    COUNTIF(`default payment next month` = 1) AS default_customers,
    ROUND(
        AVG(`default payment next month`) * 100, 2
    ) AS default_rate_percent
FROM `credit-card-default-project.credit_card_default.customers`
GROUP BY repayment_status
ORDER BY repayment_status;
