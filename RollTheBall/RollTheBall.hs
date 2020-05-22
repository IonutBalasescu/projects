{-# OPTIONS_GHC -Wall #-}
{-# LANGUAGE EmptyDataDecls, MultiParamTypeClasses,
             TypeSynonymInstances, FlexibleInstances,
             InstanceSigs #-}

module RollTheBall where
import Pipes
import ProblemState
import qualified Data.Array as A

{-
    Direcțiile în care se poate mișca blocul pe tablă
-}

data Directions = North | South | West | East
    deriving (Show, Eq, Ord)


directions :: [Directions]
directions = [North, South, West, East]

{-
    Sinonim de tip de date pentru reprezetarea unei 
    perechi (int, int)
    care va reține coordonatele de pe tabla jocului
-}

type Position = (Int, Int)

{-
    Tip de date pentru reprezentarea blocurilor de pe tabla
-}
data Cell = Cell Char | Start Char | Win Char 
        | EmptyCell | EmptySpace
    deriving (Eq,Ord)

instance Show Cell where
  show (Cell c) = [c]
  show (Start c) = [c]
  show (Win c) = [c]
  show EmptyCell = [emptyCell]
  show _ = [emptySpace]

-- harta & poz coltului dr jos, Pozitia initiala
data Level = Level (A.Array Position Cell) Position Position
    deriving (Ord)

instance Eq Level where
    (Level arr1 _ _) == (Level arr2 _ _) = arr1 == arr2

getArr :: Level -> (A.Array Position Cell)
getArr (Level a _ _) =  a

chunksOf :: Int -> [a] -> [[a]]
chunksOf nr list = case list of
    [] -> []
    _ ->[take nr list] ++ chunksOf nr (drop nr list)

instance Show Level where
    show (Level a (_,c) _) = [endl] ++ 
	    (concat . map (++ [endl]) $ chunksOf (c + 1)  chars)
    	where
            chars = map (head . show) $ A.elems a
{-
    *** TODO ***

    Primește coordonatele colțului din dreapta jos a hârtii 
    și poziția inițială a blocului.
    Întoarce un obiect de tip Level gol.
    Implicit, colțul din stânga sus este (0, 0).i e -> i
-}

emptyLevel :: Position -> Level
emptyLevel corner@(r,c) = Level (A.array ((0,0), corner)
            [((i,j), EmptySpace)
                | i <- [0..r], j <- [0..c] ]) corner (-1, -1)



createCell :: Char -> (Cell, Bool)
createCell pipe
    | elem pipe startCells = ((Start pipe), True)
    | elem pipe winningCells = ((Win pipe), False)
    | pipe == emptyCell = (EmptyCell, False)
    | otherwise = ((Cell pipe), False)

-- in schelet cfara modificare de semnatura
addCell :: (Char, Position) -> Level -> Level
addCell (pipe, pos) lvl@(Level arr end initial)
    | pipe == emptySpace = lvl
    | not (checkPair pos end) = lvl
    | (not . isEmptySpace) cell = lvl
    | otherwise = (Level newArr end start)
    where
        cell = arr A.! pos
        newArr = arr A.// [(pos, newCell)]
        (newCell, isStart) = createCell pipe
        start
            | isStart = pos
            | otherwise = initial


createLevel :: Position -> [(Char, Position)] -> Level
createLevel = foldr (addCell) . emptyLevel


addPair :: Position -> Position -> Position
addPair (a1,b1) (a2,b2) = (a1 + a2, b1 + b2)


isEmptySpace :: Cell -> Bool
isEmptySpace EmptySpace = True
isEmptySpace _ = False


checkPair :: Position -> Position -> Bool
checkPair (x,y) (r,c)
    | x < 0 || y < 0 || x > r || y > c = False
    | otherwise = True


newPos :: Directions -> (Position -> Position)
newPos North = addPair (-1, 0)
newPos South = addPair (1, 0)
newPos West = addPair (0,-1)
newPos East = addPair (0,1)


isMoveable :: Cell -> Bool
isMoveable EmptySpace = False
isMoveable (Win _) = False
isMoveable (Start _) = False
isMoveable _ = True


moveCell :: Position -> Directions -> Level -> Level
moveCell pos dir (Level arr corner win) = 
    Level newArr corner win
        where
            newArr
                | not  (checkPair pos corner) = arr
                | (not . isMoveable) cell = arr
                | (not . isEmptySpace) newCell = arr
                | otherwise = 
                    arr A.// [(pos, newCell), (swap, cell)]
            swap = newPos dir pos
            cell = arr A.! pos
            newCell
                | checkPair swap corner = arr A.! swap
                | otherwise = EmptyCell


getCell :: (A.Array Position Cell) -> Position -> Cell
getCell arr pos = arr A.! pos
 

convertStart :: Cell -> Directions
convertStart (Start pipe)
        | pipe == startDown = South
        | pipe == startUp = North
        | pipe == startRight = East
        | otherwise = West
convertStart _ = undefined

getNeighbours :: (A.Array Position Cell) -> Position 
                -> [(Directions, Position)]
getNeighbours arr pos = 
    filter (inArr) . map (\d -> (d, newPos d pos)) $ directions
    where 
        inArr (_, (x, y)) = not $ x < 0 || y < 0 || x > r || y > c
        (r,c) = snd . A.bounds $ arr

followPath :: (A.Array Position Cell) -> Position -> Cell -> Bool
followPath _ _ (Win _) = True
followPath _ _ EmptySpace = False
followPath _ _ EmptyCell = False
followPath arr pos cell@(Start _)
    | connection cell nextCell (convertStart cell) =
        followPath newArr nextPos nextCell
    | otherwise = False
    where
        newArr = arr A.// [(pos, (Cell 'X'))]
        nextPos = newPos (convertStart cell) pos
        nextCell = getCell arr nextPos
followPath arr pos cell
    | [] == conns = False
    | otherwise = followPath newArr nextPos nextCell
    where
        conns = filter (\(d, (_, c)) -> connection cell c d) cells
        cells = map (tup) $ getNeighbours arr pos
        tup (dir, p) = (dir, (p, getCell arr p))
        (_,(nextPos, nextCell)) = head conns
        newArr = arr A.// [(pos, (Cell 'X'))]

wonLevel :: Level -> Bool
wonLevel (Level arr _ i) = 
    followPath arr i (arr A.! i)

getStart :: Level -> Position
getStart (Level _ _ i) = i

endDown :: [Cell]
endDown = [(Cell verPipe), (Cell topLeft), (Cell topRight),
         (Start startDown), (Win winDown)]

endUp :: [Cell]
endUp = [(Cell verPipe), (Cell botLeft), (Cell botRight),
         (Start startUp), (Win winUp)]

endRight :: [Cell]
endRight = [(Cell horPipe), (Cell topLeft), (Cell botLeft),
         (Start startRight), (Win winRight)]

endLeft :: [Cell]
endLeft = [(Cell horPipe), (Cell topRight), (Cell botRight),
         (Start startLeft), (Win winLeft)]

-- 2 cazuri 1 conex oriz 1 horpipe 1 end
connection :: Cell -> Cell -> Directions -> Bool
connection cell1 cell2 South
    | elem cell1 endDown && elem cell2 endUp = True
    | otherwise = False
connection cell1 cell2 North
    | elem cell1 endUp && elem cell2 endDown = True
    | otherwise = False
connection cell1 cell2 East
    | elem cell1 endRight && elem cell2 endLeft = True
    | otherwise = False
connection cell1 cell2 West
    | elem cell1 endLeft && elem cell2 endRight = True
    | otherwise = False


instance ProblemState Level (Position, Directions) where
    -- removed the guards because in the bidirectional BFS we want to start from the final Node as well:
    -- | if wonLevel lvl = []
    -- | otherwise = foldl ...
    successors lvl@(Level arr (r,c) _) = foldl (\ acc pos -> (filter ((/= lvl) . snd) . getStates) pos ++ acc) [] positions
        where
            positions = filter (isMoveable . getCell arr) range
            range = [(a,b) | a <- [0..r], b <- [0..c]]
            getStates pos = (map (\ d -> ((pos,d), moveCell pos d lvl)) directions)

    isGoal = wonLevel

    reverseAction (a, s) = (newAction a, s)
        where
            newAction ((x, y), East)  = ((x, y + 1), West)
            newAction ((x, y), West)  = ((x, y - 1), East)
            newAction ((x, y), North) = ((x - 1, y), South)
            newAction ((x, y), South) = ((x + 1, y), North)
