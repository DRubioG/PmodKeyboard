#include "xparameters.h"
#include "xil_io.h"

#define BASE_ADDDR XPAR_PMODKYPD_0_S00_AXI_BASEADDR

void enableKeyboard();
void disableKeyboard();
int getKeyboardValue();