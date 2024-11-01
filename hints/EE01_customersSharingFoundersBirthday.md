While you'll eventually want to think natively in esqueleto, for now you could try writing a working SQL query first, then translating.

One way to do this in SQL could be:

```sql
SELECT birthday
FROM customers
WHERE date_part('month', birthday) = 4
  AND date_part('day'  , birthday) = 17;
```

Sometimes, esqueleto doesn't have an existing function for the SQL function you want. How can we add this?

We use Haskell wrappers around raw SQL to get typechecked SQL in Haskell syntax...this is the whole point of esqueleto!
