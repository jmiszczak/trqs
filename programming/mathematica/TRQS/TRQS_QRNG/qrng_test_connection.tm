:Begin:
:Function:	qrng_test_connection
:Pattern:	QRNGTestConnection[]
:Arguments:	{ }
:ArgumentTypes:	{ }
:ReturnType:	String
:End:

#include "libQRNG.h"
#include "TRQS.h"

char* qrng_test_connection() {
	int qrng_status;

	// try to connect
	QRNG_ESTABLISH_CONNECTION(qrng_status)

	// retport the result	
	return qrng_error_strings[qrng_status];
}

int main(int argc, char* argv[]) {
	return MLMain(argc, argv);
}
