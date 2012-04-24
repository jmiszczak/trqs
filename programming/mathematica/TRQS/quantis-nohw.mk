###############################################################################
# redefine variables used in the main Makefile and quantis.mk
BACKEND_LIB = $(QUANTIS_LIB)-NoHw

quantis-nohw-all: $(QUANTIS_BIN) quantis_test

quantis_test:
	$(CC) $(@:%=%.c) -o $@ -I$(BACKEND_INCDIR) -L$(BACKEND_LIBDIR) $(BACKEND_LIB) $(CCFLAGS)

quantis-nohw-bin-dist: $(QUANTIS_BIN)
	mkdir -p $(BACKEND_DIR)
	mv $(QUANTIS_BIN) $(BACKEND_DIR)
	cat TRQS.m.tpl | sed s/TRQS_BACKEND/$(BACKEND_DIR)/g > TRQS.m
	tar czf TRQS-$(TRQSV)-`uname -m`-Quantis-NoHW.tgz $(addprefix $(BACKEND_DIR)/, $(QUANTIS_BIN)) TRQS.m TRQSTest.nb README quantis_installation.pdf
	rm -Rf $(BACKEND_DIR)

