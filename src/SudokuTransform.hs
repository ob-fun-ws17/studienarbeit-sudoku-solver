{-|
A collection of functions that return a somehow
transformed sudoku grid.
-}
module SudokuTransform
    ( choices
    , collapse
    , prune ) where

import SudokuBase
import SudokuAnalize ( single, empty )
import Data.List     ( (\\) )

-- | replaces empty fields with 'Choices'.
choices :: Grid           -- ^ 'Grid' that contains empty fields
        -> Matrix Choices -- ^ 'Matrix Choices' containing either @['1'..'9']@ or a single valued array
choices = map (map choice)
    where choice v = if empty v then values else [v]

-- | Creates a list of matrices that mustn't be valid
-- representing all permutation of the input /(reduced by one dimension)/.
collapse :: Matrix [a] -- ^ Matrix of choices
         -> [Matrix a] -- ^ list of all possible permutations considering the choices
collapse = cp . map cp

-- | Remove all invalid choices by checking rows columns and boxes of the Sudoku grid.
prune :: Matrix Choices -- ^ contains invalid choices
      -> Matrix Choices -- ^ all invalid choices are removed
prune = pruneBy boxs . pruneBy cols . pruneBy rows
    where pruneBy f = f . map reduce . f


--------------------------------------------------------
--------------------- Helper Funcs ---------------------
--------------------------------------------------------

-- helper func for collapse (cartesian product)
cp :: [[a]]
   -> [[a]]
cp [] = [[]]
cp (xs:xss) = [y:ys | y <- xs, ys <- cp xss]

-- helper func for prune
-- remove choices of each element by looking at all single element members
reduce :: Row Choices
       -> Row Choices
reduce xss = [xs `minus` singles | xs <- xss]
    where singles = concat (filter single xss)

-- helper func for reduce
-- Symetric difference if possible
minus :: Choices
      -> Choices
      -> Choices
xs `minus` ys = if single xs then xs else xs \\ ys
