
type PageRanks = [(String,Double)]

getPr :: IO [(String,Double)]
getPr = do
  s <- readFile "page_rank.txt"
  let d = map words $ lines s
      pr :: [String] -> (String,Double)
      pr (a:b:[]) = (a, read b)
      pr _ = error "input list should only have length 2"
  return $ map pr d

searchPr :: PageRanks -> String -> (String,Double)
searchPr pr n = head $ filter (\(a,b) -> a==n) pr

showPr :: (String,Double) -> String
showPr (n,p) = n ++ " has pagerank: " ++ (show p)

type Similarities = [(String, [(String, Double)])]

getSimilarities :: IO Similarities
getSimilarities = do
  s <- readFile "jacard_matches.txt"
  let d = map words $ lines s
      sr :: [String] -> [(String,Double)]
      sr [] = []
      sr (a:b:c) = (a, read b):(sr c)
      sr _ = error "wrong format for input to sr"
      row :: [String] -> (String, [(String,Double)])
      row l = (head l, sr $ tail l)
  return $ map row d

searchSim::Similarities->String->(String,[(String,Double)])
searchSim s n = head $ filter (\e -> fst e == n) s

showSim :: (String, [(String,Double)]) -> String
showSim (h,t) = unlines $ h:" has similar packages":
    (map showSingleSim t)
  where showSingleSim :: (String,Double)->String
        showSingleSim (s,d) = "  " ++ s ++ " has similarity: " ++ (show d) ++ " %"

printPackageData::PageRanks->Similarities->String->IO ()
printPackageData p s n = do
  putStr $ showPr $ searchPr p n
  putStr $ showSim $ searchSim s n

querySimN :: PageRanks -> Similarities -> IO ()
querySimN p s = do
  name <- getLine
  if name == "" then
    return ()
    else do
      printPackageData p s name
      querySimN p s

main = do
  p <- getPr
  s <- getSimilarities
  querySimN p s

