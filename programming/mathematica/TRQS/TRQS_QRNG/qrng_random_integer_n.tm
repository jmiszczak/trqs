:Begin:
:Function:	qrng_random_integer_n
:Pattern:	TrueRandomInteger[{min_Integer, max_Integer}, dim_Integer]
:Arguments:	{ min, max, dim}
:ArgumentTypes:	{ Integer, Integer, Integer }
:ReturnType:	Manual
:End:

#include <stdlib.h>
#include "libQRNG.h"
#include "TRQS.h"

void qrng_random_integer_n(int min, int max, int dim) {
	int* rand_ints;
	int actual_count;
	int range = max - min + 1; 
	int rem;
	int k;

	int qrng_status;

	// try to connect
	QRNG_PREPARE(qrng_status);

	rand_ints = (int*) malloc(dim * sizeof (int));

	if (qrng_status == QRNG_SUCCESS) {
		qrng_get_int_array(rand_ints, dim, & actual_count);
	}

	for (k=0; k<dim; k++) {
		rem = (rand_ints[k] % range);
		if (rem < 0) { // get the positive one 
			rem = rem + range;
		}
		rand_ints[k] = rem + min;
	}

	MLPutInteger32List(stdlink, rand_ints, dim);	
	
	return ;
}

int main(int argc, char* argv[]) {
	return MLMain(argc, argv);
}
