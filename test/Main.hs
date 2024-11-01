{-# LANGUAGE ImportQualifiedPost #-}

module Main (main) where

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

    it "customersWithoutBirthdaysWithFlavors" $ do
      Exercise.customersWithoutBirthdaysWithFlavors `shouldMatchListRunDB` Answer.customersWithoutBirthdaysWithFlavors

    it "customersSharingFoundersBirthday" $ do
      Exercise.customersSharingFoundersBirthday `shouldMatchListRunDB` Answer.customersSharingFoundersBirthday

-- shouldBeRunDB :: (Eq a, Show a) => DB a -> DB a -> IO ()
-- shouldBeRunDB exr ans = do
--   exercise <- runDB exr
--   answer <- runDB ans
--   exercise `shouldBe` answer

shouldMatchListRunDB :: (Eq a, Show a) => DB [a] -> DB [a] -> IO ()
shouldMatchListRunDB exr ans = do
  exercise <- runDB exr
  answer <- runDB ans
  exercise `shouldMatchList` answer

-- Used to check this repo's answers. You won't need it if you're doing the exercises.
developTest :: (Eq a, Show a) => ignored -> DB [a] -> IO ()
developTest _ignored ans = do
  let line = putStrLn . take 80 $ cycle "─"
  line
  answer <- runDB ans
  print answer
  line
