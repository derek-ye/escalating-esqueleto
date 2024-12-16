For the argument type:

Based on queries you've written, think about what fits here. It's often a do block, that composes a SQL query from smaller pieces....


For the return type:

`SqlSelect a r` provides a functional dependency between `a` and `r`. Can you guess what they mean?

```hs
class SqlSelect a r | a -> r, r -> a where
```

What type of data structure have our `select`s returned results as so far?
