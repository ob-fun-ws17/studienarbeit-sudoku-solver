{-# LANGUAGE ScopedTypeVariables #-}
module SudokuBaseSpec ( spec ) where

import Samples ( sampleGrid )
import SudokuBase
import Test.Hspec
import Test.QuickCheck

spec :: Spec
spec = describe "Symetric transformations for sudoku grids" $ do
    it "(rows . rows) == id" $
        property $ \(m :: Grid) -> rows m == m
    it "(cols . cols) == id" $
        (cols . cols) sampleGrid == sampleGrid
    it "(boxs . boxs) == id" $
        (boxs . boxs) sampleGrid == sampleGrid
