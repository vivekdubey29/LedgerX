USE LedgerX;

-- 1. Transactions above the average transaction amount
SELECT
    transaction_id,
    amount,
    transaction_type,
    description
FROM transactions
WHERE amount > (
    SELECT AVG(amount)
    FROM transactions
);


-- 2. Users with spending above the average user spending
SELECT
    u.first_name,
    u.last_name,
    SUM(t.amount) AS total_spending
FROM users u
JOIN accounts a
    ON u.user_id = a.user_id
JOIN transactions t
    ON a.account_id = t.account_id
WHERE t.transaction_type = 'Expense'
GROUP BY u.user_id, u.first_name, u.last_name
HAVING total_spending > (
    SELECT AVG(user_spending)
    FROM (
        SELECT
            a.user_id,
            SUM(t.amount) AS user_spending
        FROM accounts a
        JOIN transactions t
            ON a.account_id = t.account_id
        WHERE t.transaction_type = 'Expense'
        GROUP BY a.user_id
    ) AS spending
);


-- 3. Users with spending below the average user spending
SELECT
    u.first_name,
    u.last_name,
    SUM(t.amount) AS total_spending
FROM users u
JOIN accounts a
    ON u.user_id = a.user_id
JOIN transactions t
    ON a.account_id = t.account_id
WHERE t.transaction_type = 'Expense'
GROUP BY u.user_id, u.first_name, u.last_name
HAVING total_spending < (
    SELECT AVG(user_spending)
    FROM (
        SELECT
            a.user_id,
            SUM(t.amount) AS user_spending
        FROM accounts a
        JOIN transactions t
            ON a.account_id = t.account_id
        WHERE t.transaction_type = 'Expense'
        GROUP BY a.user_id
    ) AS spending
);


-- 4. Users with spending above ₹4,000
SELECT
    u.first_name,
    u.last_name,
    SUM(t.amount) AS total_spending
FROM users u
JOIN accounts a
    ON u.user_id = a.user_id
JOIN transactions t
    ON a.account_id = t.account_id
WHERE t.transaction_type = 'Expense'
GROUP BY u.user_id, u.first_name, u.last_name
HAVING total_spending > 4000;


-- 5. Total spending by category
SELECT
    c.category_name,
    SUM(t.amount) AS total_spending
FROM transactions t
JOIN categories c
    ON t.category_id = c.category_id
WHERE t.transaction_type = 'Expense'
GROUP BY c.category_name
ORDER BY total_spending DESC;


-- 6. Monthly transaction summary
SELECT
    YEAR(transaction_date) AS year,
    MONTH(transaction_date) AS month,
    transaction_type,
    SUM(amount) AS total_amount
FROM transactions
GROUP BY
    YEAR(transaction_date),
    MONTH(transaction_date),
    transaction_type
ORDER BY year, month;


-- 7. CTE: User spending summary
WITH user_spending AS (
    SELECT
        a.user_id,
        SUM(t.amount) AS total_spending
    FROM accounts a
    JOIN transactions t
        ON a.account_id = t.account_id
    WHERE t.transaction_type = 'Expense'
    GROUP BY a.user_id
)
SELECT
    u.first_name,
    u.last_name,
    us.total_spending
FROM users u
JOIN user_spending us
    ON u.user_id = us.user_id
ORDER BY us.total_spending DESC;


-- 8. Rank users by spending
SELECT
    u.first_name,
    u.last_name,
    SUM(t.amount) AS total_spending,
    RANK() OVER (
        ORDER BY SUM(t.amount) DESC
    ) AS spending_rank
FROM users u
JOIN accounts a
    ON u.user_id = a.user_id
JOIN transactions t
    ON a.account_id = t.account_id
WHERE t.transaction_type = 'Expense'
GROUP BY u.user_id, u.first_name, u.last_name;