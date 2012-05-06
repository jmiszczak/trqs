:Begin:
:Function:	quantis_random_integer_n
:Pattern:	TrueRandomInteger[{i_Integer, j_Integer}, dim_]
:Arguments:	{ i, j, dim }
:ArgumentTypes:	{ Integer, Integer, Integer }
:ReturnType:	Manual
:End:

#include "Quantis.h"
#include "TRQS.h"

void quantis_random_integer_n(int i, int j, int dim) {
    int* rand_ints;
	int k;

	QuantisDeviceType device_type;
	int device_id;
	int quantis_status;

	// prepare and check the device
	QUANTIS_PREPARE(device_type,device_id,quantis_status);

	rand_ints = (int*) malloc(dim * sizeof (int));

	if (quantis_status > 0) {
		for (k=0; k<dim; k++) {
			QuantisReadScaledInt(device_type, device_id, &rand_ints[k], i, j);
		}
	}

	MLPutInteger32List(stdlink, rand_ints, dim);	

    return;    
}

int main(int argc, char* argv[]) {
	return MLMain(argc, argv);
}
