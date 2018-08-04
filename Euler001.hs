module Euler001 (solve001) where

solve001 :: Int
solve001 = sum $ filter (`isMultipleOfThese` factors) nums
  where nums = [1..upperLimit - 1]

factors :: [Int]
factors = [3, 5]

upperLimit :: Int
upperLimit = 1000

isMultipleOf :: Int -> Int -> Bool
x `isMultipleOf` y = x `mod` y == 0

isMultipleOfThese :: Int -> [Int] -> Bool
isMultipleOfThese x = any (x `isMultipleOf`)
