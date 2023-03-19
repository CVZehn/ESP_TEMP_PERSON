#include "def.h"
#include "HeadAl.h"
void CLK_init(void)//主时钟，内部时钟，外设时钟 各对应分频器
{
	CLK->ECKR = 0X01;//打开外部时钟
	while((CLK->ECKR&0x02)==0x00);//外部时钟工作稳定
	
	CLK->SWCR = CLK->SWCR|0x02;//允许时钟切换
	CLK->SWR = 0xb4;//外部时钟
	while((CLK->SWCR&0x08)==0);//等待切换完成
	CLK->SWCR = CLK->SWCR&0xFD;//清除标志
	CLK->ICKR = 0x0;//关闭内部时钟	
	CLK->CKDIVR = 0x01;//8-->4M 
}
void CLKInner_Init(void)
{
	CLK->PCKENR1 = 0xb0;//timer1  timer2 timer4 
	CLK->PCKENR2 = 0x08;//ADC外设时钟
	CLK->CKDIVR = 0x9;//CLK_init();Fmaster = 8MHz FCPU = 4MHz
}