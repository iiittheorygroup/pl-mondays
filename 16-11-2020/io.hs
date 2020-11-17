-- @author Anurudh Peduri
-- Doesn't compile. Just a list of things
-- bind :: Monad m => m a -> (a -> m b) -> m b
-- pure :: Monad m => a -> m a
-- return = pure
-- fmap :: Functor m => (a -> b) -> m a -> m b
-- getChar :: IO Char
-- putChar :: Char -> IO ()
-- bind getChar putChar :: IO ()
-- >>=
-- fmap toUpper getChar >>= putChar :: IO ()

instance Monad Maybe where
  bind (Just x) f = f x
  bind (Nothing) f = Nothing

data Wrapped a
  = Error String
  | Value a

-- bind (pure x) f = f x
instance Monad Wrapped where
  bind (Value a) f = f a
  bind (Error s) f = Error s

a1 >>= (\x1 ->
a2 >>= (\x2 ->
a3
       ))

do
  x1 <- a1
  x2 <- a2
  a3

zs = do
  x <- xs
  y <- ys
  return (x + y)
-- return :: a -> [a]

zs = [ x + y | x <- xs, y <- ys ]

zs =
  xs >>= (\x ->
  ys >>= (\y ->
  return (x + y)
))

-- Parser Variable -- read some sequence
-- Parser Assign -- variable = value;
-- Parser Program

instance Monad List where
  return x = [x]
  bind xs f = concat (map f xs)

[0] >>= (\x -> [x - 1, x + 1] >>= (\y -> [y + 1, y + 2]))

