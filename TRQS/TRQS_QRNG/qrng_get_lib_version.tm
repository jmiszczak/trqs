:Begin:
:Function:	qrng_get_lib_version
:Pattern:	QRNGGetLibVersion[]
:Arguments:	{ }
:ArgumentTypes:	{ }
:ReturnType:	String
:End:

#include "libQRNG.h"
#include "TRQS.h"

char* qrng_get_lib_version(void) {
    return qrng_libQRNG_version; 
}

int main(int argc, char* argv[]) {
	return MLMain(argc, argv);
}
