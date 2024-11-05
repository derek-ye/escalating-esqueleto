module EE01_customersWithoutBirthdaysWithFlavors where

import Database.Esqueleto.Experimental
import Schema
import Types

customersWithoutBirthdaysWithFlavors :: DB [Email]
customersWithoutBirthdaysWithFlavors = do
  emailValues <- select $ do
    customer <- from $ table @Customer
    -- Note that below I used multiple `where_` clauses. This is legal! You can also use the `&&.` (SQL `AND`) operator.
    where_ $ isNothing customer.birthday
    -- be careful about `IS NOT NULL` vs. `!= NULL` when negating isNothing
    -- see the docs: https://hackage.haskell.org/package/esqueleto-3.5.13.0/docs/Database-Esqueleto-Experimental.html#v:isNothing
    where_ . not_ $ isNothing customer.favoriteFlavor
    pure customer.email
  pure $ map unValue emailValues
