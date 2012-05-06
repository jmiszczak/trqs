:Begin:
:Function:	quantis_random_double_n
:Pattern:	TrueRandomReal[{x_, y_}, dim_Integer]
:Arguments:	{ x, y, dim }
:ArgumentTypes:	{ Real, Real, Integer }
:ReturnType:	Manual
:End:

#include <stdlib.h>
#include "Quantis.h"
#include "TRQS.h"

void quantis_random_double_n(double x, double y, int dim) {
    double* rand_doubles;
	int k;

	QuantisDeviceType device_type;
	int device_id;
	int quantis_status;

	// prepare and check the device
	QUANTIS_PREPARE(device_type,device_id,quantis_status);

	rand_doubles = (double*) malloc(dim * sizeof (double));

	if (quantis_status > 0) {
		for (k=0; k<dim; k++) {
			QuantisReadScaledDouble(device_type, device_id, &rand_doubles[k], x, y);
		}
	}

	MLPutReal64List(stdlink, rand_doubles, dim);	
    return;    
}

int main(int argc, char* argv[]) {
	return MLMain(argc, argv);
}
