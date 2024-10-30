{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE UndecidableInstances #-}

module Schema where

import Data.UUID (UUID)
import Database.Persist.TH (mkPersist, persistFileWith, share, sqlSettings)
import Database.Persist.Quasi (lowerCaseSettings)
import Data.Text (Text)
import Data.Time.Clock (UTCTime)
import Types

-- This uses Template Haskell to load in the schema.persistentmodels file
-- It creates Haskell types from the models listed there
share [mkPersist sqlSettings]
  $(persistFileWith lowerCaseSettings "lib/schema.persistentmodels")
