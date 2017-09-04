

int
foo(int c, int a, int b) {
  if (c) {
    a *= -2;
    b += 2;
  } else {
    a *= 3;
    b -= 1;
  }
  return 10 + a + b; 
}


int
main(int argc, char **argv) {
  unsigned buffer[20] = {
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  };
  int x = 1;
  int y = 2;
  x = foo(argc, x, y); 
  return buffer[x];
}

