## Description:

Given a number n, return the number of positive odd numbers below n. You are given a table 'oddcount' with column 'n', return a table with column 'n' and your result in a column named 'res'.

### Example:

7 -> 3 (because odd numbers below 7 are [1, 3, 5])
15 -> 7 (because odd numbers below 15 are [1, 3, 5, 7, 9, 11, 13])

---

### Solution

```sql
SELECT
  n,
  (n / 2) AS res
FROM oddcount
```
Pour connaitre la solution, on divise n par 2, car la moitié de n est forcément impaire. Par exemple si n=10, 10/2=5, en dessous de 10 il y a bien 5 nombres impaires (1, 3, 5, 7, 9). La division fonctionne même sir n est un nombre impaire (7, 15, 33, etc) car en SQL, la division est toujours entière (les décimales sont ignorées).
