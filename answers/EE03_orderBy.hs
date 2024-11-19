module EE03_orderBy where

import Database.Esqueleto.Experimental

orderBy :: [SqlExpr OrderBy] -> SqlQuery ()
orderBy = undefined
