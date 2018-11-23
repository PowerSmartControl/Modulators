//*	main.c	--																*
// *																			*
// * Ver   Who  Date     Changes												*
// * ----- ---- -------- ---------------------------------------------		*
// * v00	 XXX   00/00/00 Creation											*
// * 																			*
// ****************************************************************************/


/***************************** Include Files *******************************/
#include "xparameters.h"
#include "xuartps.h"
#include "myip_pspwm.h" //<- Driver de tu IP
#include <xil_io.h>
#include <stdio.h>


/************************* Constant Definitions ****************************/
#define UART_BASEADDR		XPAR_PS7_UART_1_BASEADDR
#define MYIP_PSPWM_BASEADDR	XPAR_MYIP_PSPWM_0_S00_AXI_BASEADDR  //<- Address de tu IP, se obtiene de xparamenters
/**************************** Type Definitions *****************************/


/************************** Function Prototypes ******************************/


/************************** Variable Definitions *****************************/


/****************************************************************************
 * main function
 *
 ****************************************************************************/
int main(void)
{
	int a=10000, b=25, c, d, v, x, y ,z,f;

	//Initialization
	MYIP_PSPWM_mWriteReg(MYIP_PSPWM_BASEADDR, 0, 12500);
	MYIP_PSPWM_mWriteReg(MYIP_PSPWM_BASEADDR, 4, 3125);
	MYIP_PSPWM_mWriteReg(MYIP_PSPWM_BASEADDR, 8, 12);
	MYIP_PSPWM_mWriteReg(MYIP_PSPWM_BASEADDR, 12, 12);
	//Flush UART FIFO
	while (XUartPs_IsReceiveData(UART_BASEADDR)) XUartPs_ReadReg(UART_BASEADDR, XUARTPS_FIFO_OFFSET);
	//Imprimir menú si fuera necesario

	//Command decoding
	while (1){ //comando de exit
		printf("Ingrese Parametros \n");
		printf("Frecuencia de conmutacion (Hz): \n");
		scanf(" %i", &a);
		if (a > 200000) {
			a = 200000;
				}
		v = (250000000)/(2*a);
		x = (v*b)/(100);
		MYIP_PSPWM_mWriteReg(MYIP_PSPWM_BASEADDR, 0, v);
		MYIP_PSPWM_mWriteReg(MYIP_PSPWM_BASEADDR, 4, x);
		printf("Ciclo de trabajo (int): \n");
		scanf(" %i", &b);
		if (b >= 80) {
			b = 80;
		}
		x = (v*b)/(100);
		MYIP_PSPWM_mWriteReg(MYIP_PSPWM_BASEADDR, 4, x);
		printf("Tiempo muerto 1 (ns): \n");
		scanf(" %i", &c);
		y = (c-60)/4;
		MYIP_PSPWM_mWriteReg(MYIP_PSPWM_BASEADDR, 8, y);
		printf("Tiempo muerto 2 (ns): \n\n");
		scanf(" %i", &d);
		z = (d-60)/4;
		MYIP_PSPWM_mWriteReg(MYIP_PSPWM_BASEADDR, 12, z);
		printf("Parametros Ingresados: \n");
		//f = MYIP_PSPWM_mReadReg(MYIP_PSPWM_BASEADDR, 4);
		printf("Frecuencia de conmutacion: %i\n",a);
		printf("Ciclo de trabajo: %i\n",b);
		printf("Tiempo muerto 1: %i\n",c);
		printf("Tiempo muerto 2: %i\n\n",d);

	}
	return 1;
}
