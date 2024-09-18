Write a function which converts the input string to uppercase.

- You are given a table 'makeuppercase' with column 's'
- Return a table with column 's' and your result in a column named 'res'

---

### Solution

```sql
SELECT
  s,
  UPPER(s) AS res
FROM
  makeuppercase
```
