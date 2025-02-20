## Description

For this challenge you need to create a simple HAVING statement, you want to count how many people have the same age and return the groups with 10 or more people who have that age.

### `people` Table Schema

- `id`
- `name`
- `age`

### `return` Table Schema

- `age`
- `total_people`

### Solution

```sql
SELECT
    age,
    COUNT(*) AS total_people
FROM people
GROUP BY age
HAVING COUNT(*) >= 10;
```
