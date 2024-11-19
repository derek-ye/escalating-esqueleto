A good exploratory query to figure out how these "links" work could be:

```sql
select parent_id, count(*) from customer_links group by parent_id;
```

Once you've figured that out, note that you can use that information inside a subquery SELECT to get all the relevant customer IDs.

```sql
select customer_id from customer_links where parent_id = (select parent_id from customer_links group by parent_id order by count(*) desc limit 1);
```

From there, you should be able to finesse those IDs into the actual `Entity`s.
