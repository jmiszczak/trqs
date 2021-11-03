:Begin:
:Function:	qrng_random_integer_0
:Pattern:	TrueRandomInteger[]
:Arguments:	{ }
:ArgumentTypes:	{ }
:ReturnType:	Integer
:End:

#include "libQRNG.h"
#include "TRQS.h"

int qrng_random_integer_0() {
	int rand_int;
	int qrng_status;

	// try to connect
	QRNG_PREPARE(qrng_status);

	if (qrng_status == QRNG_SUCCESS) {
		qrng_get_int((int*)& rand_int);
	}

	rand_int = (rand_int % 2); // range is 2

	if (rand_int < 0) { // get the positive one
		rand_int = rand_int + 2;
	}
	
	return rand_int; 
}

int main(int argc, char* argv[]) {
	return MLMain(argc, argv);
}
