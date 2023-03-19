#ifndef __DHTC12_H_
#define __DHTC12_H_


#define u8 unsigned char
#define s16 short int
#define u16 unsigned int
#define uint8_t unsigned char
	



u16 Read_Rg(u8 AddRg);
void DHTC12_MInit();
u8 ReadDHTC12_M(s16 *tem,u16 *Hum);
u8 SHT3x_CheckCrc(u8 Data[],u8 nbrOfBytes);








#endif