module Attempt4 ( solve ) where

import SudokuBase ( Grid, Matrix, Choices )
import SudokuAnalize ( blocked, complete, single )
import SudokuTransform ( collapse, prune, choices )

solve :: Grid -> [Grid]
solve = search . prune . choices

--------------------------------------------------------
--------------------- Helper Funcs ---------------------
--------------------------------------------------------

-- only search if not blocked or not complete
search :: Matrix Choices -> [Grid]
search m | blocked m  = []
         | complete m = collapse m
         | otherwise  = [g | m' <- expand m, g <- search (prune m')]

-- expand the first field with multiple choices (not all multiple choice fields)
expand :: Matrix Choices -> [Matrix Choices]
expand m = [rows1 ++ [row1 ++ [c] : row2] ++ rows2 | c <- cs]
    where (rows1, row:rows2) = break (any (not . single)) m
          (row1, cs:row2) = break (not . single) row
