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
    QuantisReadScaledDouble(QUANTIS_DEVICE_TYPE, QUANTIS_DEVICE_ID, &d, 0, 1);
    return d;    
}

int main(int argc, char* argv[]) {
	return MLMain(argc, argv);
}
