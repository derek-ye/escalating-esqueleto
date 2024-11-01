module EE01_customersSharingFoundersBirthday where

import Data.Text (Text)
import Database.Esqueleto.Experimental
import Database.Esqueleto.Internal.Internal (unsafeSqlFunction)
import Data.Time.Calendar (Day)
import Schema
import Types

-- There are various ways to accomplish this one. I did:
-- SELECT birthday FROM customers
-- WHERE date_part('month', birthday) = 4 AND date_part('day'  , birthday) = 17;
--
-- It's possible to get stronger type safety here, but the key point of the
-- exercise is to learn how to dip into raw SQL when necessary
--
-- We use Haskell wrappers around raw SQL to get typechecked SQL in Haskell syntax...
-- ...this is the whole point of esqueleto!
customersSharingFoundersBirthday :: DB [Entity Customer]
customersSharingFoundersBirthday = do
  select $ do
    customer <- from $ table @Customer
    where_ $ datePart "month" customer.birthday ==. val 4
    where_ $ datePart "day" customer.birthday ==. val 17
    pure customer
  where
    datePart :: Text -> SqlExpr (Value (Maybe Day)) -> SqlExpr (Value Int)
    datePart dateKind birthday = unsafeSqlFunction "date_part" (val @Text dateKind, birthday)
