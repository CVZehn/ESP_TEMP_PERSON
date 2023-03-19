#include <STC8.H>
#include "Delay.h"
#include "DHTC12.H"
#include <intrins.h>
#include <stdio.h>



void Uart_Init()		//9600bps@11.0592MHz
{
	SCON = 0x50;		//
	AUXR &= 0xBF;		//
	AUXR &= 0xFE;		//
	TMOD &= 0x0F;		//
	TL1 = 0xE8;		//
	TH1 = 0xFF;		//
	ET1 = 0;		//
	TR1 = 1;		//
}

void Uart_TXD (unsigned char Data)
{	
		SBUF = Data;
		while(TI == 0);
		TI = 0;
}	


 /*********发送文本串**********/
void Usart1_SandTXString(u8 *s)
{
 u8 i=0;

TI = 0;
 while(s[i]!=0)
 {
	 	SBUF = s[i];
	  i++;
		while(TI == 0);
		TI = 0;
 }
}


void main ()
{	
	u8 errorflag;
	u16 HumResult;
	s16 TemResult;
	float HumResultF,TemResultF;
	char RH[18] = {0};
	char T[18] = {0};
		
	
	/*配置IO口模式为准双向口;*/
	P5M0 &= 0xdf;
	P5M1 &= 0xdf;
	P3M0 &= 0xf0;
	P3M1 &= 0xf0;		


	DHTC12_MInit();			
	Uart_Init();

	while(1)
	{	
		Delay1ms(600);
		errorflag = ReadDHTC12_M(&TemResult,&HumResult);
		HumResultF = (float)HumResult/10;
		TemResultF = (float)TemResult/10;
		sprintf(RH,"RH:%0.1F",HumResultF);
		sprintf(T,"RH; T:%0.1F℃",TemResultF);
		P55 = 0;
		Usart1_SandTXString(RH);
		Uart_TXD('%');		
		Usart1_SandTXString(T);
		Uart_TXD(';');
		Uart_TXD(' ');
		Uart_TXD(' ');
		Delay1ms(600);
		P55 = 1;
	}
}	
