USE LedgerX;

-- View containing complete transaction details
CREATE OR REPLACE VIEW transaction_report AS
SELECT
    u.first_name,
    u.last_name,
    a.account_name,
    c.category_name,
    t.amount,
    t.transaction_type,
    t.transaction_date,
    t.description,
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