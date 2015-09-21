import Text.XML.HXT.Core
import Text.HandsomeSoup
import Text.CSS.Parser

main = do
  let doc = fromUrl "http://hackage.haskell.org/package/graph-utils/dependencies"
  links <- runX $ doc >>> Text.HandsomeSoup.css "#detailed-dependencies a" >>> getChildren >>> isText >>> getText
  putStrLn . show $ links
  --mapM_ (putStrLn . show) links


