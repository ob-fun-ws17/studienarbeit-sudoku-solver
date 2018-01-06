{-
Functions to read and write sudoku grids
-}
module SudokuParser ( parseFile, showGrid ) where

import SudokuBase ( boxsize
                  , Grid
                  , Row
                  , Value )

import System.IO  ( openFile
                  , hGetLine
                  , hClose
                  , hIsEOF
                  , FilePath
                  , Handle
                  , IOMode( ReadMode ) )

-- | Extract 'Grid' from specified file (see /README.md/ for a file format description)
parseFile :: FilePath -- ^ File containing a valid sudoku grid
          -> IO Grid  -- ^ Extracted sudoku grid
parseFile f = do
    handle <- openFile f ReadMode
    grid <- getlines handle
    hClose handle
    return grid

-- | Creates human readable string representaion of a 'Grid'
showGrid :: Grid   -- ^ 'Grid' to make readable
         -> String -- ^ 'String' containing table layout of 'Grid'
showGrid g = showRows g
    where showRows rs = padd rs "\n" showCols
          showCols cs = padd cs " " (:[])

--------------------------------------------------------
--------------------- Helper Funcs ---------------------
--------------------------------------------------------

-- Insert a splecified string between each string-mapped array element
padd :: [a]
     -> String
     -> (a -> String)
     -> String
padd (r:rs) p f = (f r) ++ p ++ (padd rs p f)
padd [] _ _  = []

-- Extract grid from a specified file handle
getlines :: Handle
         -> IO Grid
getlines h = do
    isend <- hIsEOF h
    if isend
    then return []
    else do l <- hGetLine h
            ls <- getlines h
            return (l:ls)
