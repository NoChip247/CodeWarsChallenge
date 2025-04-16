## Description

Oh no! Timmy's been moved into the database division of his software company — but as we know, Timmy loves making mistakes. Help Timmy keep his job by fixing his query...

Timmy works for a statistical analysis company and has been given a task: total the number of sales on a given day, grouped by each department name and then by each day.

Tables and relationship below:

![](https://github.com/NoChip247/CodeWarsChallenge/blob/main/assets/Capture%20d'%C3%A9cran%202025-04-16%20093238.png)

### Timmy's not working query:
```sql
SELECT 
  s.transaction_date as day,
  d.name,
  COUNT(s.id)
  FROM department d
    JOIN sale s on d.id = s.id
  group by day, d.name
  order by name desc
```

### Resultant table:
- `day` (type: date) — grouped by, ordered ascending
- `department` (type: text) — grouped by _(Note: In a real-world situation, it's bad practice to name a column after a table)_
- `sale_count` (type: int)

### Solution

```sql
SELECT
  CAST(s.transaction_date AS DATE) AS day,
  d.name AS department,
  COUNT(s.id) AS sale_count
FROM sale AS s
LEFT JOIN department AS d
  ON s.department_id = d.id
GROUP BY CAST(s.transaction_date AS DATE), d.name
ORDER BY day ASC;
```
