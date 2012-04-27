:Begin:
:Function:	quantis_random_integer_0
:Pattern:	TrueRandomInteger[]
:Arguments:	{ }
:ArgumentTypes:	{ }
:ReturnType:	Integer
:End:

#include "Quantis.h"
#include "TRQS.h"

int quantis_random_integer_0(void) {
    int n;
    QuantisReadScaledInt(QUANTIS_DEVICE_TYPE, QUANTIS_DEVICE_ID, &n, 0, 1);
    return n;    
}

int main(int argc, char* argv[]) {
	return MLMain(argc, argv);
}
