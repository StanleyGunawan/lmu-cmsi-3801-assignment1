module Exercises
    ( change,
    firstThenApply,
    powers,
    meaningfulLineCount,
    Shape(..),
    volume,
    surfaceArea,
    BST(Empty, Node),
    size,
    inorder,
    insert,
    contains
    -- empty
    --toString
      -- put the proper exports here
    ) where

import qualified Data.Map as Map
import Data.Text (pack, unpack, replace)
import Data.List(isPrefixOf, find)
import Data.Char(isSpace)

change :: Integer -> Either String (Map.Map Integer Integer)
change amount
    | amount < 0 = Left "amount cannot be negative"
    | otherwise = Right $ changeHelper [25, 10, 5, 1] amount Map.empty
        where
          changeHelper [] remaining counts = counts
          changeHelper (d:ds) remaining counts =
            changeHelper ds newRemaining newCounts
              where
                (count, newRemaining) = remaining `divMod` d
                newCounts = Map.insert d count counts

-- Write your first then apply function here
firstThenApply :: [a] -> (a -> Bool) -> (a -> b) -> Maybe b
firstThenApply xs predicate func = fmap func (find predicate xs)

-- Write your infinite powers generator here
powers :: Integer -> [Integer]
powers base = map (base^) [0..]

-- Write your line count function here
meaningfulLineCount :: FilePath -> IO Int
meaningfulLineCount path = do
    contents <- readFile path
    return $ length $ filter meaningfulLine $ lines contents
    where
      meaningfulLine line = not (all isSpace line) && not ("#" `isPrefixOf` (dropWhile isSpace line))

-- Write your shape data type here
data Shape = Sphere Double | Box Double Double Double 
    deriving (Eq, Show)

volume :: Shape -> Double
volume (Sphere r) = (4 / 3) * pi * r^3
volume (Box w h d) = w * h * d

surfaceArea :: Shape -> Double
surfaceArea (Sphere r) = 4 * pi * r^2
surfaceArea (Box w h d) =  2 * (w * h + w * d + h * d)

-- Write your binary search tree algebraic type here


data BST a = Empty | Node a (BST a) (BST a) 

size :: BST a -> Int
size Empty = 0
size (Node _ left right) = 1 + size left + size right

contains :: (Ord a) => a -> BST a -> Bool
contains _ Empty = False
contains item (Node target left right)
    | item < target = contains item left
    | item > target = contains item right
    | otherwise = True

insert :: (Ord a) => a -> BST a -> BST a
insert item Empty = Node item Empty Empty
insert item (Node target left right)
    | item < target = Node target (insert item left) right
    | item > target = Node target left (insert item right)
    | otherwise = Node target left right  

inorder :: BST a -> [a]
inorder Empty = []
inorder (Node item left right) = inorder left ++ [item] ++ inorder right

toString :: (Show a) => BST a -> String
toString Empty = "()"
toString (Node item left right) = "(" ++ toString left ++ " " ++ show item ++ " " ++ toString right ++ ")"

removeExtraParen :: String -> String
removeExtraParen f = unpack (replace (pack "()") (pack "") (pack f))
instance (Show a) => Show (BST a) where
    show :: Show a => BST a -> String
    show Empty = "()"
    show (Node value left right) = removeExtraParen ("(" ++ show left ++ show value ++ show right ++ ")")