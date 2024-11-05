Try writing a plain SQL query on your own first, then come back here.

Here's one way to do it:

```sql
SELECT f.name, count(*)
FROM customers c
INNER JOIN flavors f
ON c.favorite_flavor = f.id
GROUP BY f.id
ORDER BY count DESC;
```

Think about how each of these pieces translates into esqueleto. Then, try writing the esqueleto version of the query without referencing the SQL version directly, if you can.
