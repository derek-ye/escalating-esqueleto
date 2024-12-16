The `HasField` instance for record dot notation (like `f.name`) only has an instance for a `SqlExpr (Entity rec)`, not for any `Entity rec`.

We need to use this record dot notation in a place where we have `SqlExpr` wrapping our `Entity`s and `Value`s.

Search for `OverloadedRecordDot` in the [source](https://hackage.haskell.org/package/esqueleto-3.5.13.0/docs/src/Database.Esqueleto.Internal.Internal.html) to see the actual `HasField` instances.
