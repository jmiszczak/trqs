#include <stdio.h>
#include <float.h>
#include <limits.h>

#include "Quantis.h"
#include "TRQS.h"

int main(int argc, char* argv[]) {
  double d;
  int noDevs;

  printf("DBL_MIN=%e\n",DBL_MIN);
  printf("DBL_MAX=%e\n",DBL_MAX);

  printf ("%f\n", QuantisGetLibVersion());	
  printf ("%s\n", QuantisGetSerialNumber(QUANTIS_DEVICE_USB,0));	

  if (!QuantisReadScaledDouble(QUANTIS_DEVICE_USB, 0, &d, 0, 1) ) {
	printf("Random double: %e\n",d);
  }

  printf ("Number of USB devices: %i\n",QuantisCount(QUANTIS_DEVICE_USB));
  printf ("Number of PCI devices: %i\n",QuantisCount(QUANTIS_DEVICE_PCI));

  return 0;
}
