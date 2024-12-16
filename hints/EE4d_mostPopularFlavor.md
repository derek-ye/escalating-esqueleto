First, read the error carefully.

Recall that any kind of `JOIN` is always a good place to think about nullability.

The type of `countRows` is `countRows :: Num a => SqlExpr (Value a)`. The `a` here is not concrete!
