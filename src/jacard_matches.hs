
import qualified Math.LinearAlgebra.Sparse.Matrix as SM
import qualified Math.LinearAlgebra.Sparse.Vector as SV
import qualified Data.IntMap.Lazy as IM
import qualified Data.Map.Lazy as MP
import qualified Data.Maybe as DM
import qualified Data.List as DL

inputPath = "data/clean_dependencies.txt"
outputPath = "data/jacard_matches.txt"

removeZeroDep :: [[String]] -> [[String]]
removeZeroDep d = filter (\(e:ex) -> ex /= []) d

formatInput :: String -> [[String]]
formatInput s = {-removeZeroDep $ -}map words $ lines s

depMap :: [[String]] -> MP.Map String [String]
depMap s = foldl ins (MP.empty) s
  where ins :: MP.Map String [String] -> [String] -> MP.Map String [String]
        ins m [] = m
        ins m (n:d) = MP.insert n d m

namesMap :: [[String]] -> MP.Map String Int
namesMap s = foldl (\a (s,n) -> MP.insert s n a) (MP.empty) nameNum
  where nameNum = zipWith (\(s:sx) n -> (s,n)) s [1..(length s)]

insertDeps :: MP.Map String [String] -> MP.Map String Int ->
              SM.SparseMatrix Double -> String -> SM.SparseMatrix Double
insertDeps depM nameM m p = foldl insDep m deps
  where i = DM.fromMaybe 0 (MP.lookup p nameM)
        insDep :: SM.SparseMatrix Double -> String -> SM.SparseMatrix Double
        insDep m d = SM.ins m ((i, DM.fromMaybe 0 (MP.lookup d nameM)), 1)
        deps = DM.fromMaybe [] (MP.lookup p depM)

adjacencyMatrix :: [[String]] -> SM.SparseMatrix Double
adjacencyMatrix d = foldl (insertDeps depM nameM) (SM.zeroMx (n,n)) names
  where names = map head d
        n = length names
        depM = depMap d
        nameM = namesMap d

countNonzero :: IM.IntMap Double -> Double
countNonzero v = foldl (\a e -> a + (abs $ signum e)) 0 (IM.elems v)

l1norm :: SV.SparseVector Double -> Double
l1norm v = foldl (\a e -> e + a) 0 (IM.elems $ SV.vec v)

l2norm :: SV.SparseVector Double -> Double
l2norm v = sqrt $ foldl (\a e -> a + e*e) 0 (IM.elems $ SV.vec v)

cosineSim :: SV.SparseVector Double -> SV.SparseVector Double -> Double
cosineSim a b
  | am == 0 || bm == 0 = 0
  | otherwise = (SV.dot a b) / (am * bm)
    where am = l2norm a
	  bm = l2norm b

jacardSim :: SV.SparseVector Double -> SV.SparseVector Double -> Double
jacardSim a b
  | SV.dim a /= SV.dim b = error "two vectors input to jacardSim must have same length"
  | unionN == 0 = 0
  | otherwise = intersectionN / unionN
  where am = SV.vec a
        bm = SV.vec b
        intersectionN = countNonzero $ IM.intersection am bm
        unionN = countNonzero $ IM.union am bm

jacardSimNames :: SM.SparseMatrix Double -> MP.Map String Int
    -> (String, String) -> Double
jacardSimNames m n (a, b) = jacardSim av bv
  where av = SM.row m (DM.fromMaybe (-1) (MP.lookup a n))
        bv = SM.row m (DM.fromMaybe (-1) (MP.lookup b n))

sortTuplesBySecondDesc :: Ord b => [(a,b)] -> [(a,b)]
sortTuplesBySecondDesc t = DL.sortBy f t
  where f :: Ord b => (a,b) -> (a,b) -> Ordering
        f (_,x) (_,y) = compare y x

jacardSimTopN :: Int -> SM.SparseMatrix Double -> MP.Map String Int
    -> String -> [(String,Double)]
jacardSimTopN i m p s = sortTuplesBySecondDesc $ foldl insertIf [] (MP.keys p)
  where insertIf :: [(String,Double)] -> String -> [(String,Double)]
        insertIf a e
          | length a < i = (e,j):a
          | j > mn = (e,j):(filter (\(x,y) -> y>mn) a)
          | otherwise = a
          where j = jacardSimNames m p (s,e)
                mn = minimum $ map snd a

jacardSimTopNAll :: Int -> [[String]] -> [[String]]
jacardSimTopNAll i d = map jsTopNLine (MP.keys p)
  where m = adjacencyMatrix d
        p = namesMap d
        jsTopN :: String -> [(String,Double)]
        jsTopN s = jacardSimTopN i m p s
        showPair :: (String,Double) -> String
        showPair (a,b) = a ++ " " ++ (show b)
        jsTopNLine :: String -> [String]
        jsTopNLine s = s:(map showPair $ jsTopN s)

jacardSimTopNAllOutput :: Int -> [[String]] -> String
jacardSimTopNAllOutput i d = unlines $ map unwords $ jacardSimTopNAll i d

main = do
  s <- readFile inputPath
  let d = formatInput s
  writeFile outputPath $ jacardSimTopNAllOutput 25 d

