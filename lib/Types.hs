{-# LANGUAGE ImportQualifiedPost #-}
{-# LANGUAGE OverloadedStrings #-}

{-# OPTIONS_GHC -fno-warn-orphans #-}

module Types where

import Control.Monad.IO.Class (liftIO)
import Control.Monad.Logger (runStdoutLoggingT, LoggingT)
import Data.UUID (UUID, fromASCIIBytes, toASCIIBytes, toText, fromText)
import Database.Esqueleto.Experimental
import Database.Esqueleto.Internal.Internal (renderQueryToText, Mode(..))
import Database.Persist
  ( PersistField(..)
  , PersistValue(PersistLiteral_)
  , LiteralType(Escaped)
  , SqlType(SqlOther)
  )
import Database.Persist.Postgresql
  ( ConnectionString
  , withPostgresqlConn
  )
import Database.Persist.Sql
  ( PersistFieldSql(..)
  , SqlPersistT
  , runSqlConn
  )
import Data.Text qualified as T
import Data.Text (Text)
import System.Exit (exitFailure)
import Web.PathPieces (PathPiece(..))

-- CUSTOM TYPES --

-- 'PersistField' lets us convert a type (in this case a 'UUID') to and from a 'PersistValue'
-- 'PersistValue's can be stored in the database
instance PersistField UUID where
  -- A 'UUID' is a literal, escaped, collction of ASCII bytes
  toPersistValue = PersistLiteral_ Escaped . toASCIIBytes

  -- If we see a 'PersistLiteral_ Escaped', there's a chance it's a 'UUID'. Keep going.
  fromPersistValue (PersistLiteral_ Escaped uuid) =
    case fromASCIIBytes uuid of
      -- Errors if the UUID format is invalid
      Nothing -> Left $ "Types.hs: Failed to deserialize a UUID. Instead received: " <> tshow uuid
      -- Parses out a UUID if the format is valid
      Just uuid' -> Right uuid'
  -- Any other kind of 'PersistValue' is unexpected
  fromPersistValue x = Left $ "Types.hs: When trying to deserialize a UUID: expected PersistDbSpecific, received: " <> tshow x

-- Helper to convert Show-ables to Text
tshow :: Show a => a -> Text
tshow = T.pack . show

-- 'PersistFieldSql' tells the database what database-level type to use for a Haskell type
-- Postgres supplies a 'uuid' type, so we can use that for a Haskell 'UUID'
instance PersistFieldSql UUID where
  sqlType _ = SqlOther "uuid"

instance PathPiece UUID where
  toPathPiece = toText
  fromPathPiece = fromText


-- DB MONAD --

-- This type for DB is not very safe. It allows nested 'runDB's and lifting of arbitrary IO actions.
-- It's also not thread-safe, ideally it would use a Pool of connections rather than one.
-- However, it's good enough for these exercises, if a little simplified.
--
-- We start with a Reader of a SqlBackend, over IO
-- type DB = ReaderT SqlBackend IO
--
-- There's an existing synonym for a Reader of a SqlBackend
-- type SqlPersistT = ReaderT SqlBackend
--
-- We also include logging as required by 'withPostgresqlConn'
type DB = SqlPersistT (LoggingT IO)

-- Run a DB action (e.g., an esqueleto `select` query)
-- This uses the connection string to connect to the database, run your
-- esqueleto as SQL, and log to standard out along the way.
runDB :: DB a -> IO a
runDB action = runStdoutLoggingT $ withPostgresqlConn connectionString $ \backend ->
  runSqlConn action backend

-- Basic information needed to connect to a local postgres instance
connectionString :: ConnectionString
connectionString = "host=127.0.0.1 port=5432 user=escalatingesqueleto dbname=escalatingesqueleto"
