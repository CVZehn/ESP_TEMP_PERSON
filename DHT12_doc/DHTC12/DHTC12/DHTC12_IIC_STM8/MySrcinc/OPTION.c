#include "def.h"
#include "HeadAl.h"

void OPTIONBYTE(void)
{
	unsigned char i,a,b;
  a = *((unsigned char*)0x4803);
	b = *((unsigned char*)0x4804);
	if((a != 0x01)||(b != 0xfe)) //���û�ж��������޸�
	{
		do{
			while((FLASH->IAPSR&0x08) == 0x00)//���Ƿ���д����
			{
				FLASH->DUKR = 0xAE;
				FLASH->DUKR = 0x56;
			}
			FLASH->CR1 = 0x0;//��ѯ��ʽ
			FLASH->CR2 = 0x80;//����ѡ���ֱ��
			FLASH->NCR2 = 0x7F;
			//��ʼ���
			//onebyte AFR�ڶ����ܽ�
			*((unsigned char*)0x4803) = 0x01;
			*((unsigned char*)0x4804) = 0xfe;
			while((FLASH->IAPSR&0x04)==0);//EOP�鿴�������
			FLASH->IAPSR &=0xfb;//���������־
			
			a = *((unsigned char*)0x4803);
			b = *((unsigned char*)0x4804);
			b = ~b;
		}while(a!=b);
		//onebyte
//	p = (unsigned char *)0x4800;//OPTION��ַ ǿ��ת����8λ��ַ
//	*p = 0xAA;

	//	*((unsigned char*)0x4800) = 0xaa;//����
	//   while((FLASH_IAPSR&0x04)==0);//EOP�鿴�������
	//   FLASH_IAPSR &=0xfb;//���������־
	
		FLASH->IAPSR = FLASH->IAPSR&0xf7;//DUL��������д����
		FLASH->CR2 = 0x00;
		FLASH->NCR2 = 0xFF;
		
	}
}/*
void OPTIONBYTE(void)
{
	unsigned char a;
	a = *((unsigned char*)0x4800);//���� protect
	if(a != 0xaa)
	{
		while((FLASH->IAPSR&0x08) == 0x00)//���Ƿ���д����
		{
			FLASH->DUKR = 0xAE;
			FLASH->DUKR = 0x56;
		}
		FLASH->CR1 = 0x0;//��ѯ��ʽ
		FLASH->CR2 = 0x80;//����ѡ���ֱ��
		FLASH->NCR2 = 0x7F;
		*((unsigned char*)0x4800) = 0xaa;
		while((FLASH->IAPSR&0x04)==0);//EOP�鿴�������
		FLASH->IAPSR &=0xfb;//���������־
		FLASH->IAPSR = FLASH->IAPSR&0xf7;//DUL��������д����
		FLASH->CR2 = 0x00;
		FLASH->NCR2 = 0xFF;
	}
}
*/