import Text.XML.HXT.Core
import Text.HandsomeSoup
import Text.CSS.Parser

fetch_package_names :: FilePath -> IO [String]
fetch_package_names filePath = do
  contents <- readFile filePath
  let packageNames = lines contents
  return packageNames

fetch_pubdates :: String -> IO [String]
fetch_pubdates packageName = do
  let doc = fromUrl $ "http://hackage.haskell.org/package/" ++ packageName
  links <- runX $ doc >>> Text.HandsomeSoup.css "#content .properties tbody:nth-child(10) th"
    >>> getChildren >>> isText >>> getText
  return links

main = do
  packageNames <- fetch_package_names "data/package_names.txt"
  pubdates <- mapM fetch_pubdates (take 5 packageNames)
  print pubdates
  let writeLine = map (\(a,b) -> a:b) $ zip packageNames pubdates
  let fileName = "data/pubdates.txt"
  writeFile fileName $ unlines $ map unwords writeLine

