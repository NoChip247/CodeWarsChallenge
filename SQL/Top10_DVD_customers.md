## Description

For this challenge, you will be using the DVD Rental database.

![DVD rental database schema](https://neon.tech/postgresqltutorial/printable-postgresql-sample-database-diagram.pdf)

You are working for a company that wants to reward its top 10 customers with a free gift. You have been asked to generate a simple report that returns the top 10 customers by total amount spent, ordered from highest to lowest. The total number of payments has also been requested.

### `customer` Table Schema

- `customer_id`
- `email`

### `payment` Table Schema

- `payment_id`
- `customer_id`
- `amount`

### `return` Table Schema

- `customer_id`
- `email`
- `payments_count`
- `total_amount`

### Solution

```sql
SELECT
    c.customer_id,
    c.email,
    COUNT(p.payment_id) AS payments_count,
    CAST(SUM(p.amount) AS FLOAT) AS total_amount
FROM customer AS c
LEFT JOIN payment AS p
ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.email
ORDER BY total_amount DESC
LIMIT 10
