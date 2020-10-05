#include <stdio.h>

extern void detect_fizz_buzz(int v);

int main() {
  printf("This is being called from C\n");
  detect_fizz_buzz(9);
  return 0;
}
