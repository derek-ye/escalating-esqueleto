module EE02_customerGroups where

import Data.Coerce (coerce)
import Database.Esqueleto.Experimental
import Database.Esqueleto.PostgreSQL
import Schema
import Types

customerGroups :: DB [(CustomerGroupParentId, [CustomerId])]
customerGroups = do
  fmap coerce $ select $ do
    (customer :& _ :& customerGroupParent) <- from $
      table @Customer
        `innerJoin` table @CustomerLink
          `on` (\(customer :& customerLink) -> customer.id ==. customerLink.customerId)
        `innerJoin` table @CustomerGroupParent
          `on` (\(_ :& customerLink :& customerGroupParent) -> customerLink.parentId ==. customerGroupParent.id)
    groupBy customerGroupParent.id
    pure $ (customerGroupParent.id, maybeArray $ arrayAgg customer.id)
