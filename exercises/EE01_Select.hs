module EE01_Select where

import Data.Text (Text)
import Database.Esqueleto
import Schema
import Types

{-
Congratulations on becoming the new proprietor of the local Stonecold's ice
cream parlor franchise. I'm from the corporate office and will just have a few
questions as you're getting started. Since I'm more on the business side, I
know SQL well...but Haskell is a bridge too far.

Using esqueleto, can you get me everything we know about our flavors?

The equivalent SQL would be:
SELECT * FROM flavors;
-}
allFlavors :: DB [Entity Flavor]
allFlavors = do
  _

{-
Actually I just want the flavor names. That would be:
SELECT flavors.name FROM flavors;
-}
allFlavorNames :: DB [Text]
allFlavorNames = do
  _
