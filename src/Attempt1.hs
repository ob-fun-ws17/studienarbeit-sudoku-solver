module Attempt1 ( solve ) where

import SudokuBase ( Grid )
import SudokuAnalize ( valid )
import SudokuTransform ( collapse, choices )

solve :: Grid -> [Grid]
solve = filter valid . collapse . choices
