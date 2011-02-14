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
    QuantisReadScaledDouble(QUANTIS_DEVICE_TYPE, QUANTIS_DEVICE_ID, &d, 0, y);
    return d;    
}

int main(int argc, char* argv[]) {
	return MLMain(argc, argv);
}
