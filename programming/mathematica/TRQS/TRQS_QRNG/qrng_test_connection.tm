:Begin:
:Function:	qrng_test_connection
:Pattern:	QRNGTestConnection[]
:Arguments:	{ }
:ArgumentTypes:	{ }
:ReturnType:	String
:End:

#include "libQRNG.h"
#include "TRQS.h"

char* qrng_test_conection() {
	int ret_code;
	
	const char* user;
	const char* pass;

	MLPuySymbol(stdlink, "TRQS`Private`QRNGUsername
	MLGetString(stdlink, user)
	

//	ret_code = qrng_connect(user, pass);
	ret_code = 0;
	
	return qrng_error_strings[ret_code];
}

int main(int argc, char* argv[]) {
	return MLMain(argc, argv);
}
