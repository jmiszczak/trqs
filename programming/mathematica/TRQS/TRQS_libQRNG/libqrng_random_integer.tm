:Begin:
:Function:	libqrng_random_integer
:Pattern:	TrueRandomInteger[{i_Integer, j_Integer}]
:Arguments:	{ i, j }
:ArgumentTypes:	{ Integer, Integer }
:ReturnType:	Integer
:End:

#include "libQRNG.h"
#include "TRQS.h"

int libqrng_random_integer(int i, int j) {
	int rand_int;
	int range = j - i + 1; 
	int rem;

	if ( qrng_connect(LIBQRNG_USER, LIBQRNG_PASS) == QRNG_SUCCESS) {
		qrng_get_int((int*)& rand_int);
		rem = (rand_int % range);
		if (rem < 0) {
			rem = rem +range;
		}
		rand_int = rem + i;
	}
	qrng_disconnect();
	return rand_int; 
}

int main(int argc, char* argv[]) {
	return MLMain(argc, argv);
}
