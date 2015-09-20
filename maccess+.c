#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>

static void usage_then_die(const char *progname){
  fprintf(stderr, "Usage: %s [-r] [-w] [-x] [-v] file\n", progname);
  exit(EXIT_FAILURE);
}

static void parse_arguments(int ac, char **av,
  char **file, int *mode, int *verbose){

  int opt;

  while ((opt = getopt(ac, av, "rwxv")) != -1){
    switch (opt){
      case 'r':
        *mode |= R_OK;
        break;
      case 'w':
        *mode |= W_OK;
        break;
      case 'x':
        *mode |= X_OK;
        break;
      case 'v':
        *verbose = 1;
        break;
      default:
        usage_then_die(av[0]);
    }
  }

  if (optind >= ac){
    usage_then_die(av[0]);
  }

  *file = av[optind];
}

int main(int ac, char **av){

  int mode = 0;
  int verbose = 0;
  char *file = NULL;
  int ret;

  parse_arguments(ac, av, &file, &mode, &verbose);

  if (mode == 0){
    mode = F_OK;
  }

  if ((ret = access(file, mode)) != 0){
    if (verbose == 1){
      perror(file);
    }
    exit(EXIT_FAILURE);
  }

  return EXIT_SUCCESS;
}
