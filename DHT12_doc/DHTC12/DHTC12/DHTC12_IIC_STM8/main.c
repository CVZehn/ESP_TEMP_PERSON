#include "def.h"
#include "HeadAl.h"

#define USEIIC 1
#define USEOneWire 0

void IODivInit(void)
{	
	IOInit();
	HC595_SER_Output();
	HC595_RCLK_Output();	
	HC595_SCLK_Output();
	HC595_RCLK_Pull();
	HC595_SER_Pull();
	HC595_SCLK_Pull();
	Dis_L1_L2_Output();
	Dis_L3_L6_Output();
	Dis_L1_SET();
	Dis_L2_SET();
	Dis_L3_SET();
	Dis_L4_SET();
	Dis_L5_SET();
	Dis_L6_SET();
	Key1_Input();
	LED_Output();
	LED_CLR();

	HDCIIC_pull();
	HDCSDA_Output();
	HDCSCL_Output();
	HDCSCL_SET();
	HDCSDA_SET();
	HDCSCL_CLR();//进入单总线模式
	HTMCToG_CLR();
}
void main(void)
{
	u16 ResultHu;
	s16 ResultTe;
	u8 errorflag;
	
	IODivInit();
	CLKInner_Init();
	Timer4Init();
	reflashDat(0,0);
	enableInterrupts();
	delay(0xffff);
#if	USEIIC==1		
	DHTC12_MInit();//IIC模块DHTC12  DHT22
#else
	DHTC11Init_OW(); //单总线模块DHTC11  DHT21
#endif
	while(1)
	{	
		//通信周期为>100ms
			delay(0xffff);delay(0xffff);
			delay(0xffff);delay(0xffff);
			delay(0xffff);delay(0xffff);
			delay(0xffff);delay(0xffff);
			LED_CPL();
#if	USEIIC==1		
			errorflag = ReadDHTC12_M(&ResultTe,&ResultHu);    //IIC模块DHTC12   DHT22
#else
			errorflag = DHTC11_onewire(&ResultTe,&ResultHu);    //单总线模块DHTC11  DHT21
#endif
      if(errorflag)
				reflashDat(0xffff,0xffff);
			else
				reflashDat(ResultTe,ResultHu);
		
	}
}



#ifdef USE_FULL_ASSERT

/**
  * @brief  Reports the name of the source file and the source line number
  *   where the assert_param error has occurred.
  * @param file: pointer to the source file name
  * @param line: assert_param error line source number
  * @retval : None
  */
void assert_failed(u8* file, u32 line)
{ 
  /* User can add his own implementation to report the file name and line number,
     ex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */

  /* Infinite loop */
  while (1)
  {
  }
}
#endif

/******************* (C) COPYRIGHT 2011 STMicroelectronics *****END OF FILE****/