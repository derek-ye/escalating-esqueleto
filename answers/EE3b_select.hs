{- HLINT ignore "Use camelCase" -}
module EE3b_select where

import Database.Esqueleto.Experimental
import Database.Esqueleto.Internal.Internal (SqlSelect)
import Types (DB)

b_select :: (SqlSelect a r) => SqlQuery a -> DB [r]
b_select = undefined
