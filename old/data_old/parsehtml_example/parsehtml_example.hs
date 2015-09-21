import Network.HTTP
import Text.HTML.TagSoup

openURL :: String -> IO String
openURL x = getResponseBody =<< simpleHTTP (getRequest x)

packageHTML :: String -> IO String
packageHTML pName = do
  let url = "http://hackage.haskell.org/package/" ++ pName ++ "/dependencies"
  html <- openURL url
  return html

dependencies :: String -> [Tag String]
dependencies s = parseTags s

main :: IO ()
main = do
  html <- packageHTML "graph-utils"
  let dl = dependencies html
  mapM_ (putStrLn . show) dl

{-
haskellHitCount = do
    tags <- fmap parseTags $ openURL "http://wiki.haskell.org/Haskell"
    print tags
    --let count = fromFooter $ head $ sections (~== "<div class=printfooter>") tags
    --putStrLn $ "haskell.org has been hit " ++ show count ++ " times"
-}
