## Challenge Description

For this challenge, you need to create a simple `SELECT` statement that will return all columns from the `products` table and join it to the `companies` table so that you can return the company name.

### Tables Schema

#### Products Table

- `id`
- `name`
- `isbn`
- `company_id`
- `price`

#### Companies Table

- `id`
- `name`

### Output Requirements

You should return all product fields as well as the company name as `company_name`.

### Solution

```sql
SELECT
  p.*,
  c.name AS company_name
FROM products AS p
LEFT JOIN companies AS c
ON p.company_id = c.id
```
