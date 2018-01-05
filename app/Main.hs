module Main where

import SudokuParser       ( parseFile, showGrid )
import SudokuSolver       ( solve )
import System.Environment ( getArgs )

main :: IO ()
main = do
    args <- getArgs
    grid <- parseFile (head args)
    putStrLn $ showGrid $ head $ solve grid
    return ()
