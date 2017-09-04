
int
main(int argc, char **argv) {
  unsigned buffer[20] = {
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  };
  int x = 1;
  int y = 2;
  if (argc) {
    x *= -2;
    y += 2;
  } else {
    x *= 3;
    y -= 1;
  }
  x = 10 + x + y; 
  return buffer[x];
}

