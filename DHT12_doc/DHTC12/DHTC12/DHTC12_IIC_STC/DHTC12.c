#include <STC8.H>
#include <intrins.h>
#include "DHTC12.H"




sbit SDA = P3^3;
sbit SCK = P3^2;

#define V4_I2C_ADDR 0x44
#define ACK 0
#define NACK 1

#define HDCSDA_CLR()    SDA = 0        
#define	HDCSDA_SET()  	SDA = 1
#define HDCSCK_CLR()    SCK = 0        
#define	HDCSCK_SET()  	SCK = 1
#define HDCGet_SDA()    SDA 
#define HDCSDA_Output()  	_nop_()
#define HDCSDA_Input()   SDA = 1



static u8 ACK_ret;


void Delay1us()		//@11.0592MHz
{
	unsigned char i;

	_nop_();
	_nop_();
	i = 1;
	while (--i);
}

/*
void Delay5us()		//@11.0592MHz
{
	unsigned char i;

	_nop_();
	i = 16;
	while (--i);
}
*/

void Delay10us()		//@11.0592MHz
{
	unsigned char i;

	i = 35;
	while (--i);
}


void Delay1ms()		//@11.0592MHz
{
	unsigned char i, j;

	i = 15;
	j = 90;
	do
	{
		while (--j);
	} while (--i);
}


void Delay2ms()		//@11.0592MHz
{
	unsigned char i, j;

	i = 29;
	j = 183;
	do
	{
		while (--j);
	} while (--i);
}


void start(void)
{
	HDCSDA_SET();
	Delay10us(); //IIC ?????? 0~100Hz
	HDCSCK_SET();
	Delay10us();
	HDCSDA_CLR();
	Delay10us();
	HDCSCK_CLR();
}

void stop(void)
{
	HDCSDA_CLR();
	Delay10us();
	HDCSCK_SET();
	Delay10us();
	HDCSDA_SET();
	Delay10us();
}

u8 respons(void)
{
	u8 i=0,error=0;//?????? WaitACK,?????? SDA
	//HDCSDA_Input();
	Delay10us();
	HDCSCK_SET();
	Delay10us();
	ACK_ret = 0;
	while(((HDCGet_SDA())!=0)&&i<50)i++;
	if(i>45)
	{
		error = 1;
		ACK_ret = 1;
	}
	HDCSCK_CLR();//SCK:0 ???? SDA
	Delay10us();
	HDCSDA_Output();
	return error;
}


void SendACK(u8 ack)
{
	if(ack == 0)
	{
		HDCSDA_CLR();
	}
	else
	{
		HDCSDA_SET();
	}
	Delay10us();
	HDCSCK_SET();
	Delay10us();
	HDCSCK_CLR();
	Delay10us();
	HDCSDA_SET();
}


void write_byte(u8 date)
{
	u8 i,temp;
	temp=date;
	for(i=0;i<8;i++)
	{
		HDCSCK_CLR();
	// delay(10);
		if((temp&0x80)==0x80)
		{
			HDCSDA_SET();
		}
		else
		{
			HDCSDA_CLR();
		}
		Delay10us();
		HDCSCK_SET();
		Delay10us();
		temp=temp<<1;
	}
	HDCSCK_CLR();
	Delay10us();
	// HDCSDA_SET();
	// delay(10);
}


u8 read_byte(void)
{
	u8 i,k;
	HDCSDA_SET();//? P ?????
	HDCSDA_Input();
	for(i=0;i<8;i++)
	{
		HDCSCK_SET();
		Delay10us();
		k <<= 1;
		if(HDCGet_SDA())//==0x04
			k |= 0x01;
		HDCSCK_CLR();//SCK:0 ???? SDA
		Delay10us();
	}
	HDCSDA_Output();//
	return k;
}


//¶ÁÈ¡¼Ä´æÆ÷Êý¾Ý
u16 Read_Rg(u8 AddRg)
{
	u8 errRe,ReadDatSH[3];
	u16 ReDat;
	start();
	write_byte(V4_I2C_ADDR<<1);// Add+W
	Delay1us();
	respons();
	write_byte(0xD2);//µ¥×Ö½Ú¶ÁÈ¡¼Ä´æÆ÷ Ö¸Áî D2xx
	respons();
	write_byte(AddRg);
	respons();
	Delay10us();
	start();
	write_byte(V4_I2C_ADDR<<1|0x01);// Add+R
	errRe=respons();
	//if(ACK_ret == 0)
	//{
	ReadDatSH[0] = read_byte();
	SendACK(ACK);
	ReadDatSH[1] = read_byte();
	SendACK(ACK);
	ReadDatSH[2] = read_byte();
	SendACK(NACK);
	//}
	stop();
	errRe = SHT3x_CheckCrc(ReadDatSH,2);
	if(errRe==0)
	{
		ReDat = ReadDatSH[0];
	}else
	{
		ReDat = 0xff;
	}
	return ReDat;
}

//Èí¸´Î»
void ResetMD()
{
	start();
	write_byte(V4_I2C_ADDR<<1);// Add+W
	Delay1us();
	respons();
	write_byte(0x30);
	respons();
	write_byte(0xA2);
	respons();
	stop();
}



static u16 HumA,HumB;


void DHTC12_MInit()
{
	ResetMD();
	Delay10us(); //10us »òÕß²»ÓÃ
	HumA = Read_Rg(8);
	HumA = (HumA<<8)|Read_Rg(9);
	HumB = Read_Rg(10);
	HumB = (HumB<<8)|Read_Rg(11);
}



//µ¥´Î´¥·¢ÎÂÊª¶È²âÁ¿
u8 ReadDHTC12_M(s16 *tem,u16 *Hum)
{
	u8 i,errRe,ReadDatSH[6],CalCRC[3],errorflag;
	s16 TemBuf;
	long CapBuf;//s32
	start();
	write_byte(V4_I2C_ADDR<<1);// Add+W
	Delay1us();
	respons();
	write_byte(0x2c);//µ¥×Ö½Ú¶ÁÈ¡¼Ä´æÆ÷  Ö¸Áî D2xx
	respons();
	write_byte(0x10);
	respons();
	stop();
	Delay2ms();//2ms SCL¿ÕÏÐ×îÉÐ¡ 1ms
	for(i=0;i<50;i++)//²éÑ¯5´Î¿´²âÍê½á¹û
	{
		Delay1ms();//1ms
		Delay1ms();
		Delay1ms();
		start();
		write_byte(V4_I2C_ADDR<<1|0x01);// Add+R
		errRe=respons();
			if(errRe ==0)
		break;//²âÁ¿Íê³É
		else
		stop();
	}
	if(errRe == 0)
	{
		ReadDatSH[0] = read_byte();
		SendACK(ACK);
		ReadDatSH[1] = read_byte();
		SendACK(ACK);
		ReadDatSH[2] = read_byte();
		SendACK(ACK);
		ReadDatSH[3] = read_byte();
		SendACK(ACK);
		ReadDatSH[4] = read_byte();
		SendACK(ACK);
		ReadDatSH[5] = read_byte();
		SendACK(NACK);
		stop();
	}
	CalCRC[0] = ReadDatSH[0];
	CalCRC[1] = ReadDatSH[1];
	CalCRC[2] = ReadDatSH[2];
	errorflag = SHT3x_CheckCrc(CalCRC,2);
	if(errorflag==0)
	{
		TemBuf = (u16)ReadDatSH[0]<<8|(ReadDatSH[1]);
		TemBuf = 400+TemBuf/25.6;//*10 ½á¹û*10±¶ 286 ¼´ 28.6¡æ
		*tem = TemBuf;
	}
	CalCRC[0] = ReadDatSH[3];
	CalCRC[1] = ReadDatSH[4];
	CalCRC[2] = ReadDatSH[5];
	errorflag |= SHT3x_CheckCrc(CalCRC,2);
	if(errorflag==0)
	{
	CapBuf = (u16)ReadDatSH[3]<<8|(ReadDatSH[4]);
	CapBuf = (CapBuf-HumB)*600/(HumA-HumB)+300;
	//20¡æÎª5¸öÊª¶Èµã  ¼´1¡æÎª0.25¸öÊª¶Èµã  0.1¡æÎª0.025
	CapBuf = CapBuf+ 25*(TemBuf-250)/100;
	if(CapBuf>1000)
		CapBuf = 999;
	else if(CapBuf<0)
		CapBuf = 0;
	*Hum = (u16)CapBuf;//Í¬Ñù½á¹û*10
	}
	return errorflag;	
}

const u16 POLYNOMIAL = 0x131; //P(x)=x^8+x^5+x^4+1 = 100110001

u8 SHT3x_CheckCrc(u8 Data[], u8 nbrOfBytes) //¸úSHT30Ò»ÑùÖ»ÊÇ½«CRCÖµµ¹»Øµ½Dataºó·µ»Ø
//==============================================================================
{
	u8 crc = 0xff; //0
	u8 byteCtr,Bit;
	//calculates 8-Bit checksum with given polynomial
	for (byteCtr = 0; byteCtr < nbrOfBytes; ++byteCtr)
	{ crc ^= (Data[byteCtr]);
		for (Bit = 8; Bit > 0; --Bit)
		{ if (crc & 0x80) crc = (crc << 1) ^ POLYNOMIAL;
		else crc = (crc << 1);
		}
	}
	if (crc != Data[nbrOfBytes])
	{
	Data[nbrOfBytes] = crc;
	return 0x01;
	}
	else return 0;
}





