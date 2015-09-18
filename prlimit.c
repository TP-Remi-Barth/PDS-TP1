#include <limits.h>
#include <unistd.h>
#include <stdio.h>

void prlimit(void){

  printf("Longueur maximale d’un nom d’entrée dans le système de fichiers(NAME_MAX) : %d\n\
Longueur maximale d’un chemin dans le système de fichiers (PATH_MAX) : %d\n", NAME_MAX, PATH_MAX);

}


int main(int argc, char const *argv[]) {

  prlimit();

  return 0;

}
