
int
main(int argc, char **argv) {
  unsigned buffer[4] = { 0, 0, 0, 0 };
  int index;
  if (argc) {
    index = 0;
  } else {
    index = -1;
  }
  return buffer[index];
}

