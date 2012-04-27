:Begin:
:Function:	libqrng_random_double_1
:Pattern:	TrueRandomReal[y_]
:Arguments:	{ y }
:ArgumentTypes:	{ Double }
:ReturnType:	Double
:End:

#include "libQRNG.h"
#include "TRQS.h"

double libqrng_random_double_1(double y) {
    double rand_double;

    if ( qrng_connect(LIBQRNG_USER, LIBQRNG_PASS) == QRNG_SUCCESS) {
		qrng_get_double((double*)& rand_double);
		rand_double = rand_double*y;
    }

    return rand_double;    
}

int main(int argc, char* argv[]) {
	return MLMain(argc, argv);
}
