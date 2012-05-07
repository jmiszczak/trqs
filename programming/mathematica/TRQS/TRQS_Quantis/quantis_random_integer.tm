:Begin:
:Function:	quantis_random_integer
:Pattern:	TrueRandomInteger[{i_Integer, j_Integer}]
:Arguments:	{ i, j }
:ArgumentTypes:	{ Integer, Integer }
:ReturnType:	Integer
:End:

#include "Quantis.h"
#include "TRQS.h"

int quantis_random_integer(int i, int j) {
    int n;

	QuantisDeviceType device_type;
	int device_id;
	int quantis_status;

	// prepare and check the device
	QUANTIS_PREPARE(device_type,device_id,quantis_status);

	if (quantis_status > 0) {
    	QuantisReadScaledInt(device_type, device_id, &n, i, j);
	}

    return n;    
}

int main(int argc, char* argv[]) {
	return MLMain(argc, argv);
}
