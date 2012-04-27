:Begin:
:Function:	quantis_get_device_id
:Pattern:	QuantisGetDeviceId[]
:Arguments:	{ }
:ArgumentTypes:	{ }
:ReturnType:	Integer
:End:

#include "Quantis.h"
#include "TRQS.h"

int quantis_get_device_id(void) {
    return QUANTIS_DEVICE_ID;
}

int main(int argc, char* argv[]) {
	return MLMain(argc, argv);
}
