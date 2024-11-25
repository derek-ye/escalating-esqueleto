Use hoogle to find specific items within the `esqueleto` package.

A few useful hoogle queries for this exercise:

```
from package:esqueleto

select package:esqueleto

table package:esqueleto
```


We're specifically using the versions from `Database.Esqueleto.Experimental`, which you can find with:

```
Database.Esqueleto.Experimental.from is:exact

Database.Esqueleto.Experimental.select is:exact

Database.Esqueleto.Experimental.table is:exact
```


We can use `@` syntax (from the `TypeApplications` language extension) to tell `table` what type to use. For example:

```hs
table @Customer
```
