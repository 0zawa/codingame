import System.IO
import Control.Monad

data Size   = Size { width::Float, height::Float } deriving Show
data Pos    = Pos { x::Float, y::Float } deriving Show

main :: IO ()
main = do
    hSetBuffering stdout NoBuffering -- DO NOT REMOVE
    
    -- Auto-generated code below aims at helping you parse
    -- the standard input according to the problem statement.
    
    input_line <- getLine
    let input = words input_line
    let w = read (input!!0) :: Float -- width of the building.
    let h = read (input!!1) :: Float -- height of the building.
    input_line <- getLine
    let n = read input_line :: Int -- maximum number of turns before game over.
    input_line <- getLine
    let input = words input_line
    let x0 = read (input!!0) :: Float
    let y0 = read (input!!1) :: Float
    let size    = Size w h
    let pos     = Pos x0 y0
    
    hPutStrLn stderr $ show size
    
    loop size pos (Pos 0 0) (Pos w h)

get_next_pos_w :: String -> Size -> Pos -> Pos -> Pos -> Float
get_next_pos_w dir size pos pos_min pos_max 
    | 'L' `elem` dir    = x pos - (x pos - x pos_min) / 2.0 
    | 'R' `elem` dir    = x pos + (x pos_max - x pos) / 2.0
    | otherwise         = x pos

get_next_pos_h :: String -> Size -> Pos -> Pos -> Pos -> Float  
get_next_pos_h dir size pos pos_min pos_max 
    | 'U' `elem` dir    = y pos - (y pos - y pos_min) / 2.0 
    | 'D' `elem` dir    = y pos + (y pos_max - y pos) / 2.0
    | otherwise         = y pos

get_next_pos :: String -> Size -> Pos -> Pos -> Pos -> Pos
get_next_pos dir size pos pos_min pos_max = 
    Pos x y
    where   
        x = get_next_pos_w dir size pos pos_min pos_max
        y = get_next_pos_h dir size pos pos_min pos_max
        
get_pos_min :: String -> Pos -> Pos -> Pos
get_pos_min dir pos pos_min = Pos new_x new_y
    where   new_x   | 'R' `elem` dir    = x pos
                    | otherwise         = x pos_min
            new_y   | 'D' `elem` dir    = y pos
                    | otherwise         = y pos_min

get_pos_max :: String -> Pos -> Pos -> Pos
get_pos_max dir pos pos_max = Pos new_x new_y
    where   new_x   | 'L' `elem` dir    = x pos
                    | otherwise         = x pos_max
            new_y   | 'U' `elem` dir    = y pos
                    | otherwise         = y pos_max

loop :: Size->Pos->Pos->Pos->IO ()
loop size pos pos_min pos_max = do

    input_line <- getLine
    -- let bomb_dir = read input_line :: String -- the direction of the bombs from batman's current location (U, UR, R, DR, D, DL, L or UL)
    let bomb_dir =  input_line -- the direction of the bombs from batman's current location (U, UR, R, DR, D, DL, L or UL)
    
    let to = get_next_pos bomb_dir size pos pos_min pos_max
    
    let new_pos_min = get_pos_min bomb_dir pos pos_min
    let new_pos_max = get_pos_max bomb_dir pos pos_max

    --- print for debug.    
    hPutStrLn stderr $ bomb_dir
    hPutStrLn stderr $ show new_pos_min
    hPutStrLn stderr $ show new_pos_max

    -- the location of the next window Batman should jump to.
    -- putStrLn "0 0"
    hPutStrLn stderr $ show (x pos) ++ "|" ++ show (y pos)
    hPutStrLn stderr $ show (x to) ++ "/" ++ show (y to)

    putStrLn $ show (truncate (x to)) ++ " " ++ show (truncate (y to))
    
    loop size to new_pos_min new_pos_max

