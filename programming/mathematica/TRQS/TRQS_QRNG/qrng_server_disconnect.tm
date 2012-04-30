:Begin:
:Function:	qrng_server_disconnect
:Pattern:	QRNGServerDisconnect[]
:Arguments:	{ }
:ArgumentTypes:	{ }
:End:

#include "libQRNG.h"
#include "TRQS.h"

void qrng_server_disconnect() {
	
	qrng_disconnect();
	
}

int main(int argc, char* argv[]) {
	return MLMain(argc, argv);
}
