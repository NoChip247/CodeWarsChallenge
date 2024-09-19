Write function RemoveExclamationMarks which removes all exclamation marks from a given string.

You are given a table `removeexclamationmarks` with column `s`, return a table with column `s` and your result in a column named `res`.

---

### Solution

```sql
SELECT
  s,
  REGEXP_REPLACE(s, '!', '', 'g') AS res
FROM removeexclamationmarks
```
