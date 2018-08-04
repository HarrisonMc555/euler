module Euler003 (solve003) where

import Data.Numbers.Primes (primeFactors)

solve003 :: Int
solve003 = maximum . primeFactors $ number

number :: Int
number = 600851475143

-- My solution (very slow)
-- primeFactors :: Int -> [Int]
-- primeFactors x =
--   let possibleFactors = takeWhile (<= sqrt' x) primes
--       getFactor f1 = let (f2, rem) = x `divMod` f1
--                          isFactor = rem == 0
--                          f1' = if isFactor then [f1] else []
--                          f2' = if isFactor && isPrime f2 && f1 /= f2
--                                then [f2] else []
--                      in f1' ++ f2'
--   in concatMap getFactor possibleFactors

-- primes :: [Int]
-- primes = 2 : filter isPrime [3..]

-- isPrime :: Int -> Bool
-- isPrime x = let possibleFactors = takeWhile (<= sqrt' x) primes
--             in not . any (`divides` x) $ possibleFactors
                
-- divides :: Int -> Int -> Bool
-- x `divides` y = y `mod` x == 0

-- sqrt' :: Int -> Int
-- sqrt' = floor . sqrt . fromIntegral
