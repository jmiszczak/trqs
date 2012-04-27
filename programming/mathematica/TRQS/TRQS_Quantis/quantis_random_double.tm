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
    QuantisReadScaledDouble(QUANTIS_DEVICE_TYPE, QUANTIS_DEVICE_ID, &d, x, y);
    return d;    
}

int main(int argc, char* argv[]) {
	return MLMain(argc, argv);
}
