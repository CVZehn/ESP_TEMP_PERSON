#ifndef __HTMC012_H
#define __HTMC012_H	 
#include "sys.h"


/*

#define LED0 PAout(8)	// PA8
#define LED1 PDout(2)	// PD2	

void LED_Init(void);//³õÊ¼»¯
*/
//PC8  SDA
//PC9  SCK

#define V4_I2C_ADDR 0x44
#define ACK 0
#define NACK 1

#define HDCSDA_CLR()    	GPIOC->BRR=GPIO_Pin_8      
#define	HDCSDA_SET()  		GPIOC->BSRR = GPIO_Pin_8
#define HDCSCL_CLR()    	GPIOC->BRR = GPIO_Pin_9         
#define	HDCSCL_SET()  		GPIOC->BSRR = GPIO_Pin_9
#define HDCGet_SDA()    	(GPIOC->IDR)&GPIO_Pin_8 
#define HDCSDA_Output()  	GPIOC->CRH |=0x05
#define HDCSDA_Input()   	GPIOC->CRH &=0xFFFFFFF4


void IICIO_Init(void);
void DHTC12_MInit(void);
u8 ReadDHTC12_M(s16 *tem,u16 *Hum);
		 				    
#endif
