#include <stdio.h>
#include <time.h>
#include <string.h>
#define N 5000000

extern void detect_fizz_buzz(unsigned int v);

void fizzbuzz(unsigned int v)
{
  for (unsigned int i = 1; i <= v; i++)
  {
    if ((i % 3) && (i % 5)) {
      printf("%d\n", i);
      continue;
    }

    if (!(i % 3))
      printf("Fizz");
    if (!(i % 5))
      printf("Buzz");

    printf("\n");
  }
}

int main(int argc, char *argv[]) {
  if (argc >= 2 && !strcmp("asm", argv[1])) {
    detect_fizz_buzz(N);
  } else {
    fizzbuzz(N);
  }
  return 0;
}
