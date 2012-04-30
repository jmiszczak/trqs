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

	qrng_get_int((int*)& rand_int);
	rem = (rand_int % range);
	if (rem < 0) {
		rem = rem +range;
	}
	
	rand_int = rem + i;
	
	return rand_int; 
}

int main(int argc, char* argv[]) {
	return MLMain(argc, argv);
}
