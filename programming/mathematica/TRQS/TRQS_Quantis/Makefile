###############################################################################
# Quantis specific part
# Note: You must update some of these to reflect your configuration!
###############################################################################

###############################################################################
# libQuantis configuration
###############################################################################
QUANTIS_HOME = /usr/local/IDQ/Quantis
QUANTIS_LIBDIR = $(QUANTIS_HOME)/lib
QUANTIS_INCDIR = $(QUANTIS_HOME)/include
QUANTIS_LIB = -lQuantis

###############################################################################
# *.tm files for TRQS_Quantis backend
###############################################################################
QUANTIS_SRC := $(wildcard quantis_*.tm)
QUANTIS_BIN = $(QUANTIS_SRC:%.tm=%)
###############################################################################

###############################################################################
# redefine variables used in the main Makefile
BACKEND_LIB = $(QUANTIS_LIB)
BACKEND_LIBDIR = $(QUANTIS_LIBDIR)
BACKEND_INCDIR = $(QUANTIS_INCDIR)
BACKEND_DIR = TRQS_Quantis

quantis-all: $(QUANTIS_BIN) quantis_test

quantis_test:
	$(CC) $(@:%=%.c) -o $@ -I$(QUANTIS_INCDIR) -L$(QUANTIS_LIBDIR) $(QUANTIS_LIB) $(CCFLAGS)

quantis-bin-dist: $(QUANTIS_BIN)
	mkdir -p $(BACKEND_DIR)
	mv $(QUANTIS_BIN) $(BACKEND_DIR)
	cat TRQS.m.tpl | sed s/TRQS_BACKEND/$(BACKEND_DIR)/g > TRQS.m
	tar czf TRQS-$(TRQSV)-`uname -m`-Quantis.tgz $(addprefix $(BACKEND_DIR)/, $(QUANTIS_BIN)) TRQS.m TRQSTest.nb README quantis_installation.pdf
	rm -Rf $(BACKEND_DIR)

