module Euler005 (solve005) where

import Data.Numbers.Primes (primeFactors)

solve005 :: Int
solve005 = head . filter (`divisibleByAll` numbers) $ [1..]

numbers :: [Int]
numbers = [1..20]

divisors :: [Int]
divisors = [x | x <- numbers, not . any (x `dividesNotEqual`) $ numbers]

divides :: Int -> Int -> Bool
x `divides` y = y `mod` x == 0

dividesNotEqual :: Int -> Int -> Bool
x `dividesNotEqual` y = x `divides` y && x /= y

divisibleByAll :: Int -> [Int] -> Bool
divisibleByAll x ys = all (`divides` x) ys
