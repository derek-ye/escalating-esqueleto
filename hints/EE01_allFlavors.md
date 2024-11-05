Use hoogle to find specific items within the `esqueleto` package.

Useful hoogle queries for this exercise:

```
from package:esqueleto
select package:esqueleto
table package:esqueleto
```

We can use the `TypeApplications` language extension to tell `table` what type to use. For example:

```hs
table @Customer
```
