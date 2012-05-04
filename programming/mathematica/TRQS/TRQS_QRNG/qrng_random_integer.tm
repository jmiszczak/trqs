:Begin:
:Function:	qrng_random_integer
:Pattern:	TrueRandomInteger[{i_Integer, j_Integer}]
:Arguments:	{ i, j }
:ArgumentTypes:	{ Integer, Integer }
:ReturnType:	Integer
:End:

#include "libQRNG.h"
#include "TRQS.h"

int qrng_random_integer(int i, int j) {
	int rand_int;
	int range = j - i + 1; 
	int rem;

	int qrng_status;

	// try to connect
	QRNG_ESTABLISH_CONNECTION(qrng_status);

	if (qrng_status == QRNG_SUCCESS) {
		qrng_get_int((int*)& rand_int);
	}

	rem = (rand_int % range);

	if (rem < 0) { // get the positive one 
		rem = rem +range;
	}
	
	rand_int = rem + i;
	
	return rand_int; 
}

int main(int argc, char* argv[]) {
	return MLMain(argc, argv);
}
