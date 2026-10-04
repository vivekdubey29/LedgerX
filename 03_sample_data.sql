USE LedgerX;

INSERT INTO users (first_name, last_name, email, phone)
VALUES
('Rahul', 'Sharma', 'rahul@gmail.com', '9876543210'),
('Priya', 'Verma', 'priya@gmail.com', '9876543211'),
('Amit', 'Singh', 'amit@gmail.com', '9876543212'),
('Neha', 'Gupta', 'neha@gmail.com', '9876543213'),
('Vivek', 'Kumar', 'vivek@gmail.com', '9876543214');

INSERT INTO accounts (user_id, account_name, account_type, balance)
VALUES
(1, 'Rahul Savings', 'Savings', 50000.00),
(1, 'Rahul Wallet', 'Wallet', 5000.00),
(2, 'Priya Savings', 'Savings', 75000.00),
(3, 'Amit Current', 'Current', 40000.00),
(4, 'Neha Savings', 'Savings', 60000.00),
(5, 'Vivek Savings', 'Savings', 30000.00);

INSERT INTO categories (category_name, category_type)
VALUES
('Salary', 'Income'),
('Freelance', 'Income'),
('Food', 'Expense'),
('Travel', 'Expense'),
('Shopping', 'Expense'),
('Bills', 'Expense'),
('Education', 'Expense');

INSERT INTO transactions
(account_id, category_id, amount, transaction_type, transaction_date, description)
VALUES
(1, 1, 45000.00, 'Income', '2026-09-01', 'Monthly salary'),
(1, 3, 1200.00, 'Expense', '2026-09-03', 'Groceries'),
(2, 4, 2500.00, 'Expense', '2026-09-05', 'Trip expense'),
(3, 1, 55000.00, 'Income', '2026-09-01', 'Monthly salary'),
(4, 5, 3500.00, 'Expense', '2026-09-10', 'Online shopping'),
(5, 7, 5000.00, 'Expense', '2026-09-12', 'Course fee');

INSERT INTO payments
(transaction_id, payment_method, payment_status, payment_date)
VALUES
(1, 'Bank Transfer', 'Completed', '2026-09-01'),
(2, 'UPI', 'Completed', '2026-09-03'),
(3, 'Card', 'Completed', '2026-09-05'),
(4, 'Bank Transfer', 'Completed', '2026-09-01'),
(5, 'Card', 'Completed', '2026-09-10'),
(6, 'UPI', 'Completed', '2026-09-12');