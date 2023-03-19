#include "led.h"
#include "delay.h"
#include "sys.h"
#include "usart.h"
#include "DHTC12.h"

	


 /*********发送文本串**********/
void Usart1_SandTXString(u8 *s)
{
 u8 i=0;

 while(s[i]!=0)
 {
	 	USART1->DR=s[i];
	 i++;
		while((USART1->SR&0X40)==0);//等待发送结束
 }
}

 int main(void)
 {	
	u8 t;
	u8 len;	
	u16 times=0;
  s16 TemResult;
  u16 HumResult;	 
 	float HumResultF,TemResultF;
	char HumD[18] = {0};
	char TempD[18] = {0};
	 
	 
	delay_init();	    	 //延时函数初始化	
	NVIC_Configuration();// 设置中断优先级分组
	uart_init(9600);	 //串口初始化为9600
	LED_Init();		  	 //初始化与LED连接的硬件接口 
 
	IICIO_Init();
  DHTC12_MInit();

	while(1)
	{
		ReadDHTC12_M(&TemResult,&HumResult);
		HumResultF = (float)HumResult/10;
		TemResultF = (float)TemResult/10;
		sprintf(HumD,"RH:%0.1F",HumResultF);
		sprintf(TempD,"  T:%0.1F℃  ",TemResultF);
		Usart1_SandTXString(HumD);	
		Usart1_SandTXString(TempD);
	
		delay_ms(600);
	}	 
}


