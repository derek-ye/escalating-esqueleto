{-# OPTIONS_GHC -fdefer-type-errors #-}

module EE04_Errors where

import Data.Coerce (coerce)
import Database.Esqueleto.Experimental
import Schema
import Types

{-
A fairly common complaint from beginners to esqueleto is that the type errors
it produces can be hard to decipher. Practice reading the type errors generated
by the queries below, and fix the queries so they work as intended.

The queries may have multiple issues. Even if you spot an issue immediately,
try to fully understand what each type error is telling you, before fixing that
specific problem and moving on to the next.
-}

getChocolate :: DB (Maybe (Entity Flavor))
getChocolate = do
  selectOne $ do
    flavor <- from $ table @Flavor
    where_ $ flavor.name == "Chunky Chocolate"
    pure flavor

mostPopularFlavor :: DB (Maybe FlavorId)
mostPopularFlavor = do
  selectOne $ do
    (_customer :& flavor) <- from $
      table @Customer `innerJoin` table @Flavor
      `on` (\(customer :& flavor) -> customer.favoriteFlavor ==. flavor.id)
    groupBy flavor.id
    orderBy [desc countRows]
    pure flavor.id

customerPurchases :: DB [(CustomerId, Dollar)]
customerPurchases = do
  fmap coerce $ select $ do
    purchase <- from $ table @Purchase
    groupBy purchase.customerId
    pure (purchase.customerId, purchase.amount)
