module EE03_select where

import Control.Monad.IO.Class (MonadIO)
import Database.Esqueleto.Experimental
import Database.Esqueleto.Internal.Internal (SqlSelect)

select :: (SqlSelect a r, MonadIO m, SqlBackendCanRead backend) => SqlQuery a -> DB [r]
select = undefined
