{-# LANGUAGE ScopedTypeVariables #-}
module SudokuAnalizeSpec ( spec ) where

import Samples         ( sampleGrid, sampleChoicesPruned, sampleGridSolved )
import SudokuBase      ( Value, values )
import SudokuTransform ( choices )
import SudokuAnalize
import Test.Hspec
import Test.QuickCheck

spec :: Spec
spec = describe "Exported functions" $ do
    describe "empty" $ do
        it "empty '.' == True" $
            empty '.' `shouldBe` True
        it "empty x == False for x `elem` values" $
            all id $ map (not . empty) values
    describe "single" $ do
        it "single x == False (if length x != 1)" $
            property $ \(vs :: [Value]) -> single vs == (length vs == 1)
    describe "valid" $ do
        it "test on solved sample" $
            valid sampleGridSolved `shouldBe` True
        it "test on unsolved sample" $
            valid sampleGrid `shouldBe` False
    describe "complete" $ do
        it "test on solved sample" $
            complete (choices sampleGridSolved) `shouldBe` True
        it "test on unsolved sample" $
            complete sampleChoicesPruned `shouldBe` False
--    describe "blocked" $ do
--        it ""
