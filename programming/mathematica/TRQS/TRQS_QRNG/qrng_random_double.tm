:Begin:
:Function:	qrng_random_double
:Pattern:	TrueRandomReal[{x_, y_}]
:Arguments:	{ x, y }
:ArgumentTypes:	{ Double, Double }
:ReturnType:	Double
:End:

#include "libQRNG.h"
#include "TRQS.h"

double qrng_random_double(double x, double y) {
    double rand_double;

	qrng_get_double((double*)& rand_double);
	rand_double = rand_double*(y-x) + x;
    

    return rand_double;    
}

int main(int argc, char* argv[]) {
	return MLMain(argc, argv);
}
