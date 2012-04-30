:Begin:
:Function:	qrng_random_double_1
:Pattern:	TrueRandomReal[y_]
:Arguments:	{ y }
:ArgumentTypes:	{ Double }
:ReturnType:	Double
:End:

#include "libQRNG.h"
#include "TRQS.h"

double qrng_random_double_1(double y) {
    double rand_double;

	qrng_get_double((double*)& rand_double);

    return rand_double;    
}

int main(int argc, char* argv[]) {
	return MLMain(argc, argv);
}
