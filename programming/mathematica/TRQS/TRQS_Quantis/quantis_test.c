#include <stdio.h>
#include <float.h>
#include <limits.h>

#include "Quantis.h"
#include "TRQS.h"

int main(int argc, char* argv[]) {
    double d;
    
    printf("DBL_MIN=%e\n",DBL_MIN);
    printf("DBL_MAX=%e\n",DBL_MAX);
    
    if (!QuantisReadScaledDouble(QUANTIS_DEVICE_USB, 0, &d, 0, 1) ) {
       printf("%e\n",d);
    }
    
    printf ("%f\n", QuantisGetLibVersion());	
    printf ("%s\n", QuantisGetSerialNumber(QUANTIS_DEVICE_USB,0));	
    
    
    char* deviceType;
    switch (QUANTIS_DEVICE_TYPE) {
        case QUANTIS_DEVICE_USB:
            deviceType = "USB";
            break;
        case QUANTIS_DEVICE_PCI:
            deviceType = "PCI";
            break;
        default:
            deviceType = "N/A";
            break;
    }
    printf("%s\n", deviceType);
    printf("%i\n", QUANTIS_DEVICE_TYPE);
    
    
//    if ()
    
    return 0;
}
