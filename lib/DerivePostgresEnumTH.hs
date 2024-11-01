{-# LANGUAGE TemplateHaskell #-}

-- This module copied from the culture site's Culture.Database.Persist.TH
module DerivePostgresEnumTH (derivePostgresEnum) where

import Prelude
import Language.Haskell.TH
import qualified Data.Text as T
import qualified Data.Text.Encoding as TE
import Database.Persist
import Database.Persist.Sql (PersistFieldSql, sqlType)
import qualified Data.ByteString.Char8 as S8
import Text.Read (readEither)
import Language.Haskell.TH.Syntax (Lift(..))

-- | Derives these instances:
--
-- * 'PersistFieldSql': implemented as SqlOther <name of the postgres enum>
-- * 'PersistField':
--     * 'toPersistValue': shows the value
--     * 'fromPersistValue': reads the value
--     * Values should match the enum value in Postgres exactly.
derivePostgresEnum :: Name -> String -> Q [Dec]
derivePostgresEnum s postgresType = do
  -- This code was done by taking the 'derivePersistField' code and manually inlining all the internal functions it calls
  -- Ideally we can get this merged and just use it: https://github.com/yesodweb/persistent/issues/792
  ss <- [|SqlOther (T.pack $(lift postgresType))|]
  tpv <- [|PersistLiteral_ Escaped . S8.pack . show|]
  fpv <- [|\dt v ->
        case v of
          (PersistLiteral_ _ bs) -> case readEither $ S8.unpack bs of
            Left err -> Left $ T.concat ["Couldn't parse ", TE.decodeUtf8 bs, " into ", T.pack dt, ". Error: ", T.pack err]
            Right x -> Right x

          x -> Left $ T.concat ["When trying to deserialize a", T.pack dt, ": expected PersistDbSpecific, received: ", T.pack (show x)]|]

  pure
    [ InstanceD Nothing [] (ConT ''PersistField `AppT` ConT s) [ FunD 'toPersistValue
        [ Clause [] (NormalB tpv) []
        ]
      , FunD 'fromPersistValue
        [ Clause [] (NormalB (fpv `AppE` LitE (StringL $ nameBase s))) []
        ]
      ]
    , InstanceD Nothing [] (ConT ''PersistFieldSql `AppT` ConT s) [ FunD 'sqlType [ Clause [WildP] (NormalB ss) [] ] ]
    ]
