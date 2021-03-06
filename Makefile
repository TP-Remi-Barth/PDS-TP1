### Modèle pour vos Makefile

# Name of the archive without extension
RENDU_NAME = tp1-bocquet-delemotte
RENDU_FILE = rendu/${RENDU_NAME}.tar.gz

## Compilateur C et éditeur de liens
CC      = gcc

## Options pour la compilation du C
CFLAGS  = -Wall -Werror -ansi -pedantic
#  Spécifie la version de la norme POSIX à respecter
CFLAGS += -D_XOPEN_SOURCE=500
#  Active les informations de débogage
CFLAGS += -g

## Options de l’édition de liens
LDFLAGS  = -g

# RM command
RM = rm -vf


## Première cible
#  « make » sans argument construit sa première cible
#  Indiquez en dépendance le ou les binaires à construire
all: prlimit maccess maccess+


## Compilation séparée
#  Le .o doit être recompilé dès que le .c ou le .h (s'il existe) change
%.o: %.c %.h
	${CC} ${CFLAGS} -c $<

## Édition de liens
#  Définissez une règle par binaire que vous voulez créer
#  La commande devrait en général être identique pour chaque binaire
prlimit: prlimit.o
	${CC} ${LDFLAGS} -o $@ $^

maccess: maccess.o
	${CC} ${LDFLAGS} -o $@ $^

maccess+: maccess+.o
	${CC} ${LDFLAGS} -o $@ $^


clean:
	${RM} *.o

realclean: clean
	${RM} prlimit maccess maccess+

test: maccess+ test.sh
	./test.sh

rendu: realclean ${RENDU_FILE}

${RENDU_FILE}: Makefile Readme prlimit.c maccess.c maccess+.c test.sh
	tar -czf ${RENDU_FILE} . --exclude='*.git*' --exclude='rendu'


## Liste des pseudo-cibles
#  Ces cibles ne correspondent pas à des fichiers que l'on veut créer,
#  juste à des séquences que l'on veut pouvoir déclencher
.PHONY: all clean realclean rendu
