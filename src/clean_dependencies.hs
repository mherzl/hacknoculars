
inputPath = "data/raw_dependencies.txt"
outputPath = "data/clean_dependencies.txt"

-- | Input: String in raw_dependencies format
--   Output: list of strings in name:[dependencies] format
formatInput :: String -> [[String]]
formatInput s = map words $ lines s

formatOutput :: [[String]] -> String
formatOutput l = unlines $ map unwords l

-- | Input: a list with elements in the Eq class
--   Output: list with the leftmost duplicates removed
removeDuplicates :: (Eq a) => [a] -> [a]
removeDuplicates [] = []
removeDuplicates (x:xs)
  | elem x xs = removeDuplicates xs
  | otherwise = x:(removeDuplicates xs)
-- | Input: a list with elements in the Eq class
--   Output: removes duplicates from the tail
removeTailDup :: (Eq a) => [a] -> [a]
removeTailDup [] = []
removeTailDup (x:xs) = x:(removeDuplicates xs)
-- | Input: List of lists of package names
--     each in format: x_name: [x_dependencies]
--   Output: same format, but duplicate
--     dependencies have been removed
removeDupDep :: [[String]] -> [[String]]
removeDupDep f = map removeTailDup f

-- | Input: List of list of package names,
--     each in format: x_name: [x_dependencies]
--   Output: same format, but dependencies
--     not the head of one of the elements have been removed
removeInvalids :: [[String]] -> [[String]]
removeInvalids d = map (\(e:ex) -> e:(filter (flip elem pNames) ex)) d
  where pNames = map head d
--removeInvalids f = filter (\(x:xs) -> all (flip elem pNames) xs) f

removeSelfDep :: [[String]] -> [[String]]
removeSelfDep l = map f l
  where f :: [String] -> [String]
        f (p:d) = p:(filter (/=p) d)

main = do
  s <- readFile inputPath
  --print $ length $ removeInvalids $ removeSelfDep $ removeDupDep $ formatInput s
  writeFile outputPath $ formatOutput $ removeInvalids
    $ removeSelfDep $ removeDupDep $ formatInput s

