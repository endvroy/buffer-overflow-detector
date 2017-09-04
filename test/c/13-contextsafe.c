
int
returnZero() {
  return 0;
}

int
returnFive() {
  return 5;
}

int
nested(int lower, int upper) {
  unsigned buffer[4] = { 0, 0, 0, 0 };
  return buffer[lower + upper];
}

int
wrapper(int lower, int upper) {
  return nested(lower, upper);
}

int
main(int argc, char** argv) {
  int index;
  return wrapper(1,2) + wrapper(0,3);
}

