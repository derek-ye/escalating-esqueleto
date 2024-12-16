The type of `flavor.name` is `SqlExpr (Value Text)`

Can we `unValue` a `Value` wrapped in `SqlExpr`?

--

In the `fmap` version of the line, it turns out one issue is that `SqlExpr` doesn't have an instance of `Functor`. I actually think the error message is pretty good, and recommend reading it.

```hs
pure $ fmap unValue flavor.name
```
