## Description

For this challenge you need to create a UNION statement, there are two tables `ussales` and `eusales`. The parent company tracks each sale at its respective location in each table. You must also filter the sale price so it only returns rows with a sale greater than 50.00. You have been tasked with combining that data for future analysis. Order by location (US before EU), then by id.

### `(us/eu)sales` Table Schema

- `id`
- `name`
- `price`
- `card_name`
- `card_number`
- `transaction_date`

### Resultant Table Schema

- `location` (EU for `eusales` and US for `ussales`)
- `id`
- `name`
- `price` (greater than 50.00)
- `card_name`
- `card_number`
- `transaction_date`

### Solution

```sql
SELECT
    'US' as location,
    *
FROM
    ussales 
WHERE
    price > 50 

UNION ALL 

SELECT
    'EU' as location,
    *
FROM
    eusales 
WHERE
    price > 50 

ORDER BY
    location DESC, id ASC;
```
