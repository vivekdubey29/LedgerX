USE LedgerX;

-- Index for faster user-account lookups
CREATE INDEX idx_accounts_user
ON accounts(user_id);

-- Index for faster account-transaction lookups
CREATE INDEX idx_transactions_account
ON transactions(account_id);

-- Index for faster category-transaction lookups
CREATE INDEX idx_transactions_category
ON transactions(category_id);

-- Index for faster date-based transaction searches
CREATE INDEX idx_transactions_date
ON transactions(transaction_date);

-- Index for faster payment status searches
CREATE INDEX idx_payments_status
ON payments(payment_status);