module EE03_val where

import Database.Esqueleto.Experimental

-- think about why we need a SqlExpr and not just Value here
val :: PersistField typ => typ -> SqlExpr (Value typ)
val = undefined
