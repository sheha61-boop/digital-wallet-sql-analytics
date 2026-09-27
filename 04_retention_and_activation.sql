-- Digital Wallet Analytics — Retention & Activation
-- Dataset: simulated (see README for full disclosure)

-- Total number of users who ever completed a transaction (out of 24,000 total signups)
SELECT (
SELECT COUNT(DISTINCT user_id) FROM transactions);
-- Result: [(8085,)]
-- 8,085 / 24,000 = 33.7% of all signups ever transact. This is the single biggest issue the
-- whole analysis surfaces — bigger than any single funnel step or retention number below.


-- Of the users who ever transacted, % still active in the most recent 45 days of data
SELECT ROUND(
  (SELECT COUNT(DISTINCT user_id) FROM transactions WHERE ts > date('2026-08-31', '-45 days')) * 1.0
  / (SELECT COUNT(DISTINCT user_id) FROM transactions) * 100
, 1);
-- Result: [(67.1,)]
-- 67.1% active / 32.9% churned. Not alarming on its own — the real problem is upstream, at
-- activation (33.7%), not retention.
