Write a function that returns the total surface area and volume of a box as an array: `[area, volume]`

- You are given a table 'box' with columns: width (int), height (int), depth (int)
- Return a query with columns: width, height, depth, area (int), volume (int)
- Sort results by area ascending, then volume ascending, then width ascending, then height ascending

---

# Solution

```sql
SELECT 
    width,
    height,
    depth,
    (2 * width * height + 2 * height * depth + 2 * width * depth) AS area,
    width * height * depth AS volume
FROM 
    box
ORDER BY 
    area ASC,
    volume ASC,
    width ASC,
    height ASC
```
