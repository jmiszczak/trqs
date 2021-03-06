#include <stdlib.h>
#include "mathlink.h"

// macros used for building test programs using libQuantis library
#define QUANTIS_DEVICE_TYPE QUANTIS_DEVICE_USB
#define QUANTIS_DEVICE_ID 0


// macros for using configuration options set by Mathematica functions

// read type and id of the used device
#define QUANTIS_PREPARE(device_type,device_id,quantis_status) { \
	const char* device_type_var; \
  	const char* device_id_var; \
  	MLPutFunction(stdlink, "EvaluatePacket", 1); \
  	MLPutSymbol(stdlink, "TRQS`Private`QuantisDeviceType"); \
  	MLEndPacket(stdlink); \
  	while (MLNextPacket(stdlink) != RETURNPKT) { \
	  MLNewPacket(stdlink); \
	} \
  	MLGetString(stdlink, &device_type_var); \
  	MLPutFunction(stdlink, "EvaluatePacket", 1); \
  	MLPutSymbol(stdlink, "TRQS`Private`QuantisDeviceId"); \
  	MLEndPacket(stdlink); \
  	while (MLNextPacket(stdlink) != RETURNPKT) { \
	  MLNewPacket(stdlink); \
	} \
  	MLGetString(stdlink, &device_id_var); \
  	if ( strcmp(device_type_var, "PCI") == 0 ) { \
	  device_type = QUANTIS_DEVICE_PCI; \
	} else if ( strcmp(device_type_var, "USB") == 0 ) { \
	  device_type = QUANTIS_DEVICE_USB; \
	} \
  	device_id = atoi(device_id_var); \
  	quantis_status = QuantisGetModulesStatus(device_type, device_id); \
}

// read user name and password used for downloading data from qrng service
#define QRNG_PREPARE(qrng_status) { \
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

