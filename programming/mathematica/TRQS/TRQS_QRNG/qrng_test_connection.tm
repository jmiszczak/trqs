:Begin:
:Function:	qrng_test_connection
:Pattern:	QRNGTestConnection[]
:Arguments:	{ }
:ArgumentTypes:	{ }
:ReturnType:	String
:End:

#include "libQRNG.h"
#include "TRQS.h"

const char* qrng_test_connection() {
	int ret_code;
	const char* user;
	const char* pass;

	// get the user name
	MLPutFunction(stdlink, "EvaluatePacket", 1); 
    MLPutSymbol(stdlink, "TRQS`Private`QRNGUsername");
    MLEndPacket(stdlink);
    while (MLNextPacket(stdlink) != RETURNPKT) {
        MLNewPacket(stdlink);
	}
    MLGetString(stdlink, &user);

	// get the password
	MLPutFunction(stdlink, "EvaluatePacket", 1); 
    MLPutSymbol(stdlink, "TRQS`Private`QRNGPassword");
    MLEndPacket(stdlink);
    while (MLNextPacket(stdlink) != RETURNPKT) {
        MLNewPacket(stdlink);
	}
    MLGetString(stdlink, &pass);

	// try to connect
	ret_code = qrng_connect(user, pass);

	// retport the result	
	return qrng_error_strings[ret_code];
}

int main(int argc, char* argv[]) {
	return MLMain(argc, argv);
}
