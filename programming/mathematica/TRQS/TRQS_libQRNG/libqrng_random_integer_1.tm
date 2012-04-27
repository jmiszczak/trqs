:Begin:
:Function:	libqrng_random_integer_1
:Pattern:	TrueRandomInteger[j_Integer]
:Arguments:	{ j }
:ArgumentTypes:	{ Integer }
:ReturnType:	Integer
:End:

#include "libQRNG.h"
#include "TRQS.h"

int libqrng_random_integer_1(int j) {
	int rand_int;

	if ( qrng_connect(LIBQRNG_USER, LIBQRNG_PASS) == QRNG_SUCCESS) {
		qrng_get_int((int*)& rand_int);
		rand_int = (rand_int % (j+1)); // range is j+1
		if (rand_int < 0) {
			rand_int = rand_int + j + 1;
		}
	}
	qrng_disconnect();
	return rand_int; 
}

int main(int argc, char* argv[]) {
	return MLMain(argc, argv);
}
