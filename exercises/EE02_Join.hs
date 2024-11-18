module EE02_Join where

import Data.Text (Text)
import Database.Esqueleto.Experimental
import Schema
import Types

{-
What are all our customers' favorite flavors?

If they don't have one, give back a `Nothing`.
-}
favoriteFlavors :: DB [(Entity Customer, Maybe (Entity Flavor))]
favoriteFlavors = _

{-
We'd like to determine the popularity of each flavor.

Return a list of each flavor name along with how many customers have it as
their favorite flavor. Sort it by popularity, in descending order.

Sample results:
[ ("Chunky Chocolate", 27)
, ("Smooth Strawberry", 12)
, ("Variegated Vanilla", 3)
]
-}
flavorPopularity :: DB [(Text, Int)]
flavorPopularity = _

{-
We have a concept of "groups" provided by CustomerLink and CustomerGroupParent.

Who are all the customers in the largest group?
-}
largestGroup :: DB [Entity Customer]
largestGroup = _
