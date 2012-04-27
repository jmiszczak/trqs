:Begin:
:Function:	quantis_random_integer_1
:Pattern:	TrueRandomInteger[j_Integer]
:Arguments:	{ j }
:ArgumentTypes:	{ Integer }
:ReturnType:	Integer
:End:

#include "Quantis.h"
#include "TRQS.h"

int quantis_random_integer_1(int j) {
    int n;
    QuantisReadScaledInt(QUANTIS_DEVICE_TYPE, QUANTIS_DEVICE_ID, &n, 0, j);
    return n;    
}

int main(int argc, char* argv[]) {
	return MLMain(argc, argv);
}
