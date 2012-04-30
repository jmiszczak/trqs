#include <stdio.h>
#include "libQRNG.h"
#include "TRQS.h"

int main() {
	int ret_code;
	int int_value;
	double double_value;
	const char* lib_version = &qrng_libQRNG_version[9];

	printf("Using QRNG library: %f\n\n", atof(lib_version));

    /* connect */
	ret_code = qrng_connect(QRNG_USER, QRNG_PASS);

	if (ret_code == 0 ) {
        printf ("Connection established\n");
		printf ("%s\n", qrng_error_strings[ret_code]);
	} else {
		printf ("%s\n", qrng_error_strings[ret_code]);
	}

    /* get int data */
    ret_code = qrng_get_int((int*)& int_value);
	if (ret_code == 0 ) {
        printf ("Random integer retrieved\n");
        printf ("%i\n", int_value);
		printf ("%s\n", qrng_error_strings[ret_code]);
	} else {
		printf ("%s\n", qrng_error_strings[ret_code]);
	}

    /* get double data */
    ret_code = qrng_get_double((double*)& double_value);
	if (ret_code == 0 ) {
        printf ("Random double retrieved\n");
        printf ("%f\n", double_value);
		printf ("%s\n", qrng_error_strings[ret_code]);
	} else {
		printf ("%s\n", qrng_error_strings[ret_code]);
	}


    /* finalize */
	qrng_disconnect();	

	return 0;
}
