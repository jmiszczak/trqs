:Begin:
:Function:	quantis_get_serial_number
:Pattern:	QuantisGetSerialNumber[]
:Arguments:	{ }
:ArgumentTypes:	{ }
:ReturnType:	String
:End:

#include "Quantis.h"
#include "TRQS.h"

char* quantis_get_serial_number(void) {
    return QuantisGetSerialNumber(QUANTIS_DEVICE_TYPE, QUANTIS_DEVICE_ID);
}

int main(int argc, char* argv[]) {
	return MLMain(argc, argv);
}
