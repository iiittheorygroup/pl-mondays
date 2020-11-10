main :: IO ()
main = undefined

data Maybe' a
  = Just' a
  | Nothing'
    {-
template<class a>
  class Maybe' {
  struct Just' {
    a value;
  };
  struct Nothing {

  };
  union {
    Just' j;
    Nothing n;
  }
}
       -}

head :: [a] -> Maybe' a
head [] = Nothing'
head (x:_) = Just' x

add1 :: Maybe' Int -> Maybe Int
add1 (Just' x) = Just (x + 1)
add1 Nothing' = Nothing

instance Functor Maybe' where
  fmap f (Just' x) = Just' (f x)
  fmap f (Nothing') = Just' 0

-- fmap id x = x
-- fmap (f . g) = fmap f . fmap g
-- fmap (1 +) (Just 4)
data StupidFunctor a =
  NothingAtAll

instance Functor StupidFunctor where
  fmap f NothingAtAll = NothingAtAll

-- SimpleRandInt
-- x = rand(1,3)
-- y = x + 3
-- z = x + 2
-- w = z when z != 6
-- print w
wrapped_x = [1 .. 3]

wrapped_y = fmap (+ 3) wrapped_x -- [4, 5, 6]

wrapped_z = fmap (+ 2) wrapped_y -- [6, 7, 8]

wrapped_w = [7, 8]

------------------------------------------------------
myf = (Just 4) >>= (\x -> Just (x + 1)) >>= (\y -> Just (y * 2))

myf' = do
  x <- Nothing
  y <- Just (x + 1)
  return (y * 2)

myf'' = do
  x <- [1, 2, 3]
  y <- [4, 5, 6]
  return (x + y)

myIO' = readLn >>= (\s -> return (s ++ ", hello!"))

myIO = do
  s <- readLn :: IO String
  return (s ++ ", hello!")

main' = do
  name <- readLn
  putStrLn $ "hello " ++ name
