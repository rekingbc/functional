
safeInvert :: Float -> Maybe Float
safeInvert 0.0 = Nothing
safeInvert x   = Just (1.0 / x)

maybeAdd :: Maybe Float -> Maybe Float -> Maybe Float
maybeAdd Nothing (Just x) = Just x
maybeAdd (Just x) Nothing = Just x
maybeAdd (Just x) (Just y) = Just (x + y)

data BST a = EmptyBST | Node a (BST a) (BST a)
  deriving (Eq, Show, Read)

bstInsert :: Ord a => BST a -> a -> BST a
bstInsert EmptyBST x          = Node x EmptyBST EmptyBST
bstInsert (Node val left right) x  = if x < val then
                                        (Node val (bstInsert left x) right)
                                     else
                                        (Node val left (bstInsert right x))

root1 :: Float -> Float
root1 x = sqrt (abs (negate x))

root2 :: Float -> Float
root2 = sqrt . abs . negate

myfoldr :: (a -> b -> b) -> b -> [a] -> b
myfoldr _ init_val []     = init_val
myfoldr f init_val (x:xs) = f x (myfoldr f init_val xs)

myfoldl :: (b -> a -> b) -> b -> [a] -> b
myfoldl f acc []        = acc
myfoldl f acc (x:xs)    = myfoldl f (f acc x) xs

----------------------------------------------------------

data List a = Nil | Cons a (List a) deriving Show

instance Functor List where
  fmap f Nil = Nil
  fmap f (Cons car cdr) = Cons (f car) (fmap f cdr)

main = do
putStrLn "Hello, what's your name?"
name <- getLine
putStrLn ("Hello " ++ name ++ ", how is it going?")
