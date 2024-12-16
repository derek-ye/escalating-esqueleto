`customer.birthday` and `customer.favoriteFlavor` are both `Maybe`s

Because `where_` takes a `Bool` (really, a `SqlExpr (Value Bool)`), we need a function `Maybe a -> Bool` (really, as `SqlExpr`s)

Hoogle for:

```hs
SqlExpr (Value (Maybe a)) -> SqlExpr (Value Bool)
```
