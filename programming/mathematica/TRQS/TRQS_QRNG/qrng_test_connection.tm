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
	char* qrng_error_string;

	// try to connect
	QRNG_PREPARE(qrng_status)

	// retport the result	
	qrng_error_string = qrng_error_strings[qrng_status];
	return qrng_error_string;
}

int main(int argc, char* argv[]) {
	return MLMain(argc, argv);
}
