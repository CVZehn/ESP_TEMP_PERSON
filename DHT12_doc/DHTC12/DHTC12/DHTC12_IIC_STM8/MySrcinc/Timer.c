#include "def.h"
#include "HeadAl.h"
#include "shift595.h"
//CaculatorCat CaputureSt;
//u16 debugvoltage=0xf000;

/*
_Bool flag;

void TimerInit(void)
{
	//Timer1做计数器
	TIM1->CCMR2 = 0x41;//采样4次做一判断 通道2被映射到TI2FP2上
	TIM1->CCER1 = 0;//上升沿
	TIM1->SMCR = 0x67;//滤波后的定时器输入2(TI2FP2),外部时钟触  发1模式 得到CK->PSC
	TIM1->ARRH = 0xff;
	TIM1->ARRL = 0xff;//自动重装载值
	TIM1->RCR = 0x00;//重复计数值，也就是当溢出0次后才做更新
	TIM1->EGR = 0x01;//产生UG更新PSCR、ARR
	TIM1->SR1 = 0;//清除更新标志
	TIM1->CR1 = 0x02;//禁止更新UDIS
	TIM1->CR1 &= 0XFE; //禁止启动
	
	//Timer2做定时器
	TIM2->IER = 0X00;//禁止中断
	TIM2->PSCR = 0X9;//分频 Master/2^n 15625HZ
	TIM2->ARRH = 0x30;//0.8S//1s-0x3d;
	TIM2->ARRL = 0xd4;      //---0x09;
//	TIM2->RCR = 0x00;//重复计数值，也就是当溢出0次后才做更新
	TIM2->CNTRL = 0;
	TIM2->CNTRH = 0;
	//TIM2->CR1 = 0X01;//启动
	TIM2->EGR = 0x01;//产生UG更新PSCR、ARR
	TIM2->SR1 = 0;//清除更新标志
	TIM2->IER = 0x01;//允许中断
	
}*/
/*****************************************************
*Timer2 PWM输出
*        -----       -----            --    --
*       |     |     |     |          |  |  |  |
*   ----       -----       ----   ---    --    --
*  相比之下，后面的输出波形全量程纹波会小很多
*  也就是频率要越快越好
*  单周期的点数越多越好，也就是ARR最大65535，分辨率达到最大
*  当系统分配时钟达到最大，而输出频率纹波还是很大，为了减少输出纹波，
*  只能通过调节ARR来提高输出频率
*  Fmaster=8MHz
*  分辨率040对应0-100%RH。湿度分辨率为0.1%RH，也就是电压:0.004V
*  运放放大倍数为1.5倍左右，参考excel文档    
****************************************************
void Timer2PWM(void)
{
	TIM2->IER = 0X00;//禁止中断
	//TIM2->PSCR = 0X9;
	TIM2->CCMR1 = 0x68;//输出 PWM模式1. <CCR1为有效电平
	TIM2->CCER1 = 0x01;//开启对应管脚输出，高电平有效
		
	TIM2->CCMR2 = 0x68;//Channel2 开启了预装载，但效果还是不行，跟新数据时输出依旧有抖动
	TIM2->CCER1 |= 0x10;
	
	TIM2->ARRH = 0x7;//2000
	TIM2->ARRL = 0xd0;
//	TIM2->RCR = 0x00;
	TIM2->CNTRL = 0;
	TIM2->CNTRH = 0;
	TIM2->CCR1H = 0x3;
	TIM2->CCR1L = 0xe8;
	//Channel2
	TIM2->CCR2H = 0x3;
	TIM2->CCR2L = 0xe8;
	//TIM2->CR1 |= (uint8_t)TIM2_CR1_ARPE;
	TIM2->CR1 |= (uint8_t)TIM2_CR1_CEN;
}*/
/*****************************************************
*Timer1 ，为计数
*****************************************************
void Timer1CaculaInit(void)
{
		//Timer1做计数器
	TIM1->CCMR2 = 0x41;//采样4次做一判断 通道2被映射到TI2FP2上
	TIM1->CCER1 = 0;//上升沿
	TIM1->SMCR = 0x67;//滤波后的定时器输入2(TI2FP2),外部时钟触  发1模式 得到CK->PSC
	TIM1->ARRH = 0xff;
	TIM1->ARRL = 0xff;//自动重装载值
	TIM1->RCR = 0x00;//重复计数值，也就是当溢出0次后才做更新
	TIM1->EGR = 0x01;//产生UG更新PSCR、ARR
	TIM1->SR1 = 0;//清除更新标志
	TIM1->CR1 = 0x02;//禁止更新UDIS
	TIM1->CR1 &= 0XFE; //禁止启动
}*/
/*****************************************************
*Timer4：用作定时器，频率采样 最大128分频
*Fmaster：8MHz 
******************************************************/
void Timer4Init(void)
{
	TIM4->IER = 0X00;//禁止中断
	//分频 Master/2^n 128分频，也就是62500Hz
	//1 priod:0.016ms 
	//max:0.016*255--4.08ms
	//TIM4->PSCR = 0x7;
	TIM4->PSCR = 0x6;
	TIM4->ARR = 0xff;
	TIM4->CNTR = 0;
	TIM4->EGR = TIM4_PSCRELOADMODE_IMMEDIATE;
	TIM4->SR1 = 0;
	TIM4->IER = TIM4_IT_UPDATE;
	TIM4->CR1 |= TIM4_CR1_CEN;//启动
}
const u8 Disdat[]={0x3f,0x06,0x5b,0x4f,0x66,0x6d,0x7d,0x07,0x7f,0x6f,0x40,0x79,0x50,0x5c,0x39,0x76,0x0};//数码显示对应值
								//  0     1    2    3    4    5    6    7    8    9    -   E	   r    o	  C	   H
//采用正常顺序 h,g,f,e,d,c,b,a
static u8 dat0,dat1,dat2,dat3,dat4,dat5;
static u8 DotFlag=0;
void reflashDat(u16 TemBl,u16 HumBl)
{
	u16 buf;
	s16 TemGG;
	TemGG = (s16)TemBl;
	if(TemGG<0)
	{
		DotFlag = 0;//无小数点
		dat0 = 10;//-
		TemGG = -TemGG;
		dat1 = TemGG/100;
		if(dat1==0)dat1 = 16;// 高位不显示
		buf = TemGG%100;
		dat2 = buf/10;
	}else
	{
		DotFlag = 1;//小数点
		dat0 = TemGG/100;
		if(dat0==0)dat0 = 16;// 高位不显示
		buf = TemGG%100;
		dat1 = buf/10;
		dat2 = buf%10;
	}
	
	
	if(HumBl!=0xffff)
	{
		dat3 = HumBl/100;
		buf = HumBl%100;
		dat4 = buf/10;
		dat5 = buf%10;
	}else
	{
		dat0 = 10;
		dat1 = 10;
		dat2 = 10;
		dat3 = 10;
		dat4 = 10;
		dat5 = 10;
	}
}

//23号 定时器4中断  
@far @interrupt void TIM4_UPD_OVF_Inter(void)
{
	//static u8 num=0;
	static u8 Disnum=0;
	TIM4->SR1 = 0;
	//if(++num>=2)//    2*4.08ms=8ms
	//{
	//	num = 0;
		if(++Disnum>5)Disnum = 0;
		
		switch(Disnum)
		{
			case 0:
					Dis_L6_SET();
					WR_595(Disdat[dat0]);
					Dis_L1_CLR();
				break;
			case 1:
					Dis_L1_SET();
					if(DotFlag)
						WR_595(Disdat[dat1]|0x80);
					else
						WR_595(Disdat[dat1]);
					Dis_L2_CLR();
				break;
			case 2:
					Dis_L2_SET();
					WR_595(Disdat[dat2]);
					Dis_L3_CLR();
				break;
			case 3:
					Dis_L3_SET();					
					WR_595(Disdat[dat3]);
					Dis_L4_CLR();
				break;
			case 4:
					Dis_L4_SET();					
					WR_595(Disdat[dat4]|0x80);
					Dis_L5_CLR();
				break;
			case 5:
					Dis_L5_SET();					
					WR_595(Disdat[dat5]);
					Dis_L6_CLR();
				break;
			default:
				break;
		}
	//}
}
/***************************************************
*PWMout
*根据湿度输出对应电压  0-5V : 0-100%RH
*  (( 3.3*(X+B) ) /ARR)*A= Vout (A为放大倍数，B为偏移校准量)
*  050
*  Vout = Hum*5/1000
*  X = Hum*5
*根据温度输出对应电压  0-5V : -40℃-60℃
*  Vout = (Tem+40)*5/1000
**************************************************
void PwmOutS(s16 tempert,u16 humidity)
{
	static u16 BackHum;
	static s16 BackTem;
	static u8 FashH = 3,FashT=3;
	u16 PwMO;
	
	if(BackHum != humidity)//
	{ 
		FashH ++;
		if(FashH > 3)
		{
			FashH = 0;	
			BackHum = humidity;
			//---------------------------
			//PwMO = humidity*5*2000/(3300*1.5687)-0;//B默认为0
			PwMO = (uint32_t)humidity*5*20/(33*1.565);//1.586
			TIM2->CCR2H = PwMO>>8;//3
			TIM2->CCR2L = PwMO;//0xe8;
			//--------------------------			
		}
	}else FashH = 0;
	
	
	if(BackTem != tempert)//
	{ 
		FashT ++;
		if(FashT > 3)
		{
			FashT = 0;	
			BackTem = tempert;
			//---------------------------
			tempert += 400;//转化为正数
			if(tempert<0)tempert = 0;
			PwMO = (uint32_t)tempert*5*20/(33*1.565);
			TIM2->CCR1H = PwMO>>8;
			TIM2->CCR1L = PwMO;
			//--------------------------			
		}
	}else FashT = 0;
}*/

/**************************************************
*根据ADC采用输出电压，然后自动校准输出
*分压电阻  10K/30K 
*对应值   (Vout*30K)/(10K+30K) = (3.3V*AD)/1024
*输出：1--4V
*1V->
*************************************************
void CalibrationVOut(void)
{
	u16 i,j,ADCbuf;
	
	for(i=0;i<50;i++)
	{
			
	}
}*/
/*
void StartTestFrequce(void)
{
	TIM1->CR1 &= 0xfe;//停止计数
	TIM1->CNTRH = 0;
	TIM1->CNTRL = 0;
	TIM1->SR1 = 0;//清除更新标志
	
	TIM2->CR1 &= 0xfe;//停止定时
	TIM2->CNTRH = 0;
	TIM2->CNTRL = 0;
	TIM2->SR1 = 0;//清除更新标志

	flag = 0;
	TIM1->CR1 = 0X01; //开始计数
	TIM2->CR1 = 0X01; //开始定时
	//while(flag == 0) _asm("nop");//等待计数完成
}
uint GetFrequce(void)
{
	uint Calcudata;
	Calcudata = (uint)(TIM1->CNTRH<<8)|TIM1->CNTRL;
	return Calcudata;
}
@far @interrupt void Timer2Inter(void)
{
	TIM2->SR1 = 0;//清除更新标志
	TIM1->CR1 &= 0Xfe; //停止计数
	TIM2->CR1 &= 0Xfe; //停止定时
	flag = 1;
}
*/
/*************************************
*Timer delay
//最初系统时钟即:Fcpu = 2MHz
delay(100);//870us
delay(90);//790us
delay(57);//510us
delay(56);//490us
delay(157);//1.36ms
delay(140);//1.21
delay(120);//1.04ms
delay(170);//1.48ms
delay(180);//1.56ms
delay(175);//1.53ms
delay(173);//1.50ms
delay(220);//1.90
delay(240);//2.07
delay(230);//1.98
delay(233);//2.02
delay(231);//1.99
//Fcpu = 4MHz
	Debug_Output();
	Debug_Push();
	while(1)
	{
		Debug_SET(); 
		//delay(57);//248us
		//delay(114);//500us 496us
		//delay(230);//1ms
		//delay(350);//1.5ms
		//delay(465);//2ms
		Debug_CLR();
		delay(465);
	}
***************************************/
void delay(u16 n)
{
	  while(n--)
    {
			_asm("nop");_asm("nop");
      _asm("nop");_asm("nop");
    }
}

void DelayXus(uchar n)
{
    while (n--)
    {
			_asm("nop");
      _asm("nop");
    }
}