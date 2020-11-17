// @author Anurudh Peduri
// IO Monad
#include <functional>
#include <iostream>
using std::function;

// the empty tuple/unit type
// type () = ()
struct Unit {
} unit;

// type IO a
template <typename A>
struct IO {
  const function<A()> run;
  explicit IO(function<A()> f) : run(f) {}

  // instance Monad IO where
  // bind :: IO a -> (a -> IO b) -> IO a
  template <typename B>
  IO<B> bind(function<IO<B>(A)> fn) const {
    auto r = this->run;
    return IO<B>([r, fn]() { return fn(r())(); });
  }

  // run the monad
  A operator()() const { return run(); }
};

// (>>=) : IO a -> (a -> IO b) -> IO b
template <typename A, typename B>
IO<B> operator>>=(IO<A> io, function<IO<B>(A)> fn) {
  return io.bind(fn);
}

// (>>) :: IO a -> IO b -> IO b
template <typename A, typename B>
IO<B> operator>>(IO<A> io_a, IO<B> io_b) {
  return io_a.template bind<B>([=](A a) { return io_b; });
}

// instance Functor IO where
// fmap :: (a -> b) -> IO a -> IO b
template <typename A, typename B>
IO<B> fmap(function<B(A)> fn, IO<A> io_a) {
  return IO<B>([=]() { return fn(io_a()); });
}

// instance Monad IO where
// pure :: a -> IO a
template <typename A>
IO<A> pure(A val) {
  return IO<A>([&]() { return val; });
}

// some Haskell Types
using Char = char;
using String = std::string;

// putChar :: Char -> IO ()
const function<IO<Unit>(Char)> putChar =
    [](char c) {
      return IO<Unit>([=]() {
        std::cout << c;
        return unit;
      });
    };

// getChar :: IO Char
const IO<char>
    getChar = IO<char>([]() { return std::cin.get(); });

// putStr :: String -> IO ()
const function<IO<Unit>(String)> putStr =
    [](String s) {
      return IO<Unit>([=]() {
        std::cout << s;
        return unit;
      });
    };

// putStrLn :: String -> IO ()
const function<IO<Unit>(String)> putStrLn = [](String s) {
  return putStr(s) >> putStr("\n");
};

// getLine :: IO String
const IO<String> getLine = IO<String>([]() {
  String s;
  std::getline(std::cin, s);
  return s;
});

/* Some notes:
 * 1. All captures are by value, as the actual objects are local.
 */
