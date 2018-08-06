module Euler006 (solve006) where

solve006 :: Int
solve006 = squareOfSums numbers - sumOfSquares numbers
  where numbers = [1..100]

sumOfSquares :: [Int] -> Int
sumOfSquares = sum . map (^2)

squareOfSums :: [Int] -> Int
squareOfSums = (^2) . sum
