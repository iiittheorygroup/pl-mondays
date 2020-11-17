// @author Anurudh Peduri
#include <bits/stdc++.h>

template <typename T>
using IO<T> = function<T()>;

IO<char> GetChar = [=]() { return cin.get(); };
IO<void> PutChar(function<char()> fn) {
  return [=]() { putc(fn()); };
}

// fmap :: (a -> b) -> F a -> F b
function<char()> ToUpper(function<char()> gc) {
  return [=]() { return toupper(gc()); };
}

int main() {
  char c = cin.get();
  char C = toupper(c);
  putc(C);

  // ToUpper === fmap(toupper)
  auto Main = PutChar(ToUpper(GetChar));

  return 0;
}
