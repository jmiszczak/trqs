:Begin:
:Function:	qrng_random_integer_1
:Pattern:	TrueRandomInteger[j_Integer]
:Arguments:	{ j }
:ArgumentTypes:	{ Integer }
:ReturnType:	Integer
:End:

#include "libQRNG.h"
#include "TRQS.h"

int qrng_random_integer_1(int j) {
	int rand_int;
	int qrng_status;

	// try to connect
	QRNG_ESTABLISH_CONNECTION(qrng_status);

	if (qrng_status == QRNG_SUCCESS) {
		qrng_get_int((int*)& rand_int);
	}

	rand_int = (rand_int % (j+1)); // range is j+1

	if (rand_int < 0) { // get the positive one
		rand_int = rand_int + j + 1;
	}

	return rand_int; 
}

int main(int argc, char* argv[]) {
	return MLMain(argc, argv);
}
