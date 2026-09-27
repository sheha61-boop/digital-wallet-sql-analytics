# Digital Wallet SQL Analytics

SQL analysis of a simulated digital wallet dataset — onboarding funnel, channel performance, an Android app regression, payment reliability, and user retention.

## About this project

This project analyzes a simulated dataset (no real company, customers, or transactions involved) covering 24,000 signups over a 6-month period. The goal was to answer four questions: how efficient are the onboarding channels, where do users drop off in the funnel, how reliable are payment methods, and do users who transact keep coming back.

The full write-up, with all findings and recommendations, is here: **[Digital Wallet Analytics Case Study](https://claude.ai/artifact/AwVkdDNfjgUuxSfDGDJJ7j)**

## Files

- `01_onboarding_funnel_and_channels.sql` — funnel step conversion rates and channel performance
- `02_android_regression.sql` — the Android v3.2 KYC regression
- `03_payment_reliability.sql` — payment failure rates by issuer and the Bank C incident
- `04_retention_and_activation.sql` — activation rate and 45-day retention
- `05_subquery_practice.sql` — scalar, IN, and NOT IN subquery examples
- `practice.db` — the SQLite dataset these queries run against

To run any query yourself: open `practice.db` with any SQLite client, or from the command line run `sqlite3 practice.db` in this folder, then paste in a query.

## Key findings

- Only 33.7% of signups ever completed a transaction — the project's core finding
- KYC submission is the single worst-performing funnel step (63.9%)
- Android app version 3.2 caused a measurable drop in KYC completions, fixed in the next release
- A one-month payment failure spike (22%) was isolated to a single banking partner and resolved by month's end
- Of users who did transact, 67.1% were still active within a 45-day window

## Skills demonstrated

Multi-table joins, GROUP BY aggregation, aggregate functions (COUNT, MIN, MAX, AVG), date-based trend analysis, and subqueries (scalar, IN, NOT IN).
