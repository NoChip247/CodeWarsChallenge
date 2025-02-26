## Description

For this challenge you need to create a simple SELECT statement that will return all columns from the people table, and join to the sales table so that you can return the COUNT of all sales and RANK each person by their sale_count.

### `people` Table Schema

- `id`
- `name`

### `sales` Table Schema

- `id`
- `people_id`
- `sale`
- `price`

### Solution

```sql
SELECT
    p.*,
    COUNT(s.id) AS sale_count,
    RANK() OVER (ORDER BY COUNT(s.id) DESC) AS sale_rank
FROM
    people AS p
LEFT JOIN
    sales AS s
ON
    p.id = s.people_id
GROUP BY
    p.id, p.name
ORDER BY
    sale_rank;
```
