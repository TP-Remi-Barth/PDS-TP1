#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>

static void usage_then_die(const char *progname){
  fprintf(stderr, "Usage: %s [-r|-w|-x] [-v] file\n", progname);
  exit(EXIT_FAILURE);
}

static void parse_arguments(int ac, char **av,
  char **file, int *mode, int *verbose){

    /* current index within argv, and within the current string */
    int ind, nestind;

    if (ac < 2){
      usage_then_die(av[0]);
    }

    for (ind = 1; ind < ac; ind += 1){
      if (av[ind][0] == '-'){
        for (nestind = 1; av[ind][nestind]; nestind += 1){
          switch (av[ind][nestind]){
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
              fprintf(stderr, "%s: unknown option '%c'\n", av[0], av[1][1]);
              usage_then_die(av[0]);
          }
        }
      }
      else if (*file == NULL){
        *file = av[ind];
      }
      else {
        /* there is more than one file on the command line */
        usage_then_die(av[0]);
      }
    }
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
