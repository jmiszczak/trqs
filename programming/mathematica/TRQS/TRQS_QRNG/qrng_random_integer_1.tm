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

	qrng_get_int((int*)& rand_int);
	rand_int = (rand_int % (j+1)); // range is j+1
	if (rand_int < 0) {
		rand_int = rand_int + j + 1;
	}

	return rand_int; 
}

int main(int argc, char* argv[]) {
	return MLMain(argc, argv);
}
