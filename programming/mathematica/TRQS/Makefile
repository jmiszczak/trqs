###############################################################################
# GNU Makefile for TRQS Mathematica package
# (c) 2011-2012 Jarek Miszczak
###############################################################################

###############################################################################
# libQRNG configuration (alter accorind to your setup)
###############################################################################
export QRNG_HOME = /usr/local/PicoQuant/QRNG
export QRNG_LIB = -lQRNG
export QRNG_LIBDIR = $(QRNG_HOME)/lib
export QRNG_INCDIR = $(QRNG_HOME)/include

###############################################################################
# libQuantis configuration (alter accorind to your setup)
###############################################################################
export QUANTIS_HOME = /usr/local/IDQ/Quantis
export QUANTIS_LIB = -lQuantis
export QUANTIS_LIBDIR = $(QUANTIS_HOME)/lib
export QUANTIS_INCDIR = $(QUANTIS_HOME)/include

###############################################################################
# general configuration options
###############################################################################
export TRQSV = 0.2.1

###############################################################################
# MathLink variables used during the compilation
###############################################################################
export ML_HOME := $(lastword  $(shell mcc --internals | grep 'MLDK Directory'))
export ML_INCDIR = $(ML_HOME)
export ML_LIBDIR = $(ML_HOME)
export MPREP = $(ML_HOME)/mprep

################################################################################
# choose the right MathLink library for your architecture
################################################################################
ARCH := $(shell uname -m)
ifeq ($(ARCH),x86_64)
  ML_LIB = -lML64i3
else
  ML_LIB = -lML32i3 
endif

export ML_LIBS = $(ML_LIB) -lm -lpthread -lstdc++ -lrt 

################################################################################
# available backends are in separate dirs
################################################################################
QUANTIS_BACKEND_DIR = TRQS_Quantis
QRNG_BACKEND_DIR = TRQS_QRNG
BACKEND_DIRS = $(QUANTIS_BACKEND_DIR) $(LIBQRNG_BACKEND_DIR)

################################################################################
# disable automatic rules for *.o files
################################################################################
.SUFFIXES:

################################################################################
# some helper targets
################################################################################
.PHONY: help clean

################################################################################
# global target defintions
################################################################################
default: help

help:
	@echo --------------------------------------------------------------------------------
	@echo Hello, this is the main Makefile for the TRQS package version $(TRQSV). Please
	@echo choose one of the targets suitable for your configuration. Note that some of the 
	@echo configuration oprtions are set in TRQS.h file. You may also need to change some 
	@echo variables in makefiles in the 
	@echo  \ $(BACKEND_DIRS) 
	@echo directories to reflect your configuration
	@echo
	@echo Availabale targets:
	@echo \ src-dist - build .tgz archive with all source files
	@echo \ quantis-bin-dist - build binary distributions based on libQuantis by IDQ
	@echo \ quantis-nohw-bin-dist - same as above by based on libQuantis-NoHw
	@echo \ qrng-bin-dist - build binary distribution based on libQRNG by PicoQuant
	@echo \ all - build all above targets
	@echo \ clean - clean the working directory
	@echo
	@echo You can find more information at http://www.iitis.pl/~miszczak/trqs
	@echo --------------------------------------------------------------------------------

src-dist:
	tar czf TRQS-$(TRQSV).tgz *.tm *.mk TRQS.h TRQS.m.tpl TRQSTest.nb README *.pdf

clean: 
	$(MAKE) -C $(QUANTIS_BACKEND_DIR) quantis-clean 
	$(MAKE) -C $(QRNG_BACKEND_DIR) qrng-clean
	

################################################################################
# backend target defintions
################################################################################

all: quantis-bin-dist quantis-nohw-bin-dist qrng-bin-dist

quantis-bin-dist:
	$(MAKE) -C $(QUANTIS_BACKEND_DIR) $@

quantis-nohw-bin-dist:
	$(MAKE) -C $(QUANTIS_BACKEND_DIR) $@

quantis-all:
	$(MAKE) -C $(QUANTIS_BACKEND_DIR) $@

qrng-bin-dist:
	$(MAKE) -C $(QRNG_BACKEND_DIR) $@

qrng-all:
	$(MAKE) -C $(QRNG_BACKEND_DIR) $@
