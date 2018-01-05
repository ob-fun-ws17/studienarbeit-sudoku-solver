{-|
This module contains the toplevel function
to solve sudoku grids as well as its' sub functions.
-}
module SudokuSolver ( solve ) where

import SudokuBase ( Grid, Matrix, Row, Choices, boxsize )
import SudokuAnalize ( blocked, complete )
import SudokuTransform ( collapse, prune, choices )

-- | Tries to find a solution to a specified 'Grid'
solve :: Grid   -- ^ (unsolved) 'Grid' as input
      -> [Grid] -- ^ list whicht eigher contains a solution or is empty
solve = search . prune . choices


--------------------------------------------------------
--------------------- Helper Funcs ---------------------
--------------------------------------------------------

-- Representing a possible array index and a value it refers to
data IndexValPair a = NoIVPair
                    | IVPair Int a

-- Value passed by functions that iterate over an array
data LengthItr a = Start
                 | Step Int (IndexValPair a)

-- helper func for solve
-- Search for a possible solution to a given matrix of choices
search :: Matrix Choices
       -> [Grid]
search m | blocked m  = []
         | complete m = collapse m
         | otherwise  = [g | m' <- expand m, g <- search (prune m')]

-- helper func for search
-- List of all permutations deriving from the smallest entry of multiple choices
expand :: Matrix Choices
       -> [Matrix Choices]
expand m = [rows1 ++ [row1 ++ [c] : row2] ++ rows2 | c <- cs]
    where (x, y) = findmin m
          (rows1, row:rows2) = splitAt y m
          (row1, cs:row2) = splitAt x row

-- helperfunc for expand
-- Returns the x and y coordinates of the smallest entry of multiple choices
findmin :: Matrix Choices
        -> (Int, Int)
findmin = getxy . miny
    where minx r = validmin r length replacableX Start
          miny rs = validmin rs minx replacableY Start

-- helperfunc for findmin
-- Searches for `best value` (defined by third input) in a list or transformable values
validmin :: [[a]]
         -> ([a] -> b)
         -> (b -> IndexValPair b -> Bool)
         -> LengthItr b
         -> IndexValPair b
validmin [] f p (Step n t) = t
validmin r f p Start = validmin r f p (Step 0 NoIVPair)
validmin (x:xs) f p (Step n t) = validmin xs f p (Step (n+1) iv)
    where pv = f x
          iv | p pv t    = IVPair n pv
             | otherwise = t
validmin _ _ _ _ = error "validmin: called with invalid input"

-- helperfunc for findmin
-- Determines wheter a given value should replace the old index-value-pair
replacableX :: Int
            -> IndexValPair Int
            -> Bool
replacableX pv (IVPair _ v) = pv > 1 && pv < v
replacableX pv NoIVPair = pv > 1
replacableX _ _ = False

-- helperfunc for findmin
-- same as replacableX but comparing index-value-pairs instead of single values
replacableY :: IndexValPair Int
            -> IndexValPair (IndexValPair Int)
            -> Bool
replacableY (IVPair _ pv) (IVPair _ (IVPair _ v)) = pv > 1 && pv < v
replacableY (IVPair _ pv) NoIVPair = pv > 1
replacableY _ _ = False

-- helperfunc for findmin
-- Reformats a nested key-value-pair to a coordinate tuple
getxy :: IndexValPair (IndexValPair Int)
      -> (Int, Int)
getxy (IVPair y (IVPair x _)) = (x, y)
getxy _ = let s = boxsize^2 - 1 in (s, s)
