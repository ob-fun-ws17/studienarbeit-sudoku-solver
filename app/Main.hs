module Main where

import SudokuParser       ( parseFile, showGrid )
import SudokuSolver       ( solve )
import System.Environment ( getArgs )

-- | Extracts a sudoku grid from a file (filepath passed as argument)
-- and prints the solution to /stdout/
main :: IO ()
main = do
    args <- getArgs
    grid <- parseFile (head args)
    putStrLn $ showGrid $ head $ solve grid
    return ()
