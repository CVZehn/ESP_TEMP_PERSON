#include <STC8.H>
#include <intrins.h>


void Delay1ms(unsigned int xms)		//         @11.0592MHz
{
	unsigned char i, j;
	while(xms--)
	{	
		i = 12;
		j = 5;
		do
		{
			while (--j);
		} while (--i);
	}
}	


	
	
	
	
	
	
	
	
	
	
	

