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
	int qrng_status;

	// try to connect
	QRNG_PREPARE(qrng_status);

	if (qrng_status == QRNG_SUCCESS) {
		qrng_get_double((double*)& rand_double);
	}

    return rand_double;    
}

int main(int argc, char* argv[]) {
	return MLMain(argc, argv);
}
