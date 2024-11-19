module EE01_flavorIdsFromNames where

import Data.Text (Text)
import Data.Coerce (coerce)
import Database.Esqueleto.Experimental
import Schema
import Types

flavorIdsFromNames :: [Text] -> DB [FlavorId]
flavorIdsFromNames flavorNames = do
  -- `fmap coerce` goes from DB `[Value FlavorId]` to `DB [FlavorId]`
  fmap coerce $ select $ do
    flavor <- from $ table @Flavor
    -- consider what happens when a name in the list isn't a real flavor name
    where_ $ flavor.name `in_` valList flavorNames
    pure flavor.id

{-
take a look at the generated SQL:

SELECT "flavors"."id"
FROM "flavors"
WHERE "flavors"."name" IN (?, ?, ?)
; [PersistText "Chunky Chocolate",PersistText "Variegated Vanilla",PersistText "Smooth Strawberry"]

note that Esqueleto is interpolating `?` variables for us, to get outside arguments into the query
-}
