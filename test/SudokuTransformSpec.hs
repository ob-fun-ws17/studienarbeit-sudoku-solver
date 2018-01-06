{-# LANGUAGE ScopedTypeVariables #-}
module SudokuTransformSpec ( spec ) where

import Samples         ( sampleGrid, sampleChoicesPruned, sampleGridSolved )
import SudokuBase      ( values )
import SudokuTransform
import Test.Hspec
import Test.QuickCheck

spec :: Spec
spec = describe "Exported functions" $ do
    describe "choices" $ do
        it "Fills every empty field with choices" $
            choices [".."] `shouldBe` [[values, values]]
        it "choices [] == []" $
            choices []          `shouldBe` []
        it "choices [\"x\"] == [[[x]]]" $
            choices [values] `shouldBe` [[[v] | v <- values]]
    describe "collapse" $ do
        it "Creates a permutation for each choice" $
            collapse [[values]] `shouldBe` [[[v]] | v <- values]
        it "Collapses singular choices to one matrix" $
            collapse [[[v] | v <- values]] `shouldBe` [[values]]
        it "collapse [[\"\"]] == []" $
            collapse [[""]] `shouldBe` []
    describe "prune" $ do
        it "test on unsolved sample" $
            (prune . choices) sampleGrid `shouldBe` sampleChoicesPruned
        it "test on solved sample" $
            prune (choices sampleGridSolved) `shouldBe` choices sampleGridSolved
