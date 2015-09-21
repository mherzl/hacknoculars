import Text.XML.HXT.Core
import Text.HandsomeSoup
import Text.CSS.Parser

fetch_package_names :: FilePath -> IO [String]
fetch_package_names filePath = do
  contents <- readFile filePath
  let packageNames = lines contents
  return packageNames

fetch_package_dependencies :: String -> IO [String]
fetch_package_dependencies packageName = do
  let doc = fromUrl $ "http://hackage.haskell.org/package/" ++ packageName ++ "/dependencies"
  links <- runX $ doc >>> Text.HandsomeSoup.css "#detailed-dependencies a"
    >>> getChildren >>> isText >>> getText
  return links

main = do
  packageNames <- fetch_package_names "package_names.txt"
  dependencyLists <- mapM fetch_package_dependencies ({-take 5 -}packageNames)
  let writeLine = map (\(a,b) -> a:b) $ zip packageNames dependencyLists
  let fileName = "package_dependencies.txt"
  writeFile fileName $ unlines $ map unwords writeLine

