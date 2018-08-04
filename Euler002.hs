module Euler002 (solve002) where

solve002 :: Int
solve002 = sum $ filter even $ takeWhile (< upperLimit) fibonaccis
  where upperLimit = 4000000

fibonaccis :: [Int]
fibonaccis = 1 : 2 : zipWith (+) fibonaccis (tail fibonaccis)

fibonacci :: Int -> Int
fibonacci i = fibonaccis !! i - 1
