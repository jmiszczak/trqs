:Begin:
:Function:	quantis_get_device_type
:Pattern:	QuantisGetDeviceType[]
:Arguments:	{ }
:ArgumentTypes:	{ }
:ReturnType:	String
:End:

#include "Quantis.h"
#include "TRQS.h"

char* quantis_get_device_type(void) {
    char* deviceType;
    switch (QUANTIS_DEVICE_TYPE) {
        case QUANTIS_DEVICE_PCI:
            deviceType = "PCI";
            break;
        case QUANTIS_DEVICE_USB:
            deviceType = "USB";
            break;
        default:
            deviceType = "n/a";
            break;
    }
    return deviceType;
}

int main(int argc, char* argv[]) {
	return MLMain(argc, argv);
}
