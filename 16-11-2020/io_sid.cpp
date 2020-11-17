// @author Siddharth Bhat
#include <bits/stdc++.h>
struct IO {
  virtual void run() = 0;
};
struct Putchar : public IO {
  char c;
  Putchar(char c) : c(c){};
  virtual void run() { std::cout << c; }
};

struct Getchar : public IO {
  // tell me what you want to do, given a character
  // that has been read
  std::function<IO *(char c)> fn;
  Getchar(std::function<IO *(char c)> f) : fn(f) {}
  virtual void run() {
    char c;
    std::cin >> c;
    return fn(c)->run();
  }
};
// tell me what you want to execute!
IO *mainRecipe() {
  return Getchar([](char c) { return Putchar(c); });
}

void interpretIO(IO *io) { io->run(); }

int main() {
    // defunctionalize: functions -> data
    interpretIO(mainRecipe());
}
