###############################################################################
# libQRNG specific part
# Note: You must update some of these to reflect your configuration!
###############################################################################

###############################################################################
# libQRNG configuration
###############################################################################
LIBQRNG_HOME = /usr/local/PicoQuant/QRNG
LIBQRNG_LIBDIR = $(LIBQRNG_HOME)/lib
LIBQRNG_INCDIR = $(LIBQRNG_HOME)/include
LIBQRNG_LIB = -lQRNG

###############################################################################
# *.tm files for TRQS_libQRNG backend
###############################################################################
LIBQRNG_SRC := $(wildcard libqrng_*.tm)
LIBQRNG_BIN = $(LIBQRNG_SRC:%.tm=%)
###############################################################################

###############################################################################
# redefine variables used in the main Makefile
BACKEND_LIB = $(LIBQRNG_LIB)
BACKEND_LIBDIR = $(LIBQRNG_LIBDIR)
BACKEND_INCDIR = $(LIBQRNG_INCDIR)
BACKEND_DIR = TRQS_libQRNG

quantis-all: $(LIBQRNG_BIN) libqrng_test

quantis_test:
	$(CC) $(@:%=%.c) -o $@ -I$(QUANTIS_INCDIR) -L$(QUANTIS_LIBDIR) $(QUANTIS_LIB) $(CCFLAGS)

quantis-bin-dist: $(QUANTIS_BIN)
	mkdir -p $(BACKEND_DIR)
	mv $(QUANTIS_BIN) $(BACKEND_DIR)
	cat TRQS.m.tpl | sed s/TRQS_BACKEND/$(BACKEND_DIR)/g > TRQS.m
	tar czf TRQS-$(TRQSV)-`uname -m`-Quantis.tgz $(addprefix $(BACKEND_DIR)/, $(QUANTIS_BIN)) TRQS.m TRQSTest.nb README quantis_installation.pdf
	rm -Rf $(BACKEND_DIR)

