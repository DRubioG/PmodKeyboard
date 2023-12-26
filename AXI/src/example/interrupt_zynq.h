#include "xscugic.h"
#include "xparameters.h"
#include "xil_exception.h"

XStatus conf_IRQ(XScuGic intPtr, u32 SCUGIC_DEVICE_ID, u32 INT_ID, Xil_ExceptionHandler InterruptHandler);
