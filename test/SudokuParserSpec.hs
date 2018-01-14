module SudokuParserSpec ( spec ) where

import Samples ( sampleGrid, sampleGridString )
import SudokuParser
import Test.Hspec
import Test.QuickCheck

spec :: Spec
spec = describe "True positive tests on IO functions" $ do
    it "parseFile" $
        parseFile "resources/easy.txt" `shouldReturn` sampleGrid
    it "showGrid" $
        lines (showGrid sampleGrid) `shouldBe` sampleGridString
