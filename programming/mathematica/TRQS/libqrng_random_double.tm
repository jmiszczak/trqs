:Begin:
:Function:	libqrng_random_double
:Pattern:	TrueRandomReal[{x_, y_}]
:Arguments:	{ x, y }
:ArgumentTypes:	{ Double, Double }
:ReturnType:	Double
:End:

#include "libQRNG.h"
#include "TRQS.h"

double libqrng_random_double(double x, double y) {
    double rand_double;

    if ( qrng_connect(LIBQRNG_USER, LIBQRNG_PASS) == QRNG_SUCCESS) {
		qrng_get_double((double*)& rand_double);
		rand_double = rand_double*(y-x) + x;
    }

    return rand_double;    
}

int main(int argc, char* argv[]) {
	return MLMain(argc, argv);
}
