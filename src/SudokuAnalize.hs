{-|
Collection of functions that check specific properties
of a sudoku grid or its' subcomponents
-}
module SudokuAnalize
    ( empty
    , single
    , valid
    , complete
    , blocked ) where

import SudokuBase

-- | Check if sudoku field is empty
empty :: Value -- ^ 'Value' of a field
      -> Bool  -- ^ 'True' if no concrete value
empty = (== '.')

-- | Check if an array contains only ONE component
single :: [a]  -- ^ usually 'SudokuBase#Choices'
       -> Bool -- ^ 'True' if it only contains one choice
single [_] = True
single _ = False

-- | Check if sudoku grid is valid
valid :: Grid -- ^ Sudoku grid that doesn't have to be valid
      -> Bool -- ^ 'True' if no dublicate entries in each row, column and box
valid g = all nodups (rows g) &&
          all nodups (cols g) &&
          all nodups (boxs g)

-- | A Matrix is complete if it only contains single choices
complete :: Matrix Choices -- ^ representing a possibly unsolved sudoku grid
         -> Bool           -- ^ 'True' if every field has a 'single' choice
complete = all (all single)

-- | Either void or unsafe
blocked :: Matrix Choices -- ^ a possibly unsolvable sudoku grid
        -> Bool           -- ^ 'True' if not solvable
blocked m = void m || not (save m)

--------------------------------------------------------
--------------------- Helper Funcs ---------------------
--------------------------------------------------------

-- Void = unsolvable (Matrix contains field with no choices)
void :: Matrix Choices
     -> Bool
void = any (any null)

-- helper func for valid
nodups :: Eq a => [a]
       -> Bool
nodups [] = True
nodups (x:xs) = not (x `elem` xs) && nodups xs

-- No interfearing single choices
save :: Matrix Choices
     -> Bool
save cm = all consistent (rows cm) &&
          all consistent (cols cm) &&
          all consistent (boxs cm)

-- helper func of save
consistent :: Row Choices
           -> Bool
consistent = nodups . concat . filter single
