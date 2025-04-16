## Description

Oh no! Timmy's been moved into the database division of his software company — but as we know, Timmy loves making mistakes. Help Timmy keep his job by fixing his query...

Timmy works for a statistical analysis company and has been given a task: calculate the highest average salary for a given job. The sample is compiled from 100 applicants, each with a job and a salary.

Timmy must display:
- each unique job
- the total average salary
- the total number of people
- the total salary

The result should be ordered by highest average salary. Timmy has some bugs in his query — help him fix it!

### `people` Table Schema

- `id`
- `name`

### `job` Table Schema

- `id`
- `people_id`
- `job_title`
- `salary`

### Timmy's not working query:
```sql
SELECT 
  j.jobs_title,
  SUM(j.salary) / COUNT(p) as average_salarys,
  COUNT(p.id) as total_peoples,
  SUM(j.salary),2 as total_salarys
  FROM people p
    JOIN job j
  GROUP BY j.job_title
  ORDER BY total_salarys
```

### `return` Table Schema

- `job_title` (unique)
- `average_salary` (float, 2 decimal places)
- `total_people` (int)
- `total_salary` (float, 2 decimal places)
---
### Solution

```sql
SELECT
  j.job_title,
  CAST(ROUND(AVG(j.salary), 2) AS FLOAT) AS average_salary,
  COUNT(p.id) AS total_people,
  CAST(ROUND(SUM(j.salary), 2) AS FLOAT) AS total_salary
FROM job AS j
LEFT JOIN people AS p
  ON j.people_id = p.id
GROUP BY j.job_title
ORDER BY ROUND(AVG(j.salary), 2) DESC
```
