###############################################################################
# include targets and definitions commong for all backends
###############################################################################
include common.mk

###############################################################################
# libQRNG specific part
# Note: You must update some of these to reflect your configuration!
###############################################################################

###############################################################################
# libQRNG configuration
###############################################################################
BACKEND_HOME = /usr/local/PicoQuant/QRNG
BACKEND_LIBDIR = $(BACKEND_HOME)/lib
BACKEND_INCDIR = $(BACKEND_HOME)/include
BACKEND_LIB = -lQRNG

###############################################################################
# *.tm files for TRQS_libQRNG backend
###############################################################################
BACKEND_SRC := $(wildcard libqrng_*.tm)
BACKEND_BIN = $(BACKEND_SRC:%.tm=%)
###############################################################################

###############################################################################
# directory used to store compiled files
###############################################################################
BACKEND_DIR = TRQS_libQRNG

libqrng-all: $(BACKEND_BIN) libqrng_test

libqrng_test:
	$(CC) $(@:%=%.c) -o $@ -I$(BACKEND_INCDIR) -L$(BACKEND_LIBDIR) $(BACKEND_LIB) $(CCFLAGS)

libqrng-bin-dist: $(BACKEND_BIN)
	mkdir -p $(BACKEND_DIR)
	mv $(BACKEND_BIN) $(BACKEND_DIR)
	cat TRQS.m.tpl | sed s/TRQS_BACKEND/$(BACKEND_DIR)/g > TRQS.m
	tar czf TRQS-$(TRQSV)-`uname -m`-libQRNG.tgz $(addprefix $(BACKEND_DIR)/, $(BACKEND_BIN)) TRQS.m TRQSTest.nb README libqrng_api_intro.pdf
	rm -Rf $(BACKEND_DIR)

% : %.tm
	$(MPREP) $^ -o $^.c
	$(CC) -I$(ML_INCDIR) -L$(ML_LIBDIR) -I$(BACKEND_INCDIR) -L$(BACKEND_LIBDIR) $(ML_LIBS) $(BACKEND_LIB) -c -o $^.o $^.c
	$(CXX) -I$(ML_INCDIR) -L$(ML_LIBDIR) -I$(BACKEND_INCDIR) -L$(BACKEND_LIBDIR) $^.o $(ML_LIBS) $(BACKEND_LIB) -o $@ 
