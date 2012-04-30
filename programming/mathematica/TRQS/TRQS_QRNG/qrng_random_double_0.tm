:Begin:
:Function:	qrng_random_double_0
:Pattern:	TrueRandomReal[]
:Arguments:	{ }
:ArgumentTypes:	{ }
:ReturnType:	Double
:End:

#include "libQRNG.h"
#include "TRQS.h"

double qrng_random_double_0() {
    double rand_double;

	qrng_get_double((double*)& rand_double);

    return rand_double;    
}

int main(int argc, char* argv[]) {
	return MLMain(argc, argv);
}
