
import qualified Math.LinearAlgebra.Sparse.Matrix as SM
import qualified Math.LinearAlgebra.Sparse.Vector as SV
import qualified Data.Map.Lazy as MP
import qualified Data.IntMap as IM
import qualified Data.Maybe as DM

--inputPath = "data/sampleDep.txt"
--inputPath = "cat_mouse.txt"
inputPath = "data/clean_dependencies.txt"
outputPath = "data/page_rank.txt"

formatInput :: String -> [[String]]
formatInput s = map words $ lines s

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

stochastifyVec :: SV.SparseVector Double -> SV.SparseVector Double
stochastifyVec r
  | IM.null v = let k = 1.0 / (fromIntegral n :: Double)
    in SV.sparseList $ replicate n k
  | otherwise = let k = 1.0 / (IM.foldl (+) 0 v) :: Double
    in SV.SV{SV.dim = n, SV.vec = IM.map (*k) v}
    where v = SV.vec r
          n = SV.dim r
          --s = fromIntegral $ length v :: Double
          --s = fromIntegral $ IM.size v :: Double

stochastify :: SM.SparseMatrix Double -> SM.SparseMatrix Double
stochastify m = SM.fromRows $
  map (stochastifyVec . SM.row m) [1..(SM.height m)]

powerIterationN :: SM.SparseMatrix Double -> Int
  -> SV.SparseVector Double -> SV.SparseVector Double
powerIterationN m i v
  | i == 0 = w
  | otherwise = powerIterationN m (i-1) w
    where w = SM.mulMV m $ stochastifyVec v

powerIteration :: SM.SparseMatrix Double ->
  SV.SparseVector Double -> SV.SparseVector Double
powerIteration m v
  | next == v = next
  | otherwise = powerIteration m next
    where next = SM.mulMV m $ stochastifyVec v

pageRankN :: SM.SparseMatrix Double -> Int -> SV.SparseVector Double
pageRankN m n = powerIterationN (SM.trans $ stochastify m) (n-1) v
  where v = stochastifyVec $ SV.zeroVec $ SM.height m

pageRank :: SM.SparseMatrix Double -> SV.SparseVector Double
pageRank m = powerIteration (SM.trans $ stochastify m) v
  where v = stochastifyVec $ SV.zeroVec $ SM.height m

deleteDuplicates :: (Eq a) => [a] -> [a]
deleteDuplicates [] = []
deleteDuplicates (a:ax)
  | elem a ax = deleteDuplicates ax
  | otherwise = a:(deleteDuplicates ax)

outputString :: String -> String
outputString s = unlines $ zipWith (\a b -> a ++ " " ++ b) names r
  where d = formatInput s
        names = map head d
        --v = pageRankN (adjacencyMatrix d) 1000
        v = pageRankN (adjacencyMatrix d) 100000
        --v = pageRank $ adjacencyMatrix d
        r = map show $ SV.fillVec v

sVecSum :: SV.SparseVector Double -> Double
sVecSum v = IM.foldl (+) 0 (SV.vec v)

main = do
  s <- readFile inputPath
  let o = outputString s
  writeFile outputPath o
  {-
  let d = formatInput s
      names = map head d
      a = adjacencyMatrix d
  print a
  -}

