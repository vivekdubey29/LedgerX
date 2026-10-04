USE LedgerX;

-- 1. INNER JOIN: Users and Accounts
SELECT
    u.first_name,
    u.last_name,
    a.account_name,
    a.balance
FROM users u
JOIN accounts a
    ON u.user_id = a.user_id;


-- 2. LEFT JOIN: All users and their accounts
SELECT
    u.first_name,
    u.last_name,
    a.account_name,
    a.balance
FROM users u
LEFT JOIN accounts a
    ON u.user_id = a.user_id;


-- 3. RIGHT JOIN: All users and matching accounts
SELECT
    a.account_name,
    u.first_name,
    a.balance
FROM accounts a
RIGHT JOIN users u
    ON a.user_id = u.user_id;


-- 4. Multi-table JOIN
SELECT
    u.first_name,
    a.account_name,
    t.amount,
    c.category_name
FROM users u
JOIN accounts a
    ON u.user_id = a.user_id
JOIN transactions t
    ON a.account_id = t.account_id
JOIN categories c
    ON t.category_id = c.category_id;


-- 5. JOIN all five tables
SELECT
    u.first_name,
    a.account_name,
    c.category_name,
    t.amount,
    t.transaction_type,
    p.payment_method,
    p.payment_status
FROM users u
JOIN accounts a
    ON u.user_id = a.user_id
JOIN transactions t
    ON a.account_id = t.account_id
JOIN categories c
    ON t.category_id = c.category_id
JOIN payments p
    ON t.transaction_id = p.transaction_id;


-- 6. Sort transactions by amount
SELECT
    u.first_name,
    c.category_name,
    t.amount,
    t.transaction_type
FROM users u
JOIN accounts a
    ON u.user_id = a.user_id
JOIN transactions t
    ON a.account_id = t.account_id
JOIN categories c
    ON t.category_id = c.category_id
ORDER BY t.amount DESC;


-- 7. Completed payments
SELECT
    u.first_name,
    a.account_name,
    t.amount,
    p.payment_method,
    p.payment_status
FROM users u
JOIN accounts a
    ON u.user_id = a.user_id
JOIN transactions t
    ON a.account_id = t.account_id
JOIN payments p
    ON t.transaction_id = p.transaction_id
WHERE p.payment_status = 'Completed';


-- 8. Total spending by user
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
ORDER BY total_spending DESC;


-- 9. Total income by user
SELECT
    u.first_name,
    u.last_name,
    SUM(t.amount) AS total_income
FROM users u
JOIN accounts a
    ON u.user_id = a.user_id
JOIN transactions t
    ON a.account_id = t.account_id
WHERE t.transaction_type = 'Income'
GROUP BY u.user_id, u.first_name, u.last_name
ORDER BY total_income DESC;


-- 10. Income vs spending by user
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
    END) AS total_spending
FROM users u
JOIN accounts a
    ON u.user_id = a.user_id
JOIN transactions t
    ON a.account_id = t.account_id
GROUP BY u.user_id, u.first_name, u.last_name;


-- 11. Net balance by user
SELECT
    u.first_name,
    u.last_name,
    SUM(
        CASE
            WHEN t.transaction_type = 'Income' THEN t.amount
            ELSE -t.amount
        END
    ) AS net_balance
FROM users u
JOIN accounts a
    ON u.user_id = a.user_id
JOIN transactions t
    ON a.account_id = t.account_id
GROUP BY u.user_id, u.first_name, u.last_name
ORDER BY net_balance DESC;


-- 12. Users spending above ₹3,000
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
HAVING total_spending > 3000;


-- 13. Highest-spending user
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
ORDER BY total_spending DESC
LIMIT 1;


-- 14. Largest transaction
SELECT
    u.first_name,
    u.last_name,
    t.amount,
    t.transaction_type,
    t.description
FROM users u
JOIN accounts a
    ON u.user_id = a.user_id
JOIN transactions t
    ON a.account_id = t.account_id
ORDER BY t.amount DESC
LIMIT 1;


-- 15. Largest expense
SELECT
    u.first_name,
    u.last_name,
    t.amount,
    c.category_name,
    t.description
FROM users u
JOIN accounts a
    ON u.user_id = a.user_id
JOIN transactions t
    ON a.account_id = t.account_id
JOIN categories c
    ON t.category_id = c.category_id
WHERE t.transaction_type = 'Expense'
ORDER BY t.amount DESC
LIMIT 1;


-- 16. Accounts with no transactions
SELECT
    a.account_name,
    a.balance
FROM accounts a
LEFT JOIN transactions t
    ON a.account_id = t.account_id
WHERE t.transaction_id IS NULL;


-- 17. Users with no transactions
SELECT
    u.first_name,
    u.last_name
FROM users u
LEFT JOIN accounts a
    ON u.user_id = a.user_id
LEFT JOIN transactions t
    ON a.account_id = t.account_id
WHERE t.transaction_id IS NULL;


-- 18. Users with an account but no transactions
SELECT
    u.first_name,
    u.last_name,
    a.account_name
FROM users u
JOIN accounts a
    ON u.user_id = a.user_id
LEFT JOIN transactions t
    ON a.account_id = t.account_id
WHERE t.transaction_id IS NULL;


-- 19. Users without an account (RIGHT ANTI JOIN)
SELECT
    u.first_name,
    u.last_name
FROM accounts a
RIGHT JOIN users u
    ON a.user_id = u.user_id
WHERE a.account_id IS NULL;