:Begin:
:Function:	quantis_get_serial_number
:Pattern:	QuantisGetSerialNumber[]
:Arguments:	{ }
:ArgumentTypes:	{ }
:ReturnType:	String
:End:

#include "Quantis.h"
#include "TRQS.h"

char* quantis_get_serial_number(void) {

	QuantisDeviceType device_type;
	int device_id;
	int quantis_status;

	// prepare and check the device
	QUANTIS_PREPARE(device_type,device_id,quantis_status);

    if( quantis_status > 0) { 
		return QuantisGetSerialNumber(device_type,device_id);
	} else {
		return "";
	}
}

int main(int argc, char* argv[]) {
	return MLMain(argc, argv);
}
