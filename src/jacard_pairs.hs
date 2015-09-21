
import qualified Math.LinearAlgebra.Sparse.Matrix as SM
import qualified Math.LinearAlgebra.Sparse.Vector as SV
import qualified Data.Map.Lazy as MP
import qualified Data.IntMap.Lazy as IM
import qualified Data.Maybe as DM

inputPath = "data/clean_dependencies.txt"
outputPath = "data/jacard_pairs.txt"

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

cosineSimilarity :: SV.SparseVector Double -> SV.SparseVector Double -> Double
cosineSimilarity a b
  | am == 0 || bm == 0 = 0
  | otherwise = (SV.dot a b) / (am * bm)
    where am = l2norm a
	  bm = l2norm b

jacardSimilarity :: SV.SparseVector Double -> SV.SparseVector Double -> Double
jacardSimilarity a b
  | SV.dim a /= SV.dim b = error "two vectors input to jacardSimilarity must have same length"
  | unionN == 0 = 0
  | otherwise = intersectionN / unionN
  where am = SV.vec a
        bm = SV.vec b
        intersectionN = countNonzero $ IM.intersection am bm
        unionN = countNonzero $ IM.union am bm

jacardSimilarityNames :: SM.SparseMatrix Double -> MP.Map String Int -> (String, String) -> Double
jacardSimilarityNames m n (a, b) = jacardSimilarity av bv
  where av = SM.row m (DM.fromMaybe (-1) (MP.lookup a n))
        bv = SM.row m (DM.fromMaybe (-1) (MP.lookup b n))

allPairs :: [a] -> [(a,a)]
allPairs [] = []
allPairs (a:ax) = (map (\e -> (a,e)) ax) ++ (allPairs ax)

jacardSimilarityOutput :: [[String]] -> String
jacardSimilarityOutput d = unlines $ zipWith showRow p j
  where a = adjacencyMatrix d
        n = namesMap d
        p = allPairs $ map head d
        j = map (jacardSimilarityNames a n) p
        showRow :: (String, String) -> Double -> String
        showRow (x,y) z = x ++ " " ++ y ++ " " ++ (show z)

main = do
  s <- readFile inputPath
  let d = formatInput s
  let o = jacardSimilarityOutput d
  writeFile outputPath o

