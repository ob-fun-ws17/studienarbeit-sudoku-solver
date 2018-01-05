module SudokuSolver ( solve ) where

import SudokuBase ( Grid, Matrix, Row, Choices, boxsize )
import SudokuAnalize ( blocked, complete )
import SudokuTransform ( collapse, prune, choices )

solve :: Grid -> [Grid]
solve = search . prune . choices


--------------------------------------------------------
--------------------- Helper Funcs ---------------------
--------------------------------------------------------

data IndexValPair a = NoIVPair | IVPair Int a
data LengthItr a = Start | Step Int (IndexValPair a)

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
findmin = getxy . miny
    where minx r = validmin r length replacableX Start
          miny rs = validmin rs minx replacableY Start

validmin :: [[a]] -> ([a] -> b) -> (b -> IndexValPair b -> Bool) -> LengthItr b -> IndexValPair b
validmin [] f p (Step n t) = t
validmin r f p Start = validmin r f p (Step 0 NoIVPair)
validmin (x:xs) f p (Step n t) = validmin xs f p (Step (n+1) iv)
    where pv = f x
          iv | p pv t    = IVPair n pv
             | otherwise = t
validmin _ _ _ _ = error "findvalid called with invalid input"

replacableX :: Int -> IndexValPair Int -> Bool
replacableX pv (IVPair _ v) = pv > 1 && pv < v
replacableX pv NoIVPair = pv > 1
replacableX _ _ = False

replacableY :: IndexValPair Int -> IndexValPair (IndexValPair Int) -> Bool
replacableY (IVPair _ pv) (IVPair _ (IVPair _ v)) = pv > 1 && pv < v
replacableY (IVPair _ pv) NoIVPair = pv > 1
replacableY _ _ = False

getxy :: IndexValPair (IndexValPair Int) -> (Int, Int)
getxy (IVPair y (IVPair x _)) = (x, y)
getxy _ = let s = boxsize^2 - 1 in (s, s)
