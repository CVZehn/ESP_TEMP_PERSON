#include"def.h"
#include"shift595.h"
//#define WriteLCD     0
//#define WriteRelay   1

//static void WR_595(uchar k);
//static void OUT595Relay(void);
static void OUT595LCD(void);

//static u8 ShifLCDData = 0x0f;//��ʼ���ñ������
//static u8 ShifRelayData = 0x00;
//-Relay8---Ry7---Ry6--Ry5--Ry4--Ry3--Ry2--Ry1---XX---XX---BKR--BKB--CS--RD--Dat--WR
//TemGND--TemVCC--Bo6--Bo5--Bo4--Bo3--Bo2--Bo1---��---��--����-------

//����LCD��ֻ��������LCD��
/*void WriteLCDOP(u8 bddat,u8 num)
{
	CLR_Bit(ShifLCDData,num);
	ShifLCDData |= bddat<<num;
	WR_595(WriteLCD);
}
void Write595Relay(u8 bddat,u8 num)
{
	CLR_Bit(ShifRelayData,num);
	ShifRelayData |= bddat<<num;
	WR_595(WriteRelay);
}*/
//=====================================================
/*д���ݵ�74HC595����*/
void WR_595(u8 ShifLCDData)//д�뵽LCD���Ǽ̵���
{
	u8 count1,Buf;

	Buf = (u8)ShifLCDData;

	for(count1=0;count1<8;count1++)
	{
		if((Buf&0x80)==0x80)  /*���λΪ1������SDATA_595����1*/
		{
			ShifSER_SET();
		}/*�������ݵ����λ*/
		else 
		{			
			ShifSER_CLR();
		}
		Buf<<=1;    /*����λ*/
		
		ShifSCLK_CLR();
		_asm("nop");
		_asm("nop");
//			_asm("nop");
//			_asm("nop");
		ShifSCLK_SET();
	} 
	OUT595LCD();
}

/*����74HC595������ݺ���void  Out_595(void��*/
static void OUT595LCD(void)
{
	ShifLCDRCK_CLR();
	  _asm("nop");
		_asm("nop");
//		_asm("nop");
//		_asm("nop");
	ShifLCDRCK_SET();  /*��������������*/
		_asm("nop");
		_asm("nop");
	ShifLCDRCK_CLR();
}
/*
static void OUT595Relay(void)
{
	ShifRelayRCK_CLR();
	  _asm("nop");
		_asm("nop");
		_asm("nop");
		_asm("nop");
	ShifRelayRCK_SET();  //��������������
	  _asm("nop");
		_asm("nop");
		_asm("nop");
		_asm("nop");
		ShifRelayRCK_CLR();
}*/
/*
static void ReadNextNum(void)
{
	SET_595SDI();
	CLR_595SCK();
		_asm("nop");
		_asm("nop");
		_asm("nop");
		_asm("nop");
	SET_595SCK();
	OUT595();
}
void LcdCS_OP(u8 bdat)
{
	ShifLCDData &= 0xf7;
	ShifLCDData |= bdat<<3;
	WR_595(WriteLCD);
}
void LcdWR_OP(u8 bdat)
{
	ShifLCDData &= 0xfe;
	ShifLCDData |= bdat;
	WR_595(WriteLCD);
}
void LcdDATA_OP(u8 bdat)
{
	ShifLCDData &= 0xfd;
	ShifLCDData |= bdat<<1;
	WR_595(WriteLCD);
}
void LCDLED_OP(u8 bdat)//ͬʱ�������������
{
	ShifLCDData &= 0xcf;
	ShifLCDData |= bdat<<4;
	WR_595(WriteLCD);
}
*/