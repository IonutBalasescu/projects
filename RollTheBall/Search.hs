{-# OPTIONS_GHC -Wall #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Search where

import ProblemState
import Data.Maybe
import qualified Data.List as L
import qualified Data.Set as S
{-
    *** TODO ***

    Tipul unei nod utilizat în procesul de căutare. Recomandăm reținerea unor
    informații legate de:

    * stare;
    * acțiunea care a condus la această stare;
    * nodul părinte, prin explorarea căruia a fost obținut nodul curent;
    * adâncime
    * copiii, ce vor desemna stările învecinate
-}

data Node s a = Node {
                    state :: s,
                    parent :: Maybe (Node s a),
                    depth :: Int,
                    action :: Maybe a,
                    children :: [Node s a]
                    }

instance Show s => Show (Node s a) where
    show = show . state

instance Eq s => Eq (Node s a) where
    node1 == node2 = state node1 == state node2
instance Ord s => Ord (Node s a) where
    n1 <= n2 = state n1 <= state n2
{-
    *** TODO ***

    Întoarce starea stocată într-un nod.
-}

nodeState :: Node s a -> s
nodeState = state
nodeParent :: Node s a -> Maybe (Node s a)
nodeParent = parent
nodeAction :: Node s a -> Maybe a
nodeAction = action
nodeDepth :: Node s a -> Int
nodeDepth = depth
nodeChildren :: Node s a -> [Node s a]
nodeChildren = children

{-
    *** TODO ***

    Generarea întregului spațiu al stărilor
    Primește starea inițială și creează nodul corespunzător acestei stări,
    având drept copii nodurile succesorilor stării curente.
-}

createStateSpace :: (ProblemState s a, Eq s) => s -> Node s a
createStateSpace fState = node where
    node = Node fState Nothing 0 Nothing $ map (helpCreateStateSpace 1 node) $ successors fState

helpCreateStateSpace dpt parentNode (act, nextState) = newNode where
    newNode = Node nextState (Just parentNode) dpt (Just act)
        $ map (helpCreateStateSpace (dpt + 1) newNode)
           $ filter (\(_,x) -> x /= state parentNode) $ successors nextState

printSpacedList :: Show a => [a] -> IO ()
printSpacedList = mapM_ (\a -> print a >> putStrLn (replicate 20 '*'))


-- MIHNEA

-- Functie care extrage perechile de (actiune generatoare, stare) din lantul de noduri
-- oferit de bidirectionalBFS
solve :: (ProblemState s a, Ord s)
      => s          -- Starea inițială de la care se pornește
      -> s          -- Starea finala la care se ajunge
      -> [(Maybe a, s)]   -- Lista perechilor
solve st1 st2 = extractPath2 $ bidirBFS (createStateSpace st1) (createStateSpace st2)

-- Combinarea celor 2 drumuri generate de bfs.
-- Pentru al 2lea drum, trebuie sa il inversam si sa inversam actiunile
extractPath2 :: (ProblemState s a, Ord s) => (Node s a, Node s a) -> [(Maybe a, s)] 
extractPath2 (node1, node2) = (extractPath node1) ++ reversedPath
    where reversedPath = zipWith (\(a1, s1) (a2, s2) -> (Just (fst (reverseAction (fromJust a2, s1))), s1)) (tail pathFromEnd) pathFromEnd
          pathFromEnd = reverse $ extractPath node2

extractPath :: Node s a -> [(Maybe a, s)]
extractPath node = map (\x -> (action x, state x))
                   $ foldl (\x _ -> (fromJust . parent $ head x) : x) [node] [1 .. depth node]

-- Functie care realizeaza un bfs bidirectional. Se pornesc 2 cautari paralele
-- din nodul sursa si din nodul destinatie. Algoritmul se opreste cand cele 2 frontiere
-- se intersecteaza si apoi se combina cele 2 drumuri.
-- Functiile de bfs intorc un flux de noduri si astfel putem sa ne folosim de
-- evaluarea lenesa.
bidirBFS :: Ord s => Node s a -> Node s a -> (Node s a, Node s a)
bidirBFS st1 st2 = head $ catMaybes $ zipWith find (bfs st1) (bfs st2)
  where
    find :: Ord s => ([Node s a], [Node s a]) -> ([Node s a], [Node s a]) -> Maybe (Node s a, Node s a)
    find (nodes1, frontier1) (nodes2, frontier2)
        | not $ null list1 = Just $ head list1
        | not $ null list2 = Just $ head list2
        | otherwise     = Nothing
      where
        list1 = [(x, y) | x <- nodes1, y <- frontier2, x == y]
        list2 = [(y, x) | x <- nodes2, y <- frontier1, x == y]

bfs :: Ord s => Node s a -> [([Node s a], [Node s a])]  -- (notVisitedChildren, newFrontier)
bfs nd = bfs' S.empty [nd]

bfs' :: Ord s => S.Set (Node s a) -> [Node s a] -> [([Node s a], [Node s a])]
-- ar trebui modifcată încât să se oprească atunci când frontiera devine vidă
bfs' visited [] = []
bfs' visited frontier = [(notVisitedChildren, newFrontier)] ++ bfs' newVisited newFrontier
    where notVisitedChildren = filter (\n -> not $ n `S.member` visited) (children nd) 
          newFrontier = tail frontier ++ notVisitedChildren
          newVisited = nd `S.insert` visited
          nd = head frontier
