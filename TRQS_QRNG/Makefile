###############################################################################
# GNU Makefile for TRQS Mathematica package
# (c) 2011-2012 Jarek Miszczak
# WWW: http://www.iitis.pl/~miszczak/trqs
###############################################################################

###############################################################################
# This Makefile is used for building QRNG backend for the TRQS package, but the
# configuration options for this backend must be set in the main Makefile
###############################################################################

# disable automatic rules for *.o files
.SUFFIXES:

###############################################################################
# libQRNG backend configuration is included in the main Makefile
###############################################################################
BACKEND_NAME = QRNG
BACKEND_HOME = $(QRNG_HOME)
BACKEND_LIB = $(QRNG_LIB)
BACKEND_LIBDIR = $(QRNG_LIBDIR)
BACKEND_INCDIR = $(QRNG_INCDIR)
BACKEND_DIR = TRQS_$(BACKEND_NAME)

###############################################################################
# *.tm files for TRQS_QRNG backend
###############################################################################
BACKEND_SRC := $(wildcard qrng_*.tm)
BACKEND_BIN = $(BACKEND_SRC:%.tm=%)
###############################################################################

default:
	@echo '==>' Please use the main Makefile located in the parent directory

qrng-all: $(BACKEND_BIN) qrng_test

qrng_test:
	@echo '==>' Building files \'$@\'
	$(CC) $(@:%=%.c) -o $@ -I$(BACKEND_INCDIR) -I.. -I$(ML_INCDIR) -L$(BACKEND_LIBDIR) $(BACKEND_LIB)

qrng-bin-dist: qrng_test $(BACKEND_BIN)
	@echo '==>' Building binary distribution for $(BACKEND_DIR) '('linked against $(BACKEND_LIB)$(VARIANT)')'
	mkdir -p $(BACKEND_DIR)
	cp $(BACKEND_BIN) $(BACKEND_DIR)
	cat ../TRQS.m.tpl | sed s/TRQS_BACKEND_NAME/$(BACKEND_NAME)/g > ../TRQS.m
	tar czf ../TRQS-$(TRQSV)-$(ARCH)-QRNG.tgz \
        $(addprefix $(BACKEND_DIR)/, $(BACKEND_BIN)) qrng_test\
		../TRQS.m ../TRQSTest_QRNG.nb \
        ../README.md libqrng_api_intro.pdf
	rm -Rf $(BACKEND_DIR)

% : %.tm
	@echo '==>' Building file \'$@\'
	$(MPREP) $^ -o $^.c
	$(CC) -I$(ML_INCDIR) -I$(BACKEND_INCDIR) -I.. $(ML_LIBS) $(BACKEND_LIB) -c -o $^.o $^.c
	$(CXX) -L$(ML_LIBDIR) -I$(BACKEND_INCDIR) -L$(BACKEND_LIBDIR) $^.o $(ML_LIBS) $(BACKEND_LIB) -o $@ 

qrng-clean:
	rm -rf $(BACKEND_BIN)
	rm -rf *.tm.c *.tm.o
	rm -rf qrng_test

