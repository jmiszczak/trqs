:Begin:
:Function:	quantis_random_double_0
:Pattern:	TrueRandomReal[]
:Arguments:	{ }
:ArgumentTypes:	{ }
:ReturnType:	Double
:End:

#include "Quantis.h"
#include "TRQS.h"

double quantis_random_double_0(void) {
    double d;

	QuantisDeviceType device_type;
	int device_id;
	int quantis_status;

	// prepare and check the device
	QUANTIS_PREPARE(device_type,device_id,quantis_status);

    QuantisReadScaledDouble(device_type, device_id, &d, 0, 1);
    return d;    
}

int main(int argc, char* argv[]) {
	return MLMain(argc, argv);
}
