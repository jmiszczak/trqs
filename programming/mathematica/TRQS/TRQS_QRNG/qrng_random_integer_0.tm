:Begin:
:Function:	libqrng_random_integer_0
:Pattern:	TrueRandomInteger[]
:Arguments:	{ }
:ArgumentTypes:	{ }
:ReturnType:	Integer
:End:

#include "libQRNG.h"
#include "TRQS.h"

int libqrng_random_integer_0() {
	int rand_int;

	if ( qrng_connect(LIBQRNG_USER, LIBQRNG_PASS) == QRNG_SUCCESS) {
		qrng_get_int((int*)& rand_int);
		rand_int = (rand_int % 2); // range is 2
		if (rand_int < 0) {
			rand_int = rand_int + 2;
		}
	}
	qrng_disconnect();
	return rand_int; 
}

int main(int argc, char* argv[]) {
	return MLMain(argc, argv);
}
