#ifndef _HEADAL_H_
#define _HEADAL_H_

void CLKInner_Init(void);
void reflashDat(u16 TemBl,u16 HumBl);
void Timer4Init(void);
void delay(u16 n);
//void DelayXus(uchar n);


void DisScan(void);
//void HGDM_Read(u16* tem,u16* hum);
u8 OneWire_Read(s16* tem,u16* hum);


//DHTC11
void DHTC11Init_OW(void);
u8 DHTC11_onewire(s16 *tem,u16 *hum);
//DHTC12
void DHTC12_MInit(void);
u8 ReadDHTC12_M(s16 *tem,u16 *hum);

#define Timer4Stop()	(TIM4->CR1 = 0) //
#define Timer4Start()	(TIM4->CR1 |= TIM4_CR1_CEN)//Æô¶¯

#endif