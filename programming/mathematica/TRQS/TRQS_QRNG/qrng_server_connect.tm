:Begin:
:Function:	qrng_server_connect
:Pattern:	QRNGServerConnect[user_, pass_]
:Arguments:	{ user, pass }
:ArgumentTypes:	{ String, String }
:ReturnType:	String
:End:

#include "libQRNG.h"
#include "TRQS.h"

char* qrng_server_connect(const char* user, const char* pass) {
	int ret_code;

	ret_code = qrng_connect(user, pass);
	
	return qrng_error_strings[ret_code];
}

int main(int argc, char* argv[]) {
	return MLMain(argc, argv);
}
