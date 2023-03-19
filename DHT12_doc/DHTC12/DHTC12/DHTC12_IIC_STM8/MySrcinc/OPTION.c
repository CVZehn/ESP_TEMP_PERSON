#include "def.h"
#include "HeadAl.h"

void OPTIONBYTE(void)
{
	unsigned char i,a,b;
  a = *((unsigned char*)0x4803);
	b = *((unsigned char*)0x4804);
	if((a != 0x01)||(b != 0xfe)) //如果没有对配置字修改
	{
		do{
			while((FLASH->IAPSR&0x08) == 0x00)//看是否处于写保护
			{
				FLASH->DUKR = 0xAE;
				FLASH->DUKR = 0x56;
			}
			FLASH->CR1 = 0x0;//查询方式
			FLASH->CR2 = 0x80;//允许选项字编程
			FLASH->NCR2 = 0x7F;
			//开始编程
			//onebyte AFR第二功能脚
			*((unsigned char*)0x4803) = 0x01;
			*((unsigned char*)0x4804) = 0xfe;
			while((FLASH->IAPSR&0x04)==0);//EOP查看操作完成
			FLASH->IAPSR &=0xfb;//清除结束标志
			
			a = *((unsigned char*)0x4803);
			b = *((unsigned char*)0x4804);
			b = ~b;
		}while(a!=b);
		//onebyte
//	p = (unsigned char *)0x4800;//OPTION地址 强制转化成8位地址
//	*p = 0xAA;

	//	*((unsigned char*)0x4800) = 0xaa;//保护
	//   while((FLASH_IAPSR&0x04)==0);//EOP查看操作完成
	//   FLASH_IAPSR &=0xfb;//清除结束标志
	
		FLASH->IAPSR = FLASH->IAPSR&0xf7;//DUL让他处以写保护
		FLASH->CR2 = 0x00;
		FLASH->NCR2 = 0xFF;
		
	}
}/*
void OPTIONBYTE(void)
{
	unsigned char a;
	a = *((unsigned char*)0x4800);//保护 protect
	if(a != 0xaa)
	{
		while((FLASH->IAPSR&0x08) == 0x00)//看是否处于写保护
		{
			FLASH->DUKR = 0xAE;
			FLASH->DUKR = 0x56;
		}
		FLASH->CR1 = 0x0;//查询方式
		FLASH->CR2 = 0x80;//允许选项字编程
		FLASH->NCR2 = 0x7F;
		*((unsigned char*)0x4800) = 0xaa;
		while((FLASH->IAPSR&0x04)==0);//EOP查看操作完成
		FLASH->IAPSR &=0xfb;//清除结束标志
		FLASH->IAPSR = FLASH->IAPSR&0xf7;//DUL让他处以写保护
		FLASH->CR2 = 0x00;
		FLASH->NCR2 = 0xFF;
	}
}
*/