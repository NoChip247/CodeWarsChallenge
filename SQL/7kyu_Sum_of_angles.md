## Total Sum of Internal Angles in a Simple Polygon

### Description

Find the total sum of internal angles (in degrees) in an `n`-sided simple polygon. The value of `n` will always be greater than 2.

---

### Solution

```sql
SELECT
  (n - 2) * 180 AS res
FROM
  angle
