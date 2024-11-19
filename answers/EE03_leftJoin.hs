module EE03_leftJoin where

import Database.Esqueleto.Experimental
import Database.Esqueleto.Experimental.From (ToFrom)
import Database.Esqueleto.Experimental.From.Join (HasOnClause)

leftJoin :: (ToFrom a a', ToFrom b b', ToMaybe b', HasOnClause rhs (a' :& ToMaybeT b'), rhs ~ (b, (a' :& ToMaybeT b') -> SqlExpr (Value Bool))) => a -> rhs -> From (a' :& ToMaybeT b')
leftJoin = undefined
