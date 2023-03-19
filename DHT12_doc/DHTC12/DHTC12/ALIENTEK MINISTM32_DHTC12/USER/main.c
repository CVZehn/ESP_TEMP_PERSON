#include "led.h"
#include "delay.h"
#include "sys.h"
#include "usart.h"
#include "DHTC12.h"

	


 /*********�����ı���**********/
void Usart1_SandTXString(u8 *s)
{
 u8 i=0;

 while(s[i]!=0)
 {
	 	USART1->DR=s[i];
	 i++;
		while((USART1->SR&0X40)==0);//�ȴ����ͽ���
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
	 
	 
	delay_init();	    	 //��ʱ������ʼ��	
	NVIC_Configuration();// �����ж����ȼ�����
	uart_init(9600);	 //���ڳ�ʼ��Ϊ9600
	LED_Init();		  	 //��ʼ����LED���ӵ�Ӳ���ӿ� 
 
	IICIO_Init();
  DHTC12_MInit();

	while(1)
	{
		ReadDHTC12_M(&TemResult,&HumResult);
		HumResultF = (float)HumResult/10;
		TemResultF = (float)TemResult/10;
		sprintf(HumD,"RH:%0.1F",HumResultF);
		sprintf(TempD,"  T:%0.1F��  ",TemResultF);
		Usart1_SandTXString(HumD);	
		Usart1_SandTXString(TempD);
	
		delay_ms(600);
	}	 
}


