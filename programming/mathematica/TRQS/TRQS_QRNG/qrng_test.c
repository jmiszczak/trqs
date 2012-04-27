#include <stdio.h>
#include "libQRNG.h"

int main() {
	int ret_code;
	int int_value;
	double double_value;

    /* connect */
	ret_code = qrng_connect("jmiszczak","alama12kota");

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
