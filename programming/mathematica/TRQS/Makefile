###############################################################################
# GNU Makefile for TRQS Mathematica package
# (c) 2011-2012 Jarek Miszczak
###############################################################################

# disable automatic rules for *.o files
.SUFFIXES:

###############################################################################
# general configuration options
###############################################################################
TRQSV = 0.2.0

###############################################################################
# MathLink variables used during the compilation
###############################################################################
ML_HOME = $(lastword  $(shell mcc --internals | grep 'MLDK Directory'))
ML_INCDIR = $(ML_HOME)
ML_LIBDIR = $(ML_HOME)
MPREP = $(ML_HOME)/mprep

################################################################################
# choose the right MathLink library for your architecture
################################################################################
ARCH = $(shell uname -m)
ifeq ($(ARCH),i686) 
  ML_LIB = -lML32i3 
endif

ifeq ($(ARCH),x86_64)
  ML_LIB = -lML64i3
endif

ML_LIBS = $(ML_LIB) -lm -lpthread -lstdc++ -lrt 

.PHONY: help clean

default: help

################################################################################
# external makefiles for supported backends 
include quantis.mk 
#include quantis-nohw.mk 
#include libqrng.mk 

help:
	@echo --------------------------------------------------------------------------------
	@echo Hello, this is the main Makefile for the TRQS package version $(TRQSV). Please
	@echo choose one of the targets suitable for your configuration. Note that some of the 
	@echo configuration oprtions are set in TRQS.h file. You will also need to change some 
	@echo variables in following makefiles:
	@echo \ $(wildcard *.mk)  
	@echo to reflect you configuration.
	@echo Availabale targets:
	@echo \ src-dist - build .tgz archive with all source files
	@echo \ quantis-bin-dist - build binary distributions based on libQuantis by IDQ
	@echo \ quantis-nohw-bin-dist - same as above by based on libQuantis-NoHw
	@echo \ libqrng-bin-dist - build binary distribution based on libQRNG by PicoQuant
	@echo \ all - build all above targets
	@echo \ clean - clean the working directory
	@echo --------------------------------------------------------------------------------

% : %.tm
	$(MPREP) $^ -o $^.c
	$(CC) -I$(ML_INCDIR) -L$(ML_LIBDIR) -I$(BACKEND_INCDIR) -L$(BACKEND_LIBDIR) $(ML_LIBS) $(BACKEND_LIB) -c -o $^.o $^.c
	$(CXX) -I$(ML_INCDIR) -L$(ML_LIBDIR) -I$(BACKEND_INCDIR) -L$(BACKEND_LIBDIR) $^.o $(ML_LIBS) $(BACKEND_LIB) -o $@ 

src-dist:
	tar czf TRQS-$(TRQSV).tgz *.tm Makefile *.mk TRQS.h TRQS.m.tpl TRQSTest.nb README quantis_installation.pdf

clean:
	rm -rf *.tm.c *.tm.o
	rm -rf quantis_test
	rm -rf libqrng_test
