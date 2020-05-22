{-# OPTIONS_GHC -Wall #-}
{-# LANGUAGE MultiParamTypeClasses, FunctionalDependencies,
  FlexibleContexts, InstanceSigs #-}

module AStarHeuristic where
import RollTheBall
import Pipes
import ProblemState

import Data.Hashable
import qualified Data.HashSet as H
import qualified Data.Array as A
import Data.Array

instance Hashable Cell where
	hashWithSalt :: Int -> Cell -> Int
	hashWithSalt i (Cell c) = hashWithSalt i c
	hashWithSalt i (Start c) = hashWithSalt i c
	hashWithSalt i (Win c) = hashWithSalt i c
	hashWithSalt i EmptyCell = hashWithSalt i emptyCell
	hashWithSalt i EmptySpace = hashWithSalt i emptySpace

instance Hashable Level where
	hashWithSalt :: Int -> Level -> Int
	hashWithSalt i (Level arr1 _ _) = hashWithSalt i $ elems arr1

neighbours :: (Level -> H.HashSet Level)
neighbours = H.fromList . map snd . successors

distance :: (Num c) => (Level -> Level -> c)
distance _ _ = 1

nonTrivialHeuristic :: (Num c) => Level -> c
nonTrivialHeuristic (Level arr _ i) = (-) constant $ howMuchCanRoll arr i (arr A.! i) 1

trivialHeuristic :: (Num a) => Level -> a
trivialHeuristic _ = 1

constant :: (Num c) => c
constant = 7

howMuchCanRoll :: (Num a) => (A.Array Position Cell) -> Position -> Cell -> a -> a
howMuchCanRoll _ _ (Win _) d = d
howMuchCanRoll _ _ EmptySpace d = d
howMuchCanRoll _ _ EmptyCell d = d
howMuchCanRoll arr pos cell@(Start _) d
    | connection cell nextCell (convertStart cell) =
        howMuchCanRoll newArr nextPos nextCell $ d + 1
    | otherwise = d
    where
        newArr = arr A.// [(pos, (Cell 'X'))]
        nextPos = newPos (convertStart cell) pos
        nextCell = getCell arr nextPos
howMuchCanRoll arr pos cell d
    | [] == conns = d
    | otherwise = howMuchCanRoll newArr nextPos nextCell $ d + 1
    where
        conns = filter (\(dd, (_, c)) -> connection cell c dd) cells
        cells = map (tup) $ getNeighbours arr pos
        tup (dir, p) = (dir, (p, getCell arr p))
        (_,(nextPos, nextCell)) = head conns
        newArr = arr A.// [(pos, (Cell 'X'))]

isGoalNode :: Level -> Bool
isGoalNode = isGoal 

