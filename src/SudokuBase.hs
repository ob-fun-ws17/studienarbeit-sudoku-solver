module SudokuBase
    ( Value
    , Row
    , Grid
    , Matrix
    , Choices
    , rows
    , cols
    , boxs
    , values
    , boxsize
    ) where

import Data.List ( transpose )

-- Basic Types
type Value    = Char
type Row a    = [a]
type Matrix a = [Row a]
type Grid     = Matrix Value
type Choices  = [Value]

-- Constants
boxsize = 3         :: Int
values = ['1'..'9'] :: [Value]

-- list of sudoku rows
rows :: Matrix a -> [Row a]
rows = id

-- list of sudoku columns
cols :: Matrix a -> [Row a]
cols = transpose

-- list of sudoku boxes (boxsize x boxsize)
boxs :: Matrix a -> [Row a]
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
