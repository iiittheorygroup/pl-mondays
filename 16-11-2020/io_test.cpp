#include "io.h"
#include <bits/stdc++.h>
using namespace std;

// toUpper :: Char -> Char
char toUpper(char c) { return toupper(c); }

// toUpperS :: String -> String
function<String(String)> toUpperS = [](String s) {
  for (char &c : s)
    c = toUpper(c);
  return s;
};

void runHaskell() {
  // main :: IO ()
  // main = fmap toUpperS getLine >>= putStrLn
  auto main = fmap(toUpperS, getLine) >>= putStrLn;

  // run it!
  main();
}

int main() {
  runHaskell();
  return 0;
}
