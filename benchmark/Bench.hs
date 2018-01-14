module Main ( main ) where

import Criterion.Main         ( bench, bgroup, defaultMain, nf )
import Samples
import qualified SudokuSolver as Fast
import qualified Attempt4     as Slow


main :: IO ()
main = defaultMain
    [ bgroup "Fast sudoku solve"
        [ bench "sampleGrid (easy.txt)" $ nf Fast.solve sampleGrid
        , bench "sampleGrid1 (gentle.txt)" $ nf Fast.solve sampleGrid1
        , bench "sampleGrid2 (diabolical.txt)" $ nf Fast.solve sampleGrid2
        , bench "sampleGrid3 (minimal.txt)" $ nf Fast.solve sampleGrid3
        , bench "sampleGrid4 (unsolvable.txt)" $ nf Fast.solve sampleGrid4 ]
    , bgroup "Slow sudoku solve"
        [ bench "sampleGrid (easy.txt)" $ nf Slow.solve sampleGrid
        , bench "sampleGrid1 (gentle.txt)" $ nf Slow.solve sampleGrid1
        , bench "sampleGrid2 (diabolical.txt)" $ nf Slow.solve sampleGrid2
        , bench "sampleGrid3 (minimal.txt)" $ nf Slow.solve sampleGrid3
        , bench "sampleGrid4 (unsolvable.txt)" $ nf Slow.solve sampleGrid4 ] ]
