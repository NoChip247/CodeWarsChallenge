# Description  
You need to build a pivot table **without using the `CROSSTAB` function**.  

You have two tables:  

- **products**  
- **details**  

The goal is to select a pivot table of products with counts of detail occurrences.  
Possible values of `details.value` are: `['good', 'ok', 'bad']`.  

The query should:  
- Return the product name, with separate counts for `good`, `ok`, and `bad`.  
- Order the results by product's name.  

### Model schema for the kata:  

Table 1
| product |
|---------|
| id |
| name |

Table 2
| details |
|---------|
| id |
| product_id |
| details |

### Output columns:  

- `name`  
- `good`  
- `ok`  
- `bad`  

---

### Solution  

```sql
SELECT
    p.name,
    COUNT(CASE WHEN d.detail = 'good' THEN 1 ELSE NULL END) AS good,
    COUNT(CASE WHEN d.detail = 'ok' THEN 1 ELSE NULL END) AS ok,
    COUNT(CASE WHEN d.detail = 'bad' THEN 1 ELSE NULL END) AS bad
FROM
    products p
JOIN
    details d ON p.id = d.product_id
GROUP BY
    p.name
ORDER BY
    p.name ASC
```
