-- Digital Wallet Analytics — Payment Reliability
-- Dataset: simulated (see README for full disclosure)

-- Overall failure rate across all transactions
SELECT ROUND(COUNT(failure_reason) *1.0 / COUNT(txn_id) *100, 1)
FROM transactions;
-- Result: [(4.2,)]


-- Card top-up failure rate broken down by issuer
SELECT ROUND(COUNT(failure_reason) *1.0 / COUNT(txn_id) * 100, 1), issuer
FROM transactions
WHERE rail = 'card_topup'
GROUP BY issuer;
-- Result: [(7.6, 'Bank A'), (7.5, 'Bank B'), (10.7, 'Bank C'), (6.9, 'Bank D'), (8.2, 'Other')]
-- Bank C's failure rate is somewhat higher than its peers but not dramatically so on its own —
-- worth a closer look over time.


-- Bank C's card top-up failure rate, broken down by month
SELECT ROUND(COUNT(failure_reason) *1.0 / COUNT(txn_id) *100, 1), SUBSTR(ts, 1, 7) AS Month
FROM transactions
WHERE rail = 'card_topup'
AND issuer = 'Bank C'
GROUP BY Month;
-- Result: [(10.3,'2026-03'),(6.4,'2026-04'),(8.1,'2026-05'),(7.8,'2026-06'),(22.0,'2026-07'),(7.3,'2026-08')]
-- July spikes to 22.0% and drops back to 7.3% in August — a time-boxed incident, not a trend.
