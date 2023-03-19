#include "DHTC12.h"
#include "delay.h"


static u8 ACK_ret;

//PC8  SDA
//PC9  SCK
void IICIO_Init(void)
{
 
 GPIO_InitTypeDef  GPIO_InitStructure;
 	
 RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOC, ENABLE);	 //ʹ��PC�˿�ʱ��
	
 GPIO_InitStructure.GPIO_Pin = GPIO_Pin_8;				 
 GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_OD; 		 //
 GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;		 //IO���ٶ�Ϊ50MHz
 GPIO_Init(GPIOC, &GPIO_InitStructure);					 //�����趨������ʼ��GPIOA.8
 GPIO_SetBits(GPIOC,GPIO_Pin_8);						 //PA.8 �����

 GPIO_InitStructure.GPIO_Pin = GPIO_Pin_9;	    		 //SCK-->PC.9 �˿�����, �������
 GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP; 		 //
 GPIO_Init(GPIOC, &GPIO_InitStructure);	  				 //������� ��IO���ٶ�Ϊ50MHz
 GPIO_SetBits(GPIOC,GPIO_Pin_9); 						 //PD.2 ����� 

  HDCSDA_Output();
	 HDCSDA_SET();
}



void start(void){
	HDCSDA_SET();
		delay_us(10);
	HDCSCL_SET();
		delay_us(10);
	HDCSDA_CLR();
		delay_us(10);
	HDCSCL_CLR();
}
void stop(void){
	HDCSDA_CLR();
		delay_us(10);
	HDCSCL_SET();
		delay_us(10);
	HDCSDA_SET();
		delay_us(10);
}
u8 respons(void)
{
	u8 i=0,errorF=0;//д��������WaitACK�����п��Ըı�SDA
	HDCSDA_Input();//???????????????/
	delay_us(10);
	HDCSCL_SET();
		delay_us(10);
	ACK_ret = 0;		
	while(((HDCGet_SDA())!=0)&&i<50)i++;
	if(i>45) 
	{
	  errorF = 1;
		ACK_ret = 1;
	}
	HDCSCL_CLR();//SCK:0���Ըı�SDA
		delay_us(10);
	HDCSDA_Output();//???????????????/
	
	return (u8)errorF;

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
    delay_us(10);        
    HDCSCL_SET();                    
     delay_us(10); 
		HDCSCL_CLR();                    
     delay_us(10); 
	  HDCSDA_SET();
}

void write_byte(u8 date){
	u8 i,temp;
	temp=date;
	for(i=0;i<8;i++)
	{
		HDCSCL_CLR();
//	delay_us(10);
		if((temp&0x80)==0x80)
			{HDCSDA_SET();}else{HDCSDA_CLR();}
			delay_us(10);
		HDCSCL_SET();
			delay_us(10);
		temp=temp<<1;
	}
	HDCSCL_CLR();
	delay_us(10);
//	HDCSDA_SET();
//	delay_us(10);
}

u8 read_byte(void){
	u8 i,k;
	HDCSDA_SET();//��P��׼������
	HDCSDA_Input();
	for(i=0;i<8;i++)
	{
		HDCSCL_SET();
			delay_us(10);
		k <<= 1;
		if(HDCGet_SDA())//==0x04
			k |= 0x01;
		HDCSCL_CLR();//SCK:0���Ըı�SDA
			delay_us(10);
	}
	HDCSDA_Output();//
  return k;
}

const u16 POLYNOMIAL = 0x131;  //P(x)=x^8+x^5+x^4+1 = 100110001
//==============================================================================
u8 SHT3x_CheckCrc(u8 data[], u8 nbrOfBytes)  //��SHT30һ��ֻ�ǽ�CRCֵ���ᵽdata�󷵻�
//==============================================================================
{
  u8 crc = 0xff;	//0
  u8 byteCtr,bit;
  //calculates 8-Bit checksum with given polynomial
  for (byteCtr = 0; byteCtr < nbrOfBytes; ++byteCtr)
  { crc ^= (data[byteCtr]);
    for (bit = 8; bit > 0; --bit)
    { if (crc & 0x80) crc = (crc << 1) ^ POLYNOMIAL;
      else crc = (crc << 1);
    }
  }
  if (crc != data[nbrOfBytes]) 
	{
		data[nbrOfBytes] = crc;
		return 0x01;
	}
  else return 0;
}


#define V4_I2C_ADDR  0x44  /* Addr ���Žӵ͵�ƽ*/
//��λ
void ResetMD(void)
{
	start();
	write_byte(V4_I2C_ADDR<<1);// Add+W
	delay_us(1);
	respons();
	write_byte(0x30);
	respons();
	write_byte(0xA2);
	respons();
	stop();
}
//��ȡ�Ĵ�������
u16 Read_Rg(u8 AddRg)
{
	u8 errRe,ReadDatSH[3];
	u16 ReDat;
	
	start();
	write_byte(V4_I2C_ADDR<<1);// Add+W
	delay_us(1);
	respons();
	write_byte(0xD2);//���ֽڶ�ȡ�Ĵ��� ָ��D2xx 
	respons();
	write_byte(AddRg);
	respons();
	
	delay_us(10);
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

/*
//д�Ĵ�������
void Write_Rg(u8 AddRg,u8 datab)
{
	u8 WiteDatSH[3];
	
	WiteDatSH[0] = datab;
	WiteDatSH[1] = 0xff;
	SHT3x_CheckCrc(WiteDatSH,2);
	
	start();
	write_byte(V4_I2C_ADDR<<1);// Add+W
	delay_us(1);
	respons();
	write_byte(0x52);//���ֽڶ�ȡ�Ĵ��� ָ��D2xx 
	respons();
	write_byte(AddRg);
	respons();
	write_byte(WiteDatSH[0]);
	respons();
	write_byte(WiteDatSH[1]);
	respons();
	write_byte(WiteDatSH[2]);//crc
	respons();
	stop();
}*/

static u16 HumA,HumB;

void DHTC12_MInit(void)
{	
	ResetMD();
	delay_us(10);
	HumA = Read_Rg(8);
	HumA = (HumA<<8)|Read_Rg(9);
	HumB = Read_Rg(10);
	HumB = (HumB<<8)|Read_Rg(11);
}

//���δ�����ֵ���¶Ȳ��� 
//���δ�����ʪ�Ȳ���
u8 ReadDHTC12_M(s16 *tem,u16 *Hum)
{
	u8 i,errRe,ReadDatSH[6],CalCRC[3],errorflag;
	s16 TemBuf;
	s32 CapBuf;//s32
	start();
	write_byte(V4_I2C_ADDR<<1);// Add+W
	delay_us(1);
	respons();
	write_byte(0x2c);//���ֽڶ�ȡ�Ĵ���  ָ�� D2xx
	respons();
	write_byte(0x10);
	respons();
	stop();
	delay_ms(2);//2ms SCL��������?1ms
	for(i=0;i<50;i++)//��ѯ5�ο�������
	{
		delay_ms(4);//1ms
	
		start();
		write_byte(V4_I2C_ADDR<<1|0x01);// Add+R
		errRe=respons();
			if(errRe ==0)
		break;//�������
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
		TemBuf = 400+TemBuf/25.6;//*10 ���*10�� 286 �� 28.6��
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
	//20��Ϊ5��ʪ�ȵ�  ��1��Ϊ0.25��ʪ�ȵ�  0.1��Ϊ0.025
	CapBuf = CapBuf+ 25*(TemBuf-250)/100;
	if(CapBuf>1000)
		CapBuf = 999;
	else if(CapBuf<0)
		CapBuf = 0;
	*Hum = (u16)CapBuf;//ͬ�����*10
	}
	return errorflag;	
}
