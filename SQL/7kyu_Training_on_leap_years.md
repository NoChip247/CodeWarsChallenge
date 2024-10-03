## Leap Year Kata

In this kata, you should simply determine whether a given year is a leap year or not. In case you don't know the rules, here they are:

- Years divisible by 4 are leap years.
- Years divisible by 100 are not leap years.
- Years divisible by 400 are leap years.

### Tested Years

The tested years are in the range **1600 ≤ year ≤ 4000**.

### Database Schema

The `years` table has two columns:

- `id`
- `year`

### Query Requirements

Your query has to return rows with two columns:

- `year`
- `is_leap`

The returned rows have to be sorted in ascending order by the `year`.


### Solution

```sql
SELECT
  year,
  CASE
    WHEN year % 400 = 0 THEN True
    WHEN year % 100 = 0 THEN False
    WHEN year % 4 = 0 THEN True
    ELSE False 
  END AS is_leap
FROM years
ORDER BY year ASC
```
