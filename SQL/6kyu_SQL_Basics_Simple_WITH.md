## Description

For this challenge, you need to create a `SELECT` statement that uses an `IN` clause to check whether a department has had a sale with a price over 90.00 dollars. However, the SQL must utilize the `WITH` statement to define a subquery named `special_sales`, which selects all columns from the `sales` table where the price is greater than 90.00.

### `departments` Table Schema

- `id`
- `name`

### `sales` Table Schema

- `id`
- `department_id` (foreign key referencing `departments`)
- `name`
- `price`
- `card_name`
- `card_number`
- `transaction_date`

### `return` Table Schema

- `id`
- `name`
---
### Solution

```sql
WITH special_sales AS (
  SELECT
    *
  FROM sales
  WHERE price > 90
)

SELECT
  d.id,
  d.name
FROM departments AS d
WHERE d.id IN (
  SELECT department_id
  FROM special_sales
)
