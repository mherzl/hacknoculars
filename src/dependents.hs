
inputPath = "data/clean_dependencies.txt"
outputPath = "data/dependents.txt"

formatInput :: String -> [[String]]
formatInput s = map words $ lines s

formatOutput :: [[String]] -> String
formatOutput l = unlines $ map unwords l

depsOf :: [[String]] -> String -> [String]
depsOf d s = s:(foldl (\a (e:ex) -> if (elem s ex) then (e:a) else a) [] d)

dependents :: [[String]] -> [[String]]
dependents d = map (depsOf d) $ map head d

main = do
  s <- readFile inputPath
  let d = formatInput s
  writeFile outputPath $ formatOutput $ dependents d

