#ifndef _DEF_H_
#define _DEF_H_
#include "stm8s.h"
//#include"STM8S103F3P.h"

typedef unsigned int uint;
typedef unsigned char uchar;

//typedef unsigned int u16;
//typedef unsigned char u8;

#define CLR_Bit(val, bitn)  val &= (uchar)(~(1<<bitn));
#define SET_Bit(val, bitn)  val |= (uchar)(1<<bitn);
#define CPL_Bit(val, bitn)  (uchar)(val ^= (uchar)(1 << (bitn) ))
#define GET_Bit(val, bitn)  (uchar)(val &  (uchar)(1 << (bitn) ))
//IO口资源分配
//PD6 	HC595_SER
//PA1 	HC595_RCLK
//PA2 	HC595_SCLK
//PB5 	Dis_L1
//PB4 	Dis_L2
//PC3 	Dis_L3
//PC4 	Dis_L4
//PC5 	Dis_L5
//PC6 	Dis_L6
//PC7 	Key
//PA3 	LED
//PD5 	ResUp 
//PD4 	ResDn
//PD2		TemADC
//PD3		HumADC

//74HC595
#define HC595_SER_Output()					GPIOD->DDR |= (uint8_t)GPIO_PIN_6
#define HC595_SER_Pull()						GPIOD->CR1 |= (uint8_t)GPIO_PIN_6
#define HC595_SER_SET()							GPIOD->ODR |= (uint8_t)GPIO_PIN_6
#define HC595_SER_CLR()							GPIOD->ODR &= (uint8_t)(~(GPIO_PIN_6))
//------------------
#define HC595_RCLK_Output()					GPIOA->DDR |= (uint8_t)GPIO_PIN_1
#define HC595_RCLK_Pull()						GPIOA->CR1 |= (uint8_t)GPIO_PIN_1
#define HC595_RCLK_SET()						GPIOA->ODR |= (uint8_t)GPIO_PIN_1
#define HC595_RCLK_CLR()						GPIOA->ODR &= (uint8_t)(~(GPIO_PIN_1))
//------------------
#define HC595_SCLK_Output()					GPIOA->DDR |= (uint8_t)GPIO_PIN_2
#define HC595_SCLK_Pull()						GPIOA->CR1 |= (uint8_t)GPIO_PIN_2
#define HC595_SCLK_SET()						GPIOA->ODR |= (uint8_t)GPIO_PIN_2
#define HC595_SCLK_CLR()						GPIOA->ODR &= (uint8_t)(~(GPIO_PIN_2))
//PB5 	Dis_L1
//PB4 	Dis_L2
//PC3 	Dis_L3
//PC4 	Dis_L4
//PC5 	Dis_L5
//PC6 	Dis_L6
//------------------
#define Dis_L1_L2_Output()					GPIOB->DDR |= (uint8_t)(GPIO_PIN_4|GPIO_PIN_5)
#define Dis_L3_L6_Output()					GPIOC->DDR |= (uint8_t)(GPIO_PIN_3|GPIO_PIN_4|GPIO_PIN_5|GPIO_PIN_6)
#define Dis_L1_L2_Pull()						GPIOB->CR1 |= (uint8_t)(GPIO_PIN_4|GPIO_PIN_5)
#define Dis_L3_L6_Pull()						GPIOC->CR1 |= (uint8_t)(GPIO_PIN_3|GPIO_PIN_4|GPIO_PIN_5|GPIO_PIN_6)
#define Dis_L1_SET()								GPIOB->ODR |= (uint8_t)GPIO_PIN_5
#define Dis_L2_SET()								GPIOB->ODR |= (uint8_t)GPIO_PIN_4
#define Dis_L3_SET()								GPIOC->ODR |= (uint8_t)GPIO_PIN_3
#define Dis_L4_SET()								GPIOC->ODR |= (uint8_t)GPIO_PIN_4
#define Dis_L5_SET()								GPIOC->ODR |= (uint8_t)GPIO_PIN_5
#define Dis_L6_SET()								GPIOC->ODR |= (uint8_t)GPIO_PIN_6
//------------------
#define Dis_L1_CLR()								GPIOB->ODR &= (uint8_t)(~(GPIO_PIN_5))
#define Dis_L2_CLR()								GPIOB->ODR &= (uint8_t)(~(GPIO_PIN_4))
#define Dis_L3_CLR()								GPIOC->ODR &= (uint8_t)(~(GPIO_PIN_3))
#define Dis_L4_CLR()								GPIOC->ODR &= (uint8_t)(~(GPIO_PIN_4))
#define Dis_L5_CLR()								GPIOC->ODR &= (uint8_t)(~(GPIO_PIN_5))
#define Dis_L6_CLR()								GPIOC->ODR &= (uint8_t)(~(GPIO_PIN_6))
//PC7 	Key
#define Key1_Input()								GPIOC->DDR &= (uint8_t)(~GPIO_PIN_7)
#define Get_Key1()      						((BitStatus)(GPIOC->IDR & (uint8_t)GPIO_PIN_7))
//PA3 	LED
#define LED_Output()								GPIOA->DDR |= (uint8_t)(GPIO_PIN_3)
#define LED_SET()										GPIOA->ODR |= (uint8_t)(GPIO_PIN_3)
#define LED_CLR()										GPIOA->ODR &= (uint8_t)(~(GPIO_PIN_3))
#define LED_CPL()										GPIOA->ODR ^= (uint8_t)(GPIO_PIN_3)

//PD5 	ResUp 
//PD4 	ResDn
#define ResUp_Dn_Output()						GPIOD->DDR |= (uint8_t)(GPIO_PIN_4|GPIO_PIN_5)
#define ResUp_Dn_Pull()							GPIOD->CR1 |= (uint8_t)(GPIO_PIN_4|GPIO_PIN_5)
#define ResUp_SET()									GPIOD->ODR |= (uint8_t)GPIO_PIN_5
#define ResUp_CLR()									GPIOD->ODR &= (uint8_t)(~(GPIO_PIN_5))
#define ResDn_SET()									GPIOD->ODR |= (uint8_t)GPIO_PIN_4
#define ResDn_CLR()									GPIOD->ODR &= (uint8_t)(~(GPIO_PIN_4))
//PD2		TemADC  AIN3
//PD3		HumADC  AIN4
#define TemAdcCh  3
#define TemIO_Input()		GPIOD->DDR &= (uint8_t)(~GPIO_PIN_2)					

#define HumAdcCh	4
#define HumIO_Input()		GPIOD->DDR &= (uint8_t)(~GPIO_PIN_3)	

#define ForbidS			(uint8_t)((1<<TemAdcCh)|(1<<HumAdcCh))
/*
//用来读取数字模块
//PD2  TemADC 共用 读取数据口
#define	ReadModualIO_output()				GPIOD->DDR |= (uint8_t)(GPIO_PIN_2)
#define ReadModualIO_input()				GPIOD->DDR &= (uint8_t)(~GPIO_PIN_2)
#define ReadModualIO_Pull()					GPIOD->CR1 |= (uint8_t)(GPIO_PIN_2)
#define ReadModualIO_SET()					GPIOD->ODR |= (uint8_t)GPIO_PIN_2
#define ReadModualIO_CLR()					GPIOD->ODR &= (uint8_t)(~(GPIO_PIN_2))
#define ReadModualIO_GetDat()				((BitStatus)(GPIOD->IDR & (uint8_t)GPIO_PIN_2))
//PD3 HumADC共用  复位口
//PD4 	ResDn 共用 复位口
#define RESTIO1_Input()							GPIOD->DDR &= (uint8_t)(~GPIO_PIN_3)	
#define RESTIO2_Input()							GPIOD->DDR &= (uint8_t)(~GPIO_PIN_4)
//PD5 	ResUp 共用数字模块的GND
#define DHTGND_Output()							GPIOD->DDR |= (uint8_t)(GPIO_PIN_5)
#define DHTGND_CLR()								GPIOD->ODR &= (uint8_t)(~(GPIO_PIN_5))
#define DHTGND_SET()								GPIOD->ODR |= (uint8_t)GPIO_PIN_5
*/
//IIC口
//使用SHT2x
//SDA--PD2
//SCL--PD5
#define HDCIIC_pull()					GPIOD->CR1 |= (uint8_t)((GPIO_PIN_2)|(GPIO_PIN_5))

#define HDCSCL_Output()				GPIOD->DDR |= (uint8_t)GPIO_PIN_5	
#define HDCSCL_Input()				GPIOD->DDR &= (uint8_t)(~GPIO_PIN_5)
#define HDCSCL_SET()					GPIOD->ODR |= (uint8_t)GPIO_PIN_5
#define HDCSCL_CLR()					GPIOD->ODR &= (uint8_t)(~(GPIO_PIN_5))
#define HDCGet_SCL()				 	((BitStatus)(GPIOD->IDR & (uint8_t)GPIO_PIN_5))

#define HDCSDA_Output()				GPIOD->DDR |= (uint8_t)GPIO_PIN_2	
#define HDCSDA_Input()				GPIOD->DDR &= (uint8_t)(~GPIO_PIN_2)
#define HDCSDA_SET()					GPIOD->ODR |= (uint8_t)GPIO_PIN_2
#define HDCSDA_CLR()					GPIOD->ODR &= (uint8_t)(~(GPIO_PIN_2))
#define HDCGet_SDA()					((BitStatus)(GPIOD->IDR & (uint8_t)GPIO_PIN_2))
//PD3接地 接模块的GND
#define HTMCToG_Output()			GPIOD->DDR |= (uint8_t)GPIO_PIN_3
#define HTMCToG_CLR()					GPIOD->ODR &= (uint8_t)(~(GPIO_PIN_3))

/*
 GPIOD->DDR |= 0xff;  \
 GPIOD->ODR |= 0;  \
 
 */
#define IOInit()    		do{         								\
															 GPIOA->DDR |= 0xff;  \
															 GPIOB->DDR |= 0xff;  \
															 GPIOC->DDR |= 0xff;  \
															 GPIOA->ODR |= 0; 		\
															 GPIOB->ODR |= 0;  		\
															 GPIOC->ODR |= 0;  		\
														}while(0)  
#endif    