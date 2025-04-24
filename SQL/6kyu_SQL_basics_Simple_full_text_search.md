## Description

For this challenge, you need to create a simple `SELECT` statement. Your task is to perform a **full-text search** on the `product` table, specifically targeting the `name` field, to find all rows containing the word **"Awesome"**.

Your query must utilize PostgreSQL's full-text search functions: `to_tsvector` and `to_tsquery`.

### `product` Table Schema

- `id`
- `name`
- *(other columns as applicable)*

### `return` Table Schema

- All columns from the `product` table where the `name` matches the search criteria.

## Solution

```sql
SELECT *
FROM product
WHERE to_tsvector('english', name) @@ to_tsquery('english', 'awesome');
