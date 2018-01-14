{-|
This module contains the toplevel function
to solve sudoku grids as well as its' sub functions.

This implementation is deprecated (faster implementation can be found in 'SudokuSolver.solve')
and is only included for historical purpose.
-}
module Attempt4 ( solve ) where

import SudokuBase ( Grid, Matrix, Choices )
import SudokuAnalize ( blocked, complete, single )
import SudokuTransform ( collapse, prune, choices )


-- | Tries to find a solution to a specified 'Grid'
solve :: Grid   -- ^ (unsolved) 'Grid' as input
      -> [Grid] -- ^ list whicht eigher contains a solution or is empty
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
