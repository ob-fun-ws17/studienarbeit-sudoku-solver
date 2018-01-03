module Attempt2 ( solve ) where

import SudokuBase ( Grid )
import SudokuAnalize ( valid )
import SudokuTransforms ( collapse, prune, choices )

solve :: Grid -> [Grid]
solve = filter valid . collapse . prune . choices
