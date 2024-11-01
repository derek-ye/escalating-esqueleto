module EE01_allFlavors where

import Database.Esqueleto.Experimental
import Schema
import Types

-- They were delicious.
allFlavors :: DB [Entity Flavor]
allFlavors = do
  select $ from $ table @Flavor
