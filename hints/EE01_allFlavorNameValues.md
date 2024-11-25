Try starting from the "extensible" answer to the `allFlavors` exercise:

```hs
allFlavors :: DB [Entity Flavor]
allFlavors = do
  select $ do
    from $ table @Flavor
```

You can look in the `schema.persistentmodels` file to find the fields of a `Flavor`

This exercise makes use of the `OverloadedRecordDot` language extension. This lets you do `customer.email` to project a `Value` from an `Entity`.
