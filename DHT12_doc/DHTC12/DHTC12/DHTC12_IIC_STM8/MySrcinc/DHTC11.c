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
    DelaySus(2);    //5us �����ϸ�Ҫ��
    HDCSDA_CLR();
   	delay(114);  //>480us ����ֵ960us  ����飺tRSTL
    HDCSDA_SET();
    DelaySus(7);  //8us  �����ϸ�Ҫ��
}

//Ӧ�� DQ_Rst �͵�ƽ�ͷź�ģ�����һ�� tPDLOW��Ӧ���ź�
u8  DQ_Presence(void)
{
    u8 pulse_time = 0;
		HDCSDA_Input();
    DelaySus(2); //5us �����ϸ�Ҫ��
    while( (HDCGet_SDA()) && pulse_time<100 )   //���ڼ��ߵ�ƽ15~60us ģ����Ӧ�ߵ�ƽʱ��  tPDHIGH ����飺
    {
        pulse_time++;
        DelaySus(5);//>6us
    }
    if( pulse_time >=20 )
        return 0x01;
    else
        pulse_time = 0;//Ӧ������

    while((HDCGet_SDA()==0) && pulse_time<240 ) //���ڼ��͵�ƽʱ��60~240us  tPDLOW
    {
        pulse_time++;
        DelaySus(2);//1~5us
    }
    if( pulse_time >=10 )// Ӧ������
		{
       		return 0x01;
		}
    else
        return 0x0;
}


//��������1us ����ʱһС��ʱ����6us������15us�ڶ�ȡ�ꡣ ����ʱ45us���� ��һ��������60us 
//tINIT+tRC+tSample < 15us
//tINIT+tRC+tSample+tDelay>60us
u8 DQ_Read_Bit(void)
{
    u8 dat;
	
		HDCSDA_Output();
		
    HDCSDA_CLR();
    DelaySus(2); //tINIT>1us ����5us <15us  
 //   HDCSDA_SET();
		HDCSDA_Input();
    DelaySus(5);//tRC  ����5us 
    if(HDCGet_SDA())//tSample
        dat = 1;
    else
        dat = 0;
    DelaySus(33);//tDelay >60us ȷ��һ֡���ݴ������
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
    if(testb)//д1
    {
        HDCSDA_CLR();
        DelaySus(3);//>1us  <15us
				HDCSDA_SET();
        DelaySus(33);//>=60us
    }
    else//д0
    {
        HDCSDA_CLR();
        DelaySus(38);//>=60us
				HDCSDA_SET();
        DelaySus(3);//����5us
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
       if(testb)//д1
			 {
					HDCSDA_CLR();
					DelaySus(3);//>1us  <15us
					HDCSDA_SET();
					DelaySus(33);//>=60us
			 }
			 else//д0
			 {
					HDCSDA_CLR();
					DelaySus(38);//MY_DELAY_US(70);>60us
					HDCSDA_SET();
					DelaySus(3);//����5us
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
	
Timer4Stop();	//��ͣ�п��ܴ��ͨ�ŵ��ж�
	DQ_Rst();
	DQ_Presence();
  DQ_Write_Byte(0xcc);
	DQ_Write_Byte(0xdd);
	
	OwHumA = DQ_Read_Byte();
	OwHumA = (OwHumA<<8)|DQ_Read_Byte();
	OwHumB = DQ_Read_Byte();
	OwHumB = (OwHumB<<8)|DQ_Read_Byte();
	
Timer4Start();	

//����ȡ��һ�����ݼ�12���ֽں󣬲���CRCֵ
//����Ҫʱ���԰������ȡǰ��4������
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

Timer4Stop();//������ͨѶ ��ͣ�ж�
		DQ_Rst();
		DQ_Presence();
		DQ_Write_Byte(0xcc);
		DQ_Write_Byte(0x10);
Timer4Start();		
		              //���Բ���ʱֱ�Ӷ�ȡ������ȡ�������ϴ�ת��������
		delay(7075);//2ms*15  35ms  ��ʱ�����ȥ�����������������ȡ
		
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
			TemBuf = 400+TemBuf/25.6;//*10 ���*10�� 286��28.6��
			*tem = TemBuf;
			
		 CapBuf = (u16)ResDat[3]<<8|(ResDat[2]);
		 CapBuf = (CapBuf-OwHumB)*600/(OwHumA-OwHumB)+300;//ͬ�����*10
		 	//20��Ϊ5��ʪ�ȵ�  ��1��Ϊ0.25��ʪ�ȵ� 0.1�� Ϊ0.025
		 CapBuf = CapBuf+ 25*(TemBuf-250)/100;	
		 
		 if(CapBuf>999)CapBuf = 999;
		 else if(CapBuf<0)CapBuf=0;
			*hum = (u16)CapBuf;
		}
		
	return crc;
}

