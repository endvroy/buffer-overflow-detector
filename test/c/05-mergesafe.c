
int
main(int argc, char **argv) {
  unsigned buffer[4] = { 0, 0, 0, 0 };
  unsigned index;
  if (argc) {
    index = 0;
  } else {
    index = 3;
  }
  return buffer[index];
}

