
type PageRanks = [(String,Double)]

getPr :: IO [(String,Double)]
getPr = do
  s <- readFile "data/page_rank.txt"
  let d = map words $ lines s
      pr :: [String] -> (String,Double)
      pr (a:b:[]) = (a, read b)
      pr _ = error "input list should only have length 2"
  return $ map pr d

searchPr :: PageRanks -> String -> (String,Double)
searchPr pr n = head $ filter (\(a,b) -> a==n) pr

showPr :: (String,Double) -> String
showPr (n,p) = n ++ " has pagerank: " ++ (show p)

searchPrPercentileFrac :: PageRanks -> String -> (String,Double)
searchPrPercentileFrac p s = (s, (fromIntegral $ length $ filter (<f) $ map snd p)
    / (fromIntegral $ length p ::Double))
  where f = snd $ searchPr p s

searchPrPercentile :: PageRanks -> String -> (String,Double)
searchPrPercentile p s = (a, 100*b)
  where (a,b) = searchPrPercentileFrac p s

showPrPercentile :: (String,Double) -> String
showPrPercentile (n,p) = n ++ " has pagerank percentile: " ++ (show p)

indentation :: PageRanks -> String -> String
indentation p s = replicate i '-'
  where i = fromIntegral $ floor $ (snd $ searchPrPercentile p s) / 10

type Similarities = [(String, [(String, Double)])]

getSimilarities :: IO Similarities
getSimilarities = do
  s <- readFile "data/jacard_matches.txt"
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

makeLength :: Int -> String -> String
makeLength n s
  | length s < n = s ++ (replicate (n - (length s)) ' ')
  | otherwise = take n s

showSim :: PageRanks -> (String, [(String,Double)]) -> String
showSim p (h,t) = unlines $ (h ++ " has similar packages:"):
    (map showSingleSim t)
  where showSingleSim :: (String,Double)->String
        showSingleSim (s,d) = " " ++ s ++ minusmax ++ " " ++ indent ++ "- " ++ " has similarity: " ++ (makeLength 4 $ show $ d) ++ " and pagerank-percentile: " ++ (makeLength 4 $ show $ snd $ searchPrPercentile p s)
          where indent = indentation p s
                maxlength = maximum $ map (\(s,d) -> (length s) + (length $ indentation p s)) t :: Int
                minusmax = replicate (maxlength - (length s) - (length indent)) ' ' :: String

printPackageData::PageRanks->Similarities->String->IO ()
printPackageData p s n = do
  putStrLn $ showPr $ searchPr p n
  putStrLn $ showPrPercentile $ searchPrPercentile p n
  putStr $ showSim p $ searchSim s n

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

