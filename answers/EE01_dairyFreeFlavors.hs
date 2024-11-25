module EE01_dairyFreeFlavors where

import Database.Esqueleto.Experimental
import Schema
import Types

dairyFreeFlavors :: DB [Entity Flavor]
dairyFreeFlavors = do
  select $ do
    flavor <- from $ table @Flavor
    where_ flavor.dairyFree
    -- You might have instead done something like this, which will work but is more verbose:
    -- where_ $ flavor.dairyFree ==. val True
    pure flavor
