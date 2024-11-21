module EE04_flavorNames where

import Data.Coerce (coerce)
import Data.Text (Text)
import Database.Esqueleto.Experimental
import Schema
import Types

flavorNames :: DB [Text]
flavorNames = do
  fmap coerce $ select $ do
    flavor <- from $ table @Flavor
    pure $ flavor.name

