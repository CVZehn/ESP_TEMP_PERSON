#include "def.h"
#include "HeadAl.h"
void CLK_init(void)//��ʱ�ӣ��ڲ�ʱ�ӣ�����ʱ�� ����Ӧ��Ƶ��
{
	CLK->ECKR = 0X01;//���ⲿʱ��
	while((CLK->ECKR&0x02)==0x00);//�ⲿʱ�ӹ����ȶ�
	
	CLK->SWCR = CLK->SWCR|0x02;//����ʱ���л�
	CLK->SWR = 0xb4;//�ⲿʱ��
	while((CLK->SWCR&0x08)==0);//�ȴ��л����
	CLK->SWCR = CLK->SWCR&0xFD;//�����־
	CLK->ICKR = 0x0;//�ر��ڲ�ʱ��	
	CLK->CKDIVR = 0x01;//8-->4M 
}
void CLKInner_Init(void)
{
	CLK->PCKENR1 = 0xb0;//timer1  timer2 timer4 
	CLK->PCKENR2 = 0x08;//ADC����ʱ��
	CLK->CKDIVR = 0x9;//CLK_init();Fmaster = 8MHz FCPU = 4MHz
}