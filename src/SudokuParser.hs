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


parseFile :: FilePath -> IO Grid
parseFile f = do
    handle <- openFile f ReadMode
    grid <- getlines handle
    hClose handle
    return grid

showGrid :: Grid -> String
showGrid g = showRows g
    where showRows rs = padd rs "\n" showCols
          showCols cs = padd cs " " (:[])

--------------------------------------------------------
--------------------- Helper Funcs ---------------------
--------------------------------------------------------
padd :: [a] -> String -> (a -> String) -> String
padd (r:rs) p f = (f r) ++ p ++ (padd rs p f)
padd [] _ _  = []

getlines :: Handle -> IO Grid
getlines h = do
    isend <- hIsEOF h
    if isend
    then return []
    else do l <- hGetLine h
            ls <- getlines h
            return (l:ls)
