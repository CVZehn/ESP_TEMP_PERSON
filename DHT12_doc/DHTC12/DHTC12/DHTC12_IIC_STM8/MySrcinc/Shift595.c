#include"def.h"
#include"shift595.h"
//#define WriteLCD     0
//#define WriteRelay   1

//static void WR_595(uchar k);
//static void OUT595Relay(void);
static void OUT595LCD(void);

//static u8 ShifLCDData = 0x0f;//初始化让背光灯灭
//static u8 ShifRelayData = 0x00;
//-Relay8---Ry7---Ry6--Ry5--Ry4--Ry3--Ry2--Ry1---XX---XX---BKR--BKB--CS--RD--Dat--WR
//TemGND--TemVCC--Bo6--Bo5--Bo4--Bo3--Bo2--Bo1---空---空--背光-------

//操作LCD，只操作单个LCD口
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
/*写数据到74HC595函数*/
void WR_595(u8 ShifLCDData)//写入到LCD还是继电器
{
	u8 count1,Buf;

	Buf = (u8)ShifLCDData;

	for(count1=0;count1<8;count1++)
	{
		if((Buf&0x80)==0x80)  /*最高位为1，则向SDATA_595发送1*/
		{
			ShifSER_SET();
		}/*发出数据的最高位*/
		else 
		{			
			ShifSER_CLR();
		}
		Buf<<=1;    /*右移位*/
		
		ShifSCLK_CLR();
		_asm("nop");
		_asm("nop");
//			_asm("nop");
//			_asm("nop");
		ShifSCLK_SET();
	} 
	OUT595LCD();
}

/*更新74HC595输出数据函数void  Out_595(void）*/
static void OUT595LCD(void)
{
	ShifLCDRCK_CLR();
	  _asm("nop");
		_asm("nop");
//		_asm("nop");
//		_asm("nop");
	ShifLCDRCK_SET();  /*上升沿锁存数据*/
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
	ShifRelayRCK_SET();  //上升沿锁存数据
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
void LCDLED_OP(u8 bdat)//同时操作两个背光灯
{
	ShifLCDData &= 0xcf;
	ShifLCDData |= bdat<<4;
	WR_595(WriteLCD);
}
*/