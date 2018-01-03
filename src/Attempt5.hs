module Attempt5 ( solve ) where

import SudokuBase ( Grid, Matrix, Choices )
import SudokuAnalize ( blocked, complete )
import SudokuTransforms ( collapse, prune, choices )

solve :: Grid -> [Grid]
solve = search . prune . choices

search :: Matrix Choices -> [Grid]
search m | blocked m  = []
         | complete m = collapse m
         | otherwise  = [g | m' <- expand m, g <- search (prune m')]

expand :: Matrix Choices -> [Matrix Choices]
expand m = [rows1 ++ [row1 ++ [c] : row2] ++ rows2 | c <- cs]
    where (x, y) = findmin m
          (rows1, row:rows2) = splitAt y m
          (row1, cs:row2) = splitAt x row

findmin :: Matrix Choices -> (Int, Int)
findmin = format . miny
    where minx = minimum . (filter ((>1) . fst)) . (`zip` [0..]) . (map length)
          miny = minimum . (`zip` [0..]) . (map minx)
          format ((_, x), y) = (x, y)
