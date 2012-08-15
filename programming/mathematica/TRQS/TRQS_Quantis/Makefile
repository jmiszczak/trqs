###############################################################################
# GNU Makefile for TRQS Mathematica package
# (c) 2011-2012 Jarek Miszczak
# WWW: http://www.iitis.pl/~miszczak/trqs
###############################################################################

###############################################################################
# This Makefile is used for building Quantis backend for the TRQS package, but 
# the configuration options for this backend must be set in the main Makefile
###############################################################################

# disable automatic rules for *.o files
.SUFFIXES:

###############################################################################
# libQuantis backend configuration is included in the main Makefile
###############################################################################
BACKEND_NAME = Quantis
BACKEND_HOME = $(QUANTIS_HOME)
BACKEND_LIB = $(QUANTIS_LIB)
BACKEND_LIBDIR = $(QUANTIS_LIBDIR)
BACKEND_INCDIR = $(QUANTIS_INCDIR)
BACKEND_DIR = TRQS_$(BACKEND_NAME)

###############################################################################
# *.tm files for TRQS_Quantis backend
###############################################################################
BACKEND_SRC := $(wildcard quantis_*.tm)
BACKEND_BIN = $(BACKEND_SRC:%.tm=%)
###############################################################################

default:
	@echo '==>' Please use the main Makefile located in the parent directory

quantis_test:
	@echo '==>' Building file \'$@\'
	$(CC) -pthread quantis_test.c -o $@ -I$(BACKEND_INCDIR) -I.. -I$(ML_INCDIR) -L$(BACKEND_LIBDIR) $(BACKEND_LIB)

quantis-bin-dist: quantis_test $(BACKEND_BIN)
	@echo '==>' Building binary distribution for $(BACKEND_DIR) '('linked against $(BACKEND_LIB)')'
	mkdir -p $(BACKEND_DIR)
	cp $(BACKEND_BIN) $(BACKEND_DIR)
	cat ../TRQS.m.tpl | sed s/TRQS_BACKEND_NAME/$(BACKEND_NAME)/g > ../TRQS.m
	tar czvf ../TRQS-$(TRQSV)-$(ARCH)-Quantis$(VARIANT).tgz \
        $(addprefix $(BACKEND_DIR)/, $(BACKEND_BIN)) quantis_test \
		../TRQS.m ../TRQSTest_Quantis.nb \
		../README quantis_installation.pdf
	rm -Rf $(BACKEND_DIR)

quantis-nohw_test:
	$(MAKE) quantis_test VARIANT=-NoHw BACKEND_LIB=$(BACKEND_LIB)$(VARIANT)

quantis-nohw-bin-dist:
	$(MAKE) quantis-bin-dist VARIANT=-NoHw BACKEND_LIB=$(BACKEND_LIB)$(VARIANT)

% : %.tm
	@echo '==>' Building file \'$@\'
	$(MPREP) $^ -o $^.c
	$(CC) -I$(ML_INCDIR) -I$(BACKEND_INCDIR) -I.. $(ML_LIBS) $(BACKEND_LIB) -c -o $^.o $^.c
	$(CXX) -L$(ML_LIBDIR) -I$(BACKEND_INCDIR) -L$(BACKEND_LIBDIR) $^.o $(ML_LIBS) $(BACKEND_LIB) -o $@ 

quantis-clean:
	rm -rf $(BACKEND_BIN)
	rm -rf *.tm.c *.tm.o
	rm -rf quantis_test

