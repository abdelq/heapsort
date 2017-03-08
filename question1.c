#include <stdlib.h>
#include <stdio.h>

void initialiser () {
  int n;
  int *arr;

  scanf("%d", &n);

  arr = (int *)malloc(sizeof(int) * n);

  for (int i = 0; i < n; i++) {
    scanf("%d", &arr[i]);
  }

  /*
  for (int i = 0; i < n; i++) {
    printf("\narr[%d] = %d", i, arr[i]);
  }
  */

  // free(arr);
}

int main () {
  initialiser();
}
