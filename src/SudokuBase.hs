module SudokuBase
    ( -- * Types used to represent both solved and unsolved sudoku grids
      Value
    , Row
    , Grid
    , Matrix
    , Choices
      -- * Symetric transformations of a sudoku grid
    , rows
    , cols
    , boxs
      -- * Constants defining a sudoku grid
    , values
    , boxsize
    ) where

import Data.List ( transpose )

type Value    = Char         -- ^ Value of a field in the sudoku grid
type Row a    = [a]          -- ^ A list that represents a row in a 'Matrix'
type Matrix a = [Row a]      -- ^ 2D array
type Grid     = Matrix Value -- ^ 'Matrix' that represents a sudoku grid
type Choices  = [Value]      -- ^ List of possible values a field could have

-- | Size of sectors in a sudoku grid
boxsize = 3 :: Int

-- | Char values for all allowed numbers
values = ['1'..'9'] :: [Value]

-- | Create list of rows
rows :: Matrix a -- ^ 'Matrix' (usually 'Grid') which is already a list of 'Row's
     -> [Row a]  -- ^ list of rows in a sudoku grid
rows = id

-- | Create list of columns
cols :: Matrix a -- ^ 'Matrix' (usually 'Grid')
     -> [Row a]  -- ^ list of rows (using 'transpose')
cols = transpose

-- | Create list of boxes ('boxsize' x 'boxsize')
boxs :: Matrix a -- ^ 'Matrix' (usually 'Grid')
     -> [Row a]  -- ^ list of boxes (sectors in a sudoku grid)
boxs = unpack . map cols . pack
    where pack   = split . map split
          split  = chop boxsize
          unpack = map concat . concat

--------------------------------------------------------
--------------------- Helper Funcs ---------------------
--------------------------------------------------------

-- helper func for boxs
chop :: Int -> [a] -> [[a]]
chop n [] = []
chop n xs = take n xs : chop n (drop n xs)
