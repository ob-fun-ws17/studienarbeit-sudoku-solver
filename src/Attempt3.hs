module Attempt3 ( solve ) where

import SudokuBase ( Grid )
import SudokuAnalize ( valid )
import SudokuTransform ( collapse, prune, choices )

solve :: Grid -> [Grid]
solve = filter valid . collapse . fix prune . choices

--------------------------------------------------------
--------------------- Helper Funcs ---------------------
--------------------------------------------------------

-- map recursive until result doesn't change anymore
fix :: Eq a => (a -> a) -> a -> a
fix f x = if x == x' then x else fix f x'
    where x' = f x
