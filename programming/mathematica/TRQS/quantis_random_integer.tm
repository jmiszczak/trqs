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
    QuantisReadScaledInt(QUANTIS_DEVICE_TYPE, QUANTIS_DEVICE_ID, &n, i, j);
    return n;    
}

int main(int argc, char* argv[]) {
	return MLMain(argc, argv);
}
