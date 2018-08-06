module Euler007 (solve007) where

import Data.Numbers.Primes (primes)

solve007 :: Int
solve007 = primes !! 10000
