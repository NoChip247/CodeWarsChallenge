## Description

Given a `payment` table, which is part of the DVD Rental Sample Database, with the following schema:

### `payment` Table Schema

- `payment_id` (integer, not null)
- `customer_id` (smallint, not null)
- `staff_id` (smallint, not null)
- `rental_id` (integer, not null)
- `amount` (numeric(5,2), not null)
- `payment_date` (timestamp without time zone, not null)

Produce a result set for the report that shows a side-by-side comparison of the number and total amounts of payments made in Mike's and Jon's stores, broken down by months.

The resulting data set should be ordered by month using natural order (Jan, Feb, Mar, etc.).

> Note: You don't need to worry about the year component. Months are never repeated because the sample data set contains payment information only for one year.

### `return` Table Schema

- `month` — number of the month (1 = January, 2 = February, etc.)
- `total_count` — total number of payments
- `total_amount` — total payment amount
- `mike_count` — number of payments accepted by Mike (`staff_id = 1`)
- `mike_amount` — amount of payments accepted by Mike
- `jon_count` — number of payments accepted by Jon (`staff_id = 2`)
- `jon_amount` — amount of payments accepted by Jon

### Solution

```sql
SELECT
  EXTRACT(MONTH FROM payment_date) AS month,
  COUNT(payment_id) AS total_count,
  SUM(amount) AS total_amount,
  COUNT(CASE WHEN staff_id = 1 THEN 1 END) AS mike_count,
  SUM(CASE WHEN staff_id = 1 THEN amount END) AS mike_amount,
  COUNT(CASE WHEN staff_id = 2 THEN 1 END) AS jon_count,
  SUM(CASE WHEN staff_id = 2 THEN amount END) AS jon_amount
FROM payment
GROUP BY EXTRACT(MONTH FROM payment_date)
ORDER BY month
