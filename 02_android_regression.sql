-- Digital Wallet Analytics — Android App Regression (v3.2)
-- Dataset: simulated (see README for full disclosure)

-- Overall KYC submission rate by operating system
SELECT device_os, ROUND(COUNT(kyc_submitted_ts) *1.0 / COUNT(A.user_id) *100, 1) AS Total_Percentage
FROM users AS A
LEFT JOIN funnel_events AS B
ON
A.user_id = B.user_id
GROUP BY device_os;
-- Result: [('android', 52.9), ('ios', 63.2)]
-- A ~10-point gap between Android and iOS is large enough to be worth investigating further.


-- KYC submission rate broken down by Android app version
SELECT app_version, ROUND(COUNT(kyc_submitted_ts) *1.0 / COUNT(signup_ts) *100, 1) AS Total_Percentage
FROM users AS A
LEFT JOIN funnel_events AS B
ON
A.user_id = B.user_id
WHERE
device_os = 'android'
GROUP BY app_version;
-- Result: [('3.1', 56.4), ('3.2', 41.4), ('3.2.1', 58.0)]
-- Version 3.2 stands out as a clear regression, recovered in the very next release (3.2.1).


-- KYC-upload-related support tickets per Android app version
SELECT app_version, COUNT(ticket_id) AS Total_Tickets
FROM users AS A
LEFT JOIN support_tickets AS B
ON A.user_id = B.user_id
WHERE
category = 'kyc_upload_problem' AND
device_os = 'android'
GROUP BY app_version
ORDER BY Total_Tickets DESC;
-- Result: [('3.2', 384), ('3.1', 138), ('3.2.1', 64)]
-- The spike in KYC-upload support tickets on 3.2 corroborates the drop in KYC submissions above —
-- two independent signals pointing to the same release.
