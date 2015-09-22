
import Data.List (sortBy)
import Control.Monad (mapM)

main = do
  s <- readFile "page_rank.txt"
  let d = map words $ lines s
  let toTuple :: [String] -> (String, Double)
      toTuple (a:b:[]) = (a, read b)
  let dt = map toTuple d
  let sorted = sortBy (\(a,b) (c,d) -> compare d b) dt
  let untuple :: (String,Double) -> [String]
      untuple (a,b) = a:(show b):[]
  mapM print $ take 10 sorted
  --print $ take 10 $ map untuple sorted
  --print $ unlines $ map unwords $ take 5 sorted
