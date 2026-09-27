-- Digital Wallet Analytics — Onboarding Funnel & Channel Performance
-- Dataset: simulated (see README for full disclosure)

-- Step-by-step conversion rate through the onboarding funnel
-- (phone verification -> KYC submission -> KYC approval -> first top-up -> first payment)
SELECT
ROUND(COUNT(phone_verified_ts) *1.0 / COUNT(user_id) *100, 1),
ROUND(COUNT(kyc_submitted_ts) *1.0 / COUNT(phone_verified_ts) *100, 1),
ROUND(COUNT(kyc_approved_ts) *1.0 / COUNT(kyc_submitted_ts) *100, 1),
ROUND(COUNT(first_topup_ts) *1.0 / COUNT(kyc_approved_ts) *100, 1),
ROUND(COUNT(first_payment_ts) *1.0 / COUNT(first_topup_ts) *100, 1)
FROM funnel_events;
-- Result: (86.2, 63.9, 88.2, 71.5, 75.2)
-- KYC submission is the worst-performing single step at 63.9%.


-- Signups per channel (denominator for conversion rate below)
SELECT COUNT(signup_ts), channel
FROM users
GROUP BY channel;
-- Result: [(3507, 'field_agent'), (8255, 'organic'), (7491, 'paid_social'), (4747, 'referral')]


-- Conversion rate per channel: % of signups on that channel who ever completed a first top-up
SELECT channel, ROUND(COUNT(first_topup_ts) *1.0 / COUNT(signup_ts) *100, 1) AS 'Percentage'
FROM users AS A
LEFT JOIN
funnel_events AS B
ON
A.user_id = B.user_id
GROUP BY
channel
ORDER BY
Percentage
DESC;
-- Result: [('field_agent', 47.9), ('referral', 45.2), ('organic', 35.4), ('paid_social', 21.2)]


-- Actual number of activated users (completed first top-up) per channel
SELECT COUNT(first_topup_ts) AS 'First_Topups', channel
FROM users AS A
LEFT JOIN
funnel_events AS B
ON
A.user_id = B.user_id
GROUP BY channel
ORDER BY
First_Topups
DESC;
-- Result: [(2921, 'organic'), (2146, 'referral'), (1681, 'field_agent'), (1589, 'paid_social')]
-- Organic brings in the most activated users in absolute terms, despite a lower conversion rate
-- than field_agent or referral.
