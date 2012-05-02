::Begin:
:Function: qrng_set_credentails
:Pattern: MLSetGlobalVar[user_, pass_]
:Arguments: { user, pass }
:ArgumentTypes: { String, String }
:ReturnType: Integer
:End:

int qrng_set_credentials(conts char* user, const char* pass) {

	MLPutFunction(stdlink, "Set", 2);
	MLPutSymbol(stdlink, "TRQS`Private`QRNGUsername");
	MLPutString(stdlink, user);

	MLPutFunction(stdlink, "Set", 2);
	MLPutSymbol(stdlink, "TRQS`Private`QRNGPassword");
	MLPutString(stdlink, pass);

}

int main(int argc, char* argv[]) {
    return MLMain(argc, argv);
}
