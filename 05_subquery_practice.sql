-- Digital Wallet Analytics — Subquery practice
-- Standalone practice queries demonstrating three subquery patterns, run against the same dataset.
-- Dataset: simulated (see README for full disclosure)

-- Scalar subquery: transactions above the average transaction amount
SELECT txn_id FROM transactions
WHERE amount_egp > (
SELECT AVG(amount_egp) FROM transactions);
-- Result: 23,626 matching rows


-- NOT IN subquery: users who never made a transaction
SELECT COUNT(user_id) FROM users WHERE user_id NOT IN (SELECT user_id FROM transactions);
-- Result: [(15915,)]
-- (24,000 - 15,915 = 8,085 users who did transact, consistent with 04_retention_and_activation.sql)


-- IN subquery: transactions belonging to users on Android app version 3.2
SELECT COUNT(user_id) FROM transactions WHERE user_id IN (SELECT user_id FROM users WHERE app_version = '3.2');
-- Result: [(14870,)]
