/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
//#include "platform.h"
//#include "xil_printf.h"
#include "xparameters.h"
#include "xuartps.h"
//#include "write_register_m_inst.h" //<- Driver de tu IP
#include "Write_register_m_inst.h"
#include <xil_io.h>


/************************* Constant Definitions ****************************/
#define UART_BASEADDR		XPAR_PS7_UART_1_BASEADDR
#define WRITE_REGISTER_M_INST_BASEADDR	XPAR_WRITE_REGISTER_M_INST_0_S00_AXI_BASEADDR  //<- Address de tu IP, se obtiene de xparamenters




int main(){

	int fsw=50;
	int ma=500;
	int ena=0;
	 int menu=0;
	//char menu[20]="0";

	//Inicializar el registro
	WRITE_REGISTER_M_INST_mWriteReg(WRITE_REGISTER_M_INST_BASEADDR, 0, ma);
	WRITE_REGISTER_M_INST_mWriteReg(WRITE_REGISTER_M_INST_BASEADDR, 4, fsw);
	WRITE_REGISTER_M_INST_mWriteReg(WRITE_REGISTER_M_INST_BASEADDR, 8, ena);

	//Flush UART FIFO
	while (XUartPs_IsReceiveData(UART_BASEADDR)) XUartPs_ReadReg(UART_BASEADDR, XUARTPS_FIFO_OFFSET);
    printf("Hello World\n\r");

    while (1){ 	// Para que pregunte constantemente por un cambio

    	menu=0;
    	while(menu!=1 && menu!=2 && menu!=3 ){
    		printf("Elige el parametro a modificar: 	(Valor actual)\n");
    		printf("	1. ma                               (%d)\n", ma);
    		printf("	2. fsw                              (%d)\n", fsw);
    		printf("	3. enable                           (%d)\n", ena);
    		printf("Opcion: ");
    		scanf("%d",&menu);
    		printf("\n %d", menu);

    	}
    	switch(menu){
    		case 1:
    			do{
    				printf("\n ma(x1000): ");
    				scanf("%d",&ma);
    			}while(ma<0 || ma>1300);		//ma limitada en 1300. Por bits en 2047
    			printf("\n ma(x1000): %d",ma);
    			WRITE_REGISTER_M_INST_mWriteReg(WRITE_REGISTER_M_INST_BASEADDR, 0, ma);
    			break;

    		case 2:
    			do{
    				printf("\n fsw: ");
    				scanf("%d",&fsw);
    			}while(fsw<0 || fsw>1023);		//fsw limitada a 1023. Por bits en 1023
    			printf("\n fsw: %d",fsw);
    			WRITE_REGISTER_M_INST_mWriteReg(WRITE_REGISTER_M_INST_BASEADDR, 4, fsw);
    			break;

    		case 3:
    			do{
    				printf("\n enable: ");
    				scanf("%d",&ena);
    			}while(ena<0 || ena>1);
    			printf("\n enable: %d",ena);
    			WRITE_REGISTER_M_INST_mWriteReg(WRITE_REGISTER_M_INST_BASEADDR, 8, ena);
    			break;

    		default:
    			printf("\n Estoy en default");
    			break;
    	}
    	printf("\n Fin de ciclo");

    }


    return 0;

}
