// macros for using with Quantis (libQuantis) backend
#define QUANTIS_DEVICE_TYPE QUANTIS_DEVICE_USB
#define QUANTIS_DEVICE_ID 0

#include "mathlink.h"

#define QRNG_ESTABLISH_CONNECTION(qrng_status) { \
	const char* user; \
	const char* pass; \
	MLPutFunction(stdlink, "EvaluatePacket", 1); \
    MLPutSymbol(stdlink, "TRQS`Private`QRNGUsername"); \
    MLEndPacket(stdlink); \
    while (MLNextPacket(stdlink) != RETURNPKT) { \
        MLNewPacket(stdlink); \
	} \
    MLGetString(stdlink, &user); \
	MLPutFunction(stdlink, "EvaluatePacket", 1); \
    MLPutSymbol(stdlink, "TRQS`Private`QRNGPassword"); \
    MLEndPacket(stdlink); \
    while (MLNextPacket(stdlink) != RETURNPKT) { \
        MLNewPacket(stdlink); \
	} \
    MLGetString(stdlink, &pass); \
  	qrng_status = qrng_connect(user, pass); \
}

