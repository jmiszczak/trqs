###############################################################################
# GNU Makefile for TRQS Mathematica package
# (c) 2011 Jarek Miszczak
###############################################################################
SRCS = quantis_random_integer.tm quantis_random_integer_0.tm quantis_random_integer_1.tm \
	quantis_random_double.tm quantis_random_double_0.tm quantis_random_double_1.tm \
	quantis_get_lib_version.tm quantis_get_serial_number.tm quantis_get_device_id.tm quantis_get_device_type.tm

################################################################################
BINS = $(SRCS:%.tm=%)
TRQSV = 0.1.1
###############################################################################

###############################################################################
# update these to reflect your configuration
###############################################################################
QUANTIS_HOME = /usr/local/IDQ/Quantis
QUANTIS_LIB = $(QUANTIS_HOME)/lib
QUANTIS_INC = $(QUANTIS_HOME)/include
BACKEND_DIR = TRQS_Quantis
###############################################################################

CCFLAGS = -lQuantis
MCCFLAGS = $(CCFLAGS)

CC = gcc

.PHONY: clean

all: $(BINS)
	
% : %.tm
	mcc $^ -o $@ -I$(QUANTIS_INC) -L$(QUANTIS_LIB) $(MCCFLAGS) 

clean:
	rm -rf $(BINS)
	rm -rf *.tm.c *.tm.o
	rm -rf quantis_test

quantis_test:
	$(CC) $(@:%=%.c) -o $@ -I$(QUANTIS_INC) -L$(QUANTIS_LIB) $(CCFLAGS)

src-dist:
	tar czf TRQS-$(TRQSV).tgz $(SRCS) Makefile Makefile.NoHw TRQS.h TRQS.m TRQSTest.nb README quantis_installation.pdf

bin-dist: $(BINS)
	mkdir -p $(BACKEND_DIR)
	mv $(BINS) $(BACKEND_DIR)
	tar czf TRQS-$(TRQSV)-`uname -m`.tgz $(addprefix $(BACKEND_DIR)/, $(BINS)) TRQS.m TRQSTest.nb README quantis_installation.pdf
	rm -Rf $(BACKEND_DIR)

dist: src-dist bin-dist
	
