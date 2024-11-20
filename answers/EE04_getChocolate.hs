module EE04_getChocolate where

import Database.Esqueleto.Experimental
import Schema
import Types

getChocolate :: DB (Maybe (Entity Flavor))
getChocolate = do
  selectOne $ do
    flavor <- from $ table @Flavor
    -- (==.) and missing `val`
    where_ $ flavor.name ==. val "Chunky Chocolate"
    pure flavor
