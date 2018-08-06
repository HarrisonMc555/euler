module Euler (euler) where

import Data.Map
import System.Environment

import Euler001 (solve001)
import Euler002 (solve002)
import Euler003 (solve003)
import Euler004 (solve004)
import Euler005 (solve005)
import Euler006 (solve006)
import Euler007 (solve007)

euler :: Int -> Maybe Int
euler = (`Data.Map.lookup` eulerSolutions)

eulerSolutions :: Data.Map.Map Int Int
eulerSolutions = Data.Map.fromList
  [ (1, solve001)
  , (2, solve002)
  , (3, solve003)
  , (4, solve004)
  , (5, solve005)
  , (6, solve006)
  , (7, solve007)
  ]
