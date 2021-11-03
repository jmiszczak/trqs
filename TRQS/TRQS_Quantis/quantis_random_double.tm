:Begin:
:Function:	quantis_random_double
:Pattern:	TrueRandomReal[{x_, y_}]
:Arguments:	{ x, y }
:ArgumentTypes:	{ Double, Double }
:ReturnType:	Double
:End:

#include "Quantis.h"
#include "TRQS.h"

double quantis_random_double(double x, double y) {
    double d;

	QuantisDeviceType device_type;
	int device_id;
	int quantis_status;

	QUANTIS_PREPARE(device_type,device_id,quantis_status);

	if (quantis_status > 0) {
	    QuantisReadScaledDouble(device_type, device_id, &d, x, y);
	}

    return d;    
}

int main(int argc, char* argv[]) {
	return MLMain(argc, argv);
}
