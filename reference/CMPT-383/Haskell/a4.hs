-- Question 1
snoc :: a -> [a] -> [a]
snoc el []        = [el]
snoc el (x:xs)    = x : (snoc el (xs))
--------------------------------------------------------------------------

-- Question 2
myappend :: [a] -> [a] -> [a]
myappend x []         = x
myappend x (y:ys)     = myappend (snoc y x) ys
--------------------------------------------------------------------------

-- Question 3
myreverse :: [a] -> [a]
myreverse []       = []
myreverse (x:xs)   = (myappend (myreverse xs) [x])
--------------------------------------------------------------------------

-- Question 4
find_prime :: Integer -> Integer -> Bool
find_prime n d
    | n <= 2                = False
    | d == 1                = True
    | n `mod` d == 0        = False
    | otherwise             = find_prime n (d-1)

is_prime :: Integer -> Bool
is_prime n        = if n < 0 then error "Less than 0" else find_prime n (n-1)

reverseInt :: Integer -> Integer
reverseInt n      = read $ myreverse (show n) :: Integer

is_emirp :: Integer -> Bool
is_emirp n
    | n == reverseInt n       = False
    | otherwise               = is_prime n && is_prime (reverseInt n)

count_emirps :: Integer -> Integer
count_emirps n
    | n == 0          = 0
    | is_emirp n      = 1 + count_emirps (n - 1)
    | otherwise       = count_emirps (n - 1)
--------------------------------------------------------------------------

-- Question 5
find_element :: (a -> Int) -> a -> [a] -> a
find_element f x xs
    | null xs                 = x
    | f x < f (head xs)       = find_element f (head xs) (tail xs)
    | otherwise               = find_element f x (tail xs)


biggest_sum :: [[Int]] -> [Int]
biggest_sum (x:xs)        = find_element sum x xs
--------------------------------------------------------------------------

--Question 6
greatest :: (a -> Int) -> [a] -> a
greatest f (x:xs)         = find_element f x xs
--------------------------------------------------------------------------

--Question 7
is_bit :: Int -> Bool
is_bit x
    | x == 0      = True
    | x == 1      = True
    | otherwise   = False
--------------------------------------------------------------------------

--Question 8
flip_bit :: Int -> Int
flip_bit x
    | x == 0              = 1
    | x == 1              = 0
    | not(is_bit x)       = error "x is not a bit"
--------------------------------------------------------------------------

--Question 9-a
is_bit_seq1 :: [Int] -> Bool
is_bit_seq1 seq
    | null seq                  = True
    | not(is_bit (head seq))    = False
    | is_bit (head seq)         = is_bit_seq1 (tail seq)

--Question 9-b
is_bit_seq2 :: [Int] -> Bool
is_bit_seq2 []          = True
is_bit_seq2 seq         = if is_bit(head seq) then is_bit_seq2(tail seq) else False

--Question 9-c
-- all (a -> Bool) -> [a] -> Bool
is_bit_seq3 :: [Int] -> Bool
is_bit_seq3 []          = True
is_bit_seq3 seq         = all is_bit seq
--------------------------------------------------------------------------

--Question 10-a
invert_bits1 :: [Int] -> [Int]
invert_bits1 seq
    | null seq                = []
    | is_bit_seq1 seq         = flip_bit (head seq) : invert_bits1 (tail seq)
    | otherwise               = error "Not a bit list"

--Question 10-b
invert_bits2 :: [Int] -> [Int]
invert_bits2 seq = map flip_bit seq

--Question 10-c
invert_bits3 :: [Int] -> [Int]
invert_bits3 seq = [flip_bit x | x <- seq]
--------------------------------------------------------------------------

--Question 11
count :: Int -> [Int] -> Int
count n seq
    | null seq              = 0
    | n == head seq         = 1 + count n (tail seq)
    | otherwise             = count n (tail seq)

bit_count :: [Int] -> (Int, Int)
bit_count seq         = (count 0 seq, count 1 seq)
--------------------------------------------------------------------------

--Question 12
all_basic_bit_seqs :: Int -> [[Int]]
all_basic_bit_seqs n
    | n <= 0           = []
    | otherwise        = sequence (replicate n [0,1])
--------------------------------------------------------------------------

--Question 13
data List a = Empty | Cons a (List a)
    deriving Show

toList :: [a] -> List a
toList lst
    | null lst            = Empty
    | otherwise           = Cons (head lst) (toList (tail lst))
--------------------------------------------------------------------------

--Question 14
toHaskellList :: List a -> [a]
toHaskellList Empty             = []
toHaskellList (Cons head tail)    = head : (toHaskellList tail)
--------------------------------------------------------------------------

--Question 15
append :: List a -> List a -> List a
append Empty (Cons head tail)                     = (Cons head tail)
append (Cons head1 tail1) (Cons head2 tail2)      = (Cons head1 (append tail1 (Cons head2 tail2)))
--------------------------------------------------------------------------

--Question 16 && Question 17 xx




inc:: Int -> Int -> Int
inc x y = x + y

inc1 = inc 5



f :: Int -> Int
f n = n + 1

g :: Int -> Int
g n = 2*n - 1
h = f . g  -- h is the composition of f and g
