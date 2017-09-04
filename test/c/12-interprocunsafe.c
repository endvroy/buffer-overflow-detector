
int
returnZero() {
  return 0;
}

int
returnFive() {
  return 5;
}

int
nested(int index) {
  unsigned buffer[4] = { 0, 0, 0, 0 };
  return buffer[index];
}

int
wrapper(int index) {
  return nested(index);
}

int
main(int argc, char** argv) {
  int index;
  if (argc) {
    index = returnZero();
  } else {
    index = returnFive();
  }
  return wrapper(index);
}

