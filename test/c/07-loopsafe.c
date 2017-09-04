
int
main(int argc, char **argv) {
  unsigned buffer[4] = { 0, 0, 0, 0 };
  unsigned short sum = 0;
  for (unsigned short i = 0; i < 4; ++i) {
    sum += buffer[i];
  }
  return sum;
}

