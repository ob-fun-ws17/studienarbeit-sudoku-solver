module SudokuTransforms
    ( choices
    , collapse
    , prune ) where

import SudokuBase
import SudokuAnalize ( single, empty )

-- either set single value or all values as array
choices :: Grid -> Matrix Choices
choices = map (map choice)
    where choice v = if empty v then values else [v]

-- list of matrices that mustn't be valid representing
-- all permutation of the choices output
collapse :: Matrix [a] -> [Matrix a]
collapse = cp . map cp

-- remove choices by checking rows columns and boxes of the Sudoku grid
prune :: Matrix Choices -> Matrix Choices
prune = pruneBy boxs . pruneBy cols . pruneBy rows
    where pruneBy f = f . map reduce . f

--------------------------------------------------------
--------------------- Helper Funcs ---------------------
--------------------------------------------------------

-- helper func for collapse (cartesian product)
cp :: [[a]] -> [[a]]
cp [] = [[]]
cp (xs:xss) = [y:ys | y <- xs, ys <- cp xss]

-- helper func for prune
-- remove choices of each element by looking at all single element members
reduce :: Row Choices -> Row Choices
reduce xss = [xs `minus` singles | xs <- xss]
    where singles = concat (filter single xss)

-- helper func for reduce
-- Symetric difference if possible
minus :: Choices -> Choices -> Choices
xs `minus` ys = if single xs then xs else xs \\ ys
