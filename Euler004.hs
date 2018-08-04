module Euler004 (solve004) where

solve004 :: Int
solve004 = maximum . filter (palindrome . show) $ threeDigitProducts

threeDigitPairs :: [(Int, Int)]
threeDigitPairs = [(x, y) | x <- [999,998..100], y <- [x,x-1..100]]

threeDigitProducts :: [Int]
threeDigitProducts = map (uncurry (*)) threeDigitPairs

palindrome :: Eq a => [a] -> Bool
palindrome xs = xs == reverse xs
