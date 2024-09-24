## Result Set Columns:

- **status_group**: This column categorizes the applications into two groups: 'Rejected' and 'Approved'. We display 'Rejected' first. The categorization is based on the value of the `application_status` column in the applications table:
  - **Rejected**: Applications with an `application_status` value of 5 or lower.
  - **Approved**: Applications with an `application_status` value greater than 5.

- **application_num**: The number of applications in each status group. This column provides a count of applications that fall into the 'Rejected' or 'Approved' categories.
  - We always have to see both categories in the results, even if one or both of the counts is zero.

### Sample Data:

| application_id | application_status |
|----------------|--------------------|
| 1              | 3                  |
| 2              | 6                  |
| 3              | 4                  |
| 4              | 7                  |
| 5              | 5                  |
| 6              | 8                  |
| 7              | 2                  |
| 8              | 9                  |

### Expected Output:

| status_group  | application_num |
|---------------|-----------------|
| Rejected      | 4               |
| Approved      | 4               |


---

### Solution

```sql
SELECT
  CASE
    WHEN application_status >= 6 THEN 'Approved'
    ELSE 'Rejected'
  END AS status_group,
  COUNT(*) AS application_num
FROM applications
GROUP BY status_group
```
