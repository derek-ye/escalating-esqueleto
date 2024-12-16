module EE3b_select where

import Control.Monad.IO.Class (MonadIO)
import Database.Esqueleto.Experimental
import Database.Esqueleto.Internal.Internal (SqlSelect)

b_select :: (SqlSelect a r, MonadIO m, SqlBackendCanRead backend) => SqlQuery a -> DB [r]
b_select = undefined
