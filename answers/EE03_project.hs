module EE03_project where

import Database.Esqueleto.Experimental

(?.) :: (PersistEntity val, PersistField typ) => SqlExpr (Maybe (Entity val)) -> EntityField val typ -> SqlExpr (Value (Maybe typ))
(?.) = undefined
