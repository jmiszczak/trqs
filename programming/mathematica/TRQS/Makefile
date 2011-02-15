SRCS = quantis_random_integer.tm quantis_random_integer_0.tm quantis_random_integer_1.tm \
	quantis_random_double.tm quantis_random_double_0.tm quantis_random_double_1.tm \
	quantis_get_lib_version.tm quantis_get_serial_number.tm quantis_get_device_id.tm quantis_get_device_type.tm

BINS = $(SRCS:%.tm=%)
TRQSV = 0.0.5	

QUANTIS_HOME = /usr/local/IDQ/Quantis
QUANTIS_LIB = $(QUANTIS_HOME)/lib64
QUANTIS_INC = $(QUANTIS_HOME)/include

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

dist:
	tar czvf TRQS-$(TRQSV).tgz $(SRCS) Makefile TRQS.h TRQS.m TRQSTest.nb README
