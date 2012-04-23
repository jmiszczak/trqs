:Begin:
:Function:	libqrng_get_lib_version
:Pattern:	LibQRNGGetLibVersion[]
:Arguments:	{ }
:ArgumentTypes:	{ }
:ReturnType:	Float
:End:

/*#include "libQRNG.h"*/

float libqrng_get_lib_version(void) {
/*    return qrng_libQRNG_version();    */
	return 0.1;
}

int main(int argc, char* argv[]) {
	return MLMain(argc, argv);
}
