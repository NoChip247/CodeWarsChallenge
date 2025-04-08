## Description

For this challenge, you need to create a `SELECT` statement. This statement should use an `IN` clause to check whether a department has had a sale with a price over 98.00 dollars.

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

### Solution

```sql
SELECT 
    id,
    name
FROM departments
WHERE id IN (
    SELECT department_id
    FROM sales
    WHERE price > 98.00
)
```
