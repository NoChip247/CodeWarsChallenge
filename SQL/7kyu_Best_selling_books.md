## Description

You work at a book store. It's the end of the month, and you need to find out the 5 bestselling books at your store. Use a select statement to list names, authors, and number of copies sold of the 5 books which were sold most.

### `books` Table Schema

- `name`
- `author`
- `copies_sold`

### Solution

```sql
SELECT * 
FROM books
ORDER BY copies_sold DESC
LIMIT 5;
```
