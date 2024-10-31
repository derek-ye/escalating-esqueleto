{-# LANGUAGE TypeApplications #-}

module EE01_Select where

import Data.Text (Text)
import Database.Esqueleto.Experimental
import Schema
import Types

allFlavors :: DB [Entity Flavor]
allFlavors = do
  select $ from $ table @Flavor
  -- select $ from $ table @Flavor

allFlavorNames :: DB [Text]
allFlavorNames = do
  flavors <- allFlavors
  -- TODO: should prob mention record dot quite early on
  pure $ map (flavorName . entityVal) flavors
