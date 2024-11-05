Think about which kind of `JOIN` to use. Which values do we have in hand? Which ones might not exist? Which Haskell values do we want to be `Maybe`s in the end?

Often, if you get the type of join right, handling `Maybe` values throughout your query becomes much easier.

See the "Joins" section of
https://hackage.haskell.org/package/esqueleto-3.5.13.0/docs/Database-Esqueleto-Experimental.html#g:6
