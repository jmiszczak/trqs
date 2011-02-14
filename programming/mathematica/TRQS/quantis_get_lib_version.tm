:Begin:
:Function:	quantis_get_lib_version
:Pattern:	QuantisGetLibVersion[]
:Arguments:	{ }
:ArgumentTypes:	{ }
:ReturnType:	Float
:End:

#include "Quantis.h"
#include "TRQS.h"

float quantis_get_lib_version(void) {
    return QuantisGetLibVersion();    
}

int main(int argc, char* argv[]) {
	return MLMain(argc, argv);
}
