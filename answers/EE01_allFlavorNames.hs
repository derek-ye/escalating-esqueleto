module EE01_allFlavorNames where

import Data.Text (Text)
import Database.Esqueleto.Experimental
import Schema
import Types

allFlavorNames :: DB [Text]
allFlavorNames = do
  values <- select $ do
    flavor <- from $ table @Flavor
    pure $ flavor.name
  pure $ map unValue values
