#include "def.h"
#include "HeadAl.h"

void DelaySus(uchar n)
{
    while (n--)
    {
			_asm("nop");
      _asm("nop");
    }
}

void DQ_Rst(void)
{
		HDCSDA_Output();
    DelaySus(2);    //5us 无需严格要求
    HDCSDA_CLR();
   	delay(114);  //>480us 典型值960us  规格书：tRSTL
    HDCSDA_SET();
    DelaySus(7);  //8us  无需严格要求
}

//应答 DQ_Rst 低电平释放后，模块会有一个 tPDLOW的应答信号
u8  DQ_Presence(void)
{
    u8 pulse_time = 0;
		HDCSDA_Input();
    DelaySus(2); //5us 无需严格要求
    while( (HDCGet_SDA()) && pulse_time<100 )   //存在检测高电平15~60us 模块响应高电平时间  tPDHIGH 规格书：
    {
        pulse_time++;
        DelaySus(5);//>6us
    }
    if( pulse_time >=20 )
        return 0x01;
    else
        pulse_time = 0;//应答正常

    while((HDCGet_SDA()==0) && pulse_time<240 ) //存在检测低电平时间60~240us  tPDLOW
    {
        pulse_time++;
        DelaySus(2);//1~5us
    }
    if( pulse_time >=10 )// 应答正常
		{
       		return 0x01;
		}
    else
        return 0x0;
}


//拉低最少1us 后延时一小段时间如6us，后再15us内读取完。 后延时45us以上 即一个周期是60us 
//tINIT+tRC+tSample < 15us
//tINIT+tRC+tSample+tDelay>60us
u8 DQ_Read_Bit(void)
{
    u8 dat;
	
		HDCSDA_Output();
		
    HDCSDA_CLR();
    DelaySus(2); //tINIT>1us 典型5us <15us  
 //   HDCSDA_SET();
		HDCSDA_Input();
    DelaySus(5);//tRC  典型5us 
    if(HDCGet_SDA())//tSample
        dat = 1;
    else
        dat = 0;
    DelaySus(33);//tDelay >60us 确保一帧数据传输完毕
    return dat;
}

u8 DQ_Read_Byte(void)
{
    u8 i, j, dat = 0;

    for(i=0; i<8; i++)
    {
        j = DQ_Read_Bit();
        dat = (dat) | (j<<i);
    }
    return dat;
}

void DQ_Write_Bit(u8 bit)
{
    uint8_t testb;
    testb = bit&0x01;
		HDCSDA_Output();
    if(testb)//写1
    {
        HDCSDA_CLR();
        DelaySus(3);//>1us  <15us
				HDCSDA_SET();
        DelaySus(33);//>=60us
    }
    else//写0
    {
        HDCSDA_CLR();
        DelaySus(38);//>=60us
				HDCSDA_SET();
        DelaySus(3);//典型5us
    }
}

void  DQ_Write_Byte(uint8_t dat)
{
    uint8_t i, testb;
		HDCSDA_Output();
    for( i=0; i<8; i++ )
    {
        testb = dat&0x01;
        dat = dat>>1;
       if(testb)//写1
			 {
					HDCSDA_CLR();
					DelaySus(3);//>1us  <15us
					HDCSDA_SET();
					DelaySus(33);//>=60us
			 }
			 else//写0
			 {
					HDCSDA_CLR();
					DelaySus(38);//MY_DELAY_US(70);>60us
					HDCSDA_SET();
					DelaySus(3);//典型5us
			 }
    }
}
u8 CRC8MHT_Cal(u8 *serial, u8 length) 
{
    u8 result = 0x00;
    u8 pDataBuf;
    u8 i;

    while(length--) {
        pDataBuf = *serial++;
        for(i=0; i<8; i++) {
            if((result^(pDataBuf))&0x01){
                result ^= 0x18;
                result >>= 1;
                result |= 0x80;
            }
            else {
                result >>= 1;
            }
            pDataBuf >>= 1;
        }
    }
    return result;
}

static u16 OwHumA,OwHumB;

void DHTC11Init_OW(void)
{
	uint8_t i,crc;
	u8 ResDat[13];
	
Timer4Stop();	//暂停有可能打断通信的中断
	DQ_Rst();
	DQ_Presence();
  DQ_Write_Byte(0xcc);
	DQ_Write_Byte(0xdd);
	
	OwHumA = DQ_Read_Byte();
	OwHumA = (OwHumA<<8)|DQ_Read_Byte();
	OwHumB = DQ_Read_Byte();
	OwHumB = (OwHumB<<8)|DQ_Read_Byte();
	
Timer4Start();	

//当读取满一组数据即12个字节后，才有CRC值
//无需要时可以按上面读取前面4个即可
/*
	for(i=0;i<13;i++)
	{
		ResDat[i] = DQ_Read_Byte();
	}
	crc = CRC8MHT_Cal(ResDat,13);
	if(crc == 0)
	{
		OwHumA = ResDat[0];
		OwHumA = (OwHumA<<8)|ResDat[1];
		OwHumB = ResDat[2];
		OwHumB = (OwHumB<<8)|ResDat[3];
	}
	*/
}


u8 DHTC11_onewire(s16 *tem,u16 *hum)
{
	u8 ResDat[5],crc=0,ReBit;
	u16 i;
	s16 TemBuf;
	long CapBuf;//s32

Timer4Stop();//单总线通讯 暂停中断
		DQ_Rst();
		DQ_Presence();
		DQ_Write_Byte(0xcc);
		DQ_Write_Byte(0x10);
Timer4Start();		
		              //可以不延时直接读取，但读取到的是上次转化的数据
		delay(7075);//2ms*15  35ms  改时间可以去处理其他任务回来读取
		
Timer4Stop();		
		DQ_Rst();
		DQ_Presence();
		DQ_Write_Byte(0xcc);
		DQ_Write_Byte(0xbd);
		ResDat[0] = DQ_Read_Byte();
		ResDat[1] = DQ_Read_Byte();
		ResDat[2] = DQ_Read_Byte();
		ResDat[3] = DQ_Read_Byte();
		ResDat[4] = DQ_Read_Byte();
		
		
Timer4Start();
		crc = CRC8MHT_Cal(ResDat,5);
		if(crc == 0)
		{
			TemBuf = (u16)ResDat[1]<<8|(ResDat[0]);
			TemBuf = 400+TemBuf/25.6;//*10 结果*10倍 286即28.6℃
			*tem = TemBuf;
			
		 CapBuf = (u16)ResDat[3]<<8|(ResDat[2]);
		 CapBuf = (CapBuf-OwHumB)*600/(OwHumA-OwHumB)+300;//同样结果*10
		 	//20℃为5个湿度点  即1℃为0.25个湿度点 0.1℃ 为0.025
		 CapBuf = CapBuf+ 25*(TemBuf-250)/100;	
		 
		 if(CapBuf>999)CapBuf = 999;
		 else if(CapBuf<0)CapBuf=0;
			*hum = (u16)CapBuf;
		}
		
	return crc;
}

