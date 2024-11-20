{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ImportQualifiedPost #-}

module Main (main) where

import Data.List (sort)

import Exercises qualified as Exercise
import Answers qualified as Answer
import Types

import Test.Hspec

main :: IO ()
main = hspec $ do
  describe "EE00_StartingOut" $ do
    it "iWantToLearnEsqueleto" $ do
      Exercise.iWantToLearnEsqueleto `shouldBe` Answer.iWantToLearnEsqueleto

  describe "EE01_Select" $ do
    it "allFlavors" $ do
      Exercise.allFlavors `shouldMatchListRunDB` Answer.allFlavors

    it "allFlavorNameValues" $ do
      Exercise.allFlavorNameValues `shouldMatchListRunDB` Answer.allFlavorNameValues

    it "allFlavorNames" $ do
      Exercise.allFlavorNames `shouldMatchListRunDB` Answer.allFlavorNames

    it "dairyFreeFlavors" $ do
      Exercise.dairyFreeFlavors `shouldMatchListRunDB` Answer.dairyFreeFlavors

    it "flavorIdsFromNames" $ do
      let neapolitan = ["Chunky Chocolate", "Variegated Vanilla", "Smooth Strawberry"]
      Exercise.flavorIdsFromNames neapolitan `shouldMatchListRunDB` Answer.flavorIdsFromNames neapolitan

    it "customersWithoutBirthdaysWithFlavors" $ do
      Exercise.customersWithoutBirthdaysWithFlavors `shouldMatchListRunDB` Answer.customersWithoutBirthdaysWithFlavors

    it "customersSharingFoundersBirthday" $ do
      Exercise.customersSharingFoundersBirthday `shouldMatchListRunDB` Answer.customersSharingFoundersBirthday

  describe "EE02_Join" $ do
    it "favoriteFlavors" $ do
      Exercise.favoriteFlavors `shouldMatchListRunDB` Answer.favoriteFlavors

    it "flavorPopularity" $ do
      Exercise.flavorPopularity `shouldBeRunDB` Answer.flavorPopularity

    it "largestGroup" $ do
      Exercise.largestGroup `shouldMatchListRunDB` Answer.largestGroup

    it "customerGroups" $ do
      Exercise.customerGroups `shouldMatchMapRunDB` Answer.customerGroups

  describe "EE03_TypeZoo" $ do

    -- Because these exercises are at the type level and are pretty complicated, it's probably nicer to check by hand.
    -- Just change False to True when your type signature is correct, to check off that test as completed.

    it "runDB" $ do
      checkedByHand False

    it "select" $ do
      checkedByHand False

    it "val" $ do
      checkedByHand False

    it "orderBy" $ do
      checkedByHand False

    it "(?.)" $ do
      checkedByHand False

    it "leftJoin" $ do
      checkedByHand False

  describe "EE04_Errors" $ do
    it "getChocolate" $ do
      Exercise.getChocolate `shouldBeRunDB` Answer.getChocolate

    it "mostPopularFlavor" $ do
      Exercise.mostPopularFlavor `shouldBeRunDB` Answer.mostPopularFlavor

    it "customerPurchases" $ do
      Exercise.customerPurchases `shouldBeRunDB` Answer.customerPurchases

checkedByHand :: Bool -> IO ()
checkedByHand False = expectationFailure "Check this exercise by hand, then change False to True in the tests to mark it as completed."
checkedByHand True = pure ()

shouldBeRunDB :: (Eq a, Show a) => DB a -> DB a -> IO ()
shouldBeRunDB exr ans = do
  exercise <- runDB exr
  answer <- runDB ans
  exercise `shouldBe` answer

shouldMatchListRunDB :: (Eq a, Show a) => DB [a] -> DB [a] -> IO ()
shouldMatchListRunDB exr ans = do
  exercise <- runDB exr
  answer <- runDB ans
  exercise `shouldMatchList` answer

shouldMatchMapRunDB :: (Eq a, Show a, Eq b, Ord b, Show b) => DB [(a, [b])] -> DB [(a, [b])] -> IO ()
shouldMatchMapRunDB exr ans = do
  exercise <- runDB exr
  answer <- runDB ans
  map sortNested exercise `shouldMatchList` map sortNested answer
  where
    sortNested :: Ord b => (a, [b]) -> (a, [b])
    sortNested (x, ys) = (x, sort ys)

-- Used to check this repo's answers. You won't need it if you're doing the exercises.
_developTest :: (Eq a, Show a) => ignored -> DB a -> IO ()
_developTest _ignored ans = do
  let line = putStrLn . take 80 $ cycle "─"
  line
  answer <- runDB ans
  let answerStr = show answer
  putStrLn $ if length answerStr < 1000 then answerStr else take 1000 answerStr <> "... (output truncated)"
  line
