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

  fdescribe "EE01_Select" $ do
    it "allFlavors" $ do
      Exercise.allFlavors `shouldMatchListRunDB` Answer.allFlavors

    it "allFlavorNames" $ do
      Exercise.allFlavorNames `shouldMatchListRunDB` Answer.allFlavorNames

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

