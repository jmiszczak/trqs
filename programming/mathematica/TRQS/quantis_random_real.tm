:Begin:
:Function:	quantis_random_real
:Pattern:	QuantisRandomReal[]
:Arguments:	{ }
:ArgumentTypes:	{ }
:ReturnType:	Double
:End:
:Evaluate: QuantisRandomReal::usage = "QuantisRandomReal[] returns a random\
 real number in the range [0,1].";

#include "Quantis.h"

#define QUANTIS_DEVICE_TYPE QUANTIS_DEVICE_USB
#define QUANTIS_DEVICE_ID 0

double quantis_random_real(void) {
    double d;
    QuantisReadScaledDouble(QUANTIS_DEVICE_TYPE, QUANTIS_DEVICE_ID, &d, 0, 1);
    return d;    
}

int main(int argc, char* argv[]) {
	return MLMain(argc, argv);
}
