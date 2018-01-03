module SudokuAnalize
    ( empty
    , single
    , valid
    , complete
    , blocked ) where

import SudokuBase

-- Check if sudoku field is empty
empty :: Value -> Bool
empty = (== '.')

-- Check if an array contains only ONE component
single :: [a] -> Bool
single [_] = True
single _ = False

-- check if sudoku grid is valid
valid :: Grid -> Bool
valid g = all nodups (rows g) &&
          all nodups (cols g) &&
          all nodups (boxs g)

-- A Matrix is complete if it only contains single choices
complete :: Matrix Choices -> Bool
complete = all (all single)

-- either void or unsafe
blocked :: Matrix Choices -> Bool
blocked m = void m || not (save m)

--------------------------------------------------------
--------------------- Helper Funcs ---------------------
--------------------------------------------------------

-- Void = unsolvable (Matrix contains field with no choices)
void :: Matrix Choices -> Bool
void = any (any null)

-- helper func for valid
nodups :: Eq a => [a] -> Bool
nodups [] = True
nodups (x:xs) = not (x `elem` xs) && nodups xs

-- No interfearing single choices
save :: Matrix Choices -> Bool
save cm = all consistent (rows cm) &&
          all consistent (cols cm) &&
          all consistent (boxs cm)

-- helper func of save
consistent :: Row Choices -> Bool
consistent = nodups . concat . filter single
