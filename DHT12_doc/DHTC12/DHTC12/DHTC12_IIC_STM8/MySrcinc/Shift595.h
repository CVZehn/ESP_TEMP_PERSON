#ifndef _SHIFT595_H_
#define _SHIFT595_H_

//-Relay8---Ry7---Ry6--Ry5--Ry4--Ry3--Ry2--Ry1---XX---XX---BKR--BKB--CS--RD--Dat--WR
//TemGND--TemVCC--Bo6--Bo5--Bo4--Bo3--Bo2--Bo1---空---空--背光-------
/*typedef enum{
	LCD_BKBNum = (u8)5,
	LCD_BKRNum = (u8)4,
	LCD_CSNum = (u8)3,
	LCD_RDNum = (u8)2,
	LCD_DatNum = (u8)1,
	LCD_WRNum = (u8)0	
}ShiftLCDNum;

void WriteLCDOP(u8 bddat,u8 num);

#define LcdBKR_OPH()	WriteLCDOP(1,LCD_BKRNum)
#define LcdBKR_OPL()	WriteLCDOP(0,LCD_BKRNum)
#define LcdBKB_OPH()	WriteLCDOP(1,LCD_BKBNum)
#define LcdBKB_OPL()  WriteLCDOP(0,LCD_BKBNum)
#define LcdCS_OPH()   WriteLCDOP(1,LCD_CSNum) 
#define LcdCS_OPL()		WriteLCDOP(0,LCD_CSNum) 
#define LcdWR_OPH()		WriteLCDOP(1,LCD_WRNum)
#define LcdWR_OPL()		 WriteLCDOP(0,LCD_WRNum)
#define LcdDATA_OPH()	 WriteLCDOP(1,LCD_DatNum)
#define LcdDATA_OPL()	 WriteLCDOP(0,LCD_DatNum)

//继电器工作选择  初步是使用2TY三极管驱动Relay，后续由于595  上电初始化为输出为低电平改用1AM
#define RPowerON 		1
#define RPowerOFF 	0
typedef enum{
	TemLinkVCC	= (u8)7,
	TemLinkGND  = (u8)6,
	Board6Power = (u8)5,
	Board5Power = (u8)4,
	Board4Power = (u8)3,
	Board3Power = (u8)2,
	Board2Power = (u8)1,
	Board1Power = (u8)0	
}ShiftRelayNum;
//TemLinkVCC 热敏链接VCC所以继电器连接到GND
void Write595Relay(u8 bddat,u8 num);*/

#define ShifSER_SET() 					HC595_SER_SET()
#define ShifSER_CLR()						HC595_SER_CLR()
#define ShifSCLK_CLR()					HC595_SCLK_SET()
#define ShifSCLK_SET()					HC595_SCLK_CLR()
#define ShifLCDRCK_CLR()				HC595_RCLK_CLR()
#define ShifLCDRCK_SET()				HC595_RCLK_SET()

void WR_595(u8 ShifLCDData);
#endif
