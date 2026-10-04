USE LedgerX;

-- 1. Display all users with their accounts
SELECT
    u.first_name,
    u.last_name,
    a.account_name,
    a.balance
FROM users u
JOIN accounts a
    ON u.user_id = a.user_id;


-- 2. Display all expense transactions
SELECT
    u.first_name,
    c.category_name,
    t.amount,
    t.transaction_date
FROM users u
JOIN accounts a
    ON u.user_id = a.user_id
JOIN transactions t
    ON a.account_id = t.account_id
JOIN categories c
    ON t.category_id = c.category_id
WHERE t.transaction_type = 'Expense';


-- 3. Total expense by category
SELECT
    c.category_name,
    SUM(t.amount) AS total_expense
FROM transactions t
JOIN categories c
    ON t.category_id = c.category_id
WHERE t.transaction_type = 'Expense'
GROUP BY c.category_name;


-- 4. Total expense by user
SELECT
    u.first_name,
    u.last_name,
    SUM(t.amount) AS total_expense
FROM users u
JOIN accounts a
    ON u.user_id = a.user_id
JOIN transactions t
    ON a.account_id = t.account_id
WHERE t.transaction_type = 'Expense'
GROUP BY u.user_id, u.first_name, u.last_name;


-- 5. Income and expense by user
SELECT
    u.first_name,
    u.last_name,
    SUM(CASE
        WHEN t.transaction_type = 'Income' THEN t.amount
        ELSE 0
    END) AS total_income,
    SUM(CASE
        WHEN t.transaction_type = 'Expense' THEN t.amount
        ELSE 0
    END) AS total_expense
FROM users u
JOIN accounts a
    ON u.user_id = a.user_id
JOIN transactions t
    ON a.account_id = t.account_id
GROUP BY u.user_id, u.first_name, u.last_name;


-- 6. Net savings by user
SELECT
    u.first_name,
    u.last_name,
    SUM(
        CASE
            WHEN t.transaction_type = 'Income' THEN t.amount
            ELSE -t.amount
        END
    ) AS net_savings
FROM users u
JOIN accounts a
    ON u.user_id = a.user_id
JOIN transactions t
    ON a.account_id = t.account_id
GROUP BY u.user_id, u.first_name, u.last_name;


-- 7. Highest expense category
SELECT
    c.category_name,
    SUM(t.amount) AS total_expense
FROM transactions t
JOIN categories c
    ON t.category_id = c.category_id
WHERE t.transaction_type = 'Expense'
GROUP BY c.category_name
ORDER BY total_expense DESC
LIMIT 1;


-- 8. Users with positive net savings
SELECT
    u.first_name,
    u.last_name,
    SUM(
        CASE
            WHEN t.transaction_type = 'Income' THEN t.amount
            ELSE -t.amount
        END
    ) AS net_savings
FROM users u
JOIN accounts a
    ON u.user_id = a.user_id
JOIN transactions t
    ON a.account_id = t.account_id
GROUP BY u.user_id, u.first_name, u.last_name
HAVING net_savings > 0;