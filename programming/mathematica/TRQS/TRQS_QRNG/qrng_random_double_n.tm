:Begin:
:Function:	qrng_random_double_n
:Pattern:	TrueRandomReal[{x_, y_}, dim_Integer]
:Arguments:	{ x, y, dim }
:ArgumentTypes:	{ Real, Real, Integer }
:ReturnType:	Manual
:End:

#include <stdlib.h>
#include "libQRNG.h"
#include "TRQS.h"

void qrng_random_double_n(double x, double y, int dim) {
	double* rand_doubles;
	int actual_count;
	int k;

	int qrng_status;

	// try to connect
	QRNG_PREPARE(qrng_status);

	rand_doubles = (double*) malloc(dim * sizeof (double));

	if (qrng_status == QRNG_SUCCESS) {
		qrng_get_double_array(rand_doubles, dim, & actual_count);
	}

	for (k=0; k<dim; k++) {
		rand_doubles[k] = (y-x)*rand_doubles[k] + x;
	}

	MLPutReal64List(stdlink, rand_doubles, dim);	
	
	return ;
}

int main(int argc, char* argv[]) {
	return MLMain(argc, argv);
}
