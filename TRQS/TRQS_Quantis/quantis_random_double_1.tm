:Begin:
:Function:	quantis_random_double_1
:Pattern:	TrueRandomReal[y_]
:Arguments:	{ y }
:ArgumentTypes:	{ Double }
:ReturnType:	Double
:End:

#include "Quantis.h"
#include "TRQS.h"

double quantis_random_double_1(double y) {
    double d;

	QuantisDeviceType device_type;
	int device_id;
	int quantis_status;

	// prepare and check the device
	QUANTIS_PREPARE(device_type,device_id,quantis_status);

	if (quantis_status > 0) {
	    QuantisReadScaledDouble(device_type, device_id, &d, 0, y);
	}

    return d;    
}

int main(int argc, char* argv[]) {
	return MLMain(argc, argv);
}
