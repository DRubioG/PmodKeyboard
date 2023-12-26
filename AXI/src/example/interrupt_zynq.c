#include "interrupt_zynq.h"

XStatus conf_IRQ(XScuGic intPtr,
		u32 SCUGIC_DEVICE_ID,
		u32 INT_ID,
		Xil_ExceptionHandler InterruptHandler){
	/*
	 * intPtr : name of interruption
	 * SCUGIC_DEVICE_ID : the number of the GIC device, normally 0
	 * INT_ID : the number of the interrupt, normally starts with "XPAR_FPGA..."
	 * InterruptHandler : this is the name of the interruption function
	 * */

	XStatus  ret;
	XScuGic_Config *int_Config;

	int_Config=XScuGic_LookupConfig(SCUGIC_DEVICE_ID);		//configuracion
	if (int_Config==NULL){return -1;}

	ret=XScuGic_CfgInitialize(&intPtr, int_Config,int_Config->CpuBaseAddress);		//inicializacion
	if (ret!=XST_SUCCESS){return -1;}

	Xil_ExceptionRegisterHandler(			//registrar tabla de vectores GIC
			XIL_EXCEPTION_ID_IRQ_INT,
	(Xil_ExceptionHandler) XScuGic_InterruptHandler,
	&intPtr);

	XScuGic_SetPriorityTriggerType(&intPtr, INT_ID, 0xA0, 0x3);

	ret=XScuGic_Connect(		//Conexion de ISQ <-> ISR
			&intPtr,
			INT_ID,
			(Xil_ExceptionHandler) InterruptHandler,
			(void *) NULL);
	if (ret!=XST_SUCCESS){return -1;}

	XScuGic_Enable(&intPtr, INT_ID);		//habilitar tratamiento de excepciones

	Xil_ExceptionEnable();

	return ret;
}
