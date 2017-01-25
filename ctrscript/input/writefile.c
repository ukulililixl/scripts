#include <stdio.h>
#include <stdlib.h>
#include <string.h>


int stoi(char *size, int len) {
  int value = 0;
  int i;
  for(i = 0; i < len; i++) {
    value = value * 10 + size[i] - 48;
  }
  return value;
}

int main(int argc, char** argv) {
  // file

  char *size;
  size = argv[1];

  printf("size = %s MB\n", size);

  int len = strlen(size);
  printf("len = %d\n", len);

  long MBSize = stoi(size, len);

  long bytes = MBSize * 1024 * 1024;
  long IntNum = bytes/4;
  long oneMBbytes = 1024 * 1024;
  long oneMBIntNum = oneMBbytes/4;

  FILE *p;
  p = fopen(argv[2], "wb");

  //random
  time_t t;
  srand((unsigned) time(&t));

  long i;
  for(i = 0; i < IntNum; i++) {
    int temp=0;
    if(i < oneMBIntNum) {
      temp = rand();
    }
    fwrite(&temp, sizeof(int), 1, p);
  }

  fclose(p);

  return 0;
}

