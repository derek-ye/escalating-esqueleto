module EE04_flavorNameValues where

import Data.Text (Text)
import Database.Esqueleto.Experimental
import Schema
import Types

flavorNameValues :: DB [Value Text]
flavorNameValues = do
  select $ do
    flavor <- from $ table @Flavor
    pure flavor.name
