   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.12 - 20 Jun 2018
   3                     ; Generator (Limited) V4.4.8 - 20 Jun 2018
  72                     ; 30 void WR_595(u8 ShifLCDData)//写入到LCD还是继电器
  72                     ; 31 {
  74                     	switch	.text
  75  0000               _WR_595:
  77  0000 89            	pushw	x
  78       00000002      OFST:	set	2
  81                     ; 34 	Buf = (u8)ShifLCDData;
  83  0001 6b02          	ld	(OFST+0,sp),a
  85                     ; 36 	for(count1=0;count1<8;count1++)
  87  0003 0f01          	clr	(OFST-1,sp)
  89  0005               L14:
  90                     ; 38 		if((Buf&0x80)==0x80)  /*最高位为1，则向SDATA_595发送1*/
  92  0005 7b02          	ld	a,(OFST+0,sp)
  93  0007 a480          	and	a,#128
  94  0009 a180          	cp	a,#128
  95  000b 2606          	jrne	L74
  96                     ; 40 			ShifSER_SET();
  98  000d 721c500f      	bset	20495,#6
 100  0011 2004          	jra	L15
 101  0013               L74:
 102                     ; 44 			ShifSER_CLR();
 104  0013 721d500f      	bres	20495,#6
 105  0017               L15:
 106                     ; 46 		Buf<<=1;    /*右移位*/
 108  0017 0802          	sll	(OFST+0,sp)
 110                     ; 48 		ShifSCLK_CLR();
 112  0019 72145000      	bset	20480,#2
 113                     ; 49 		_asm("nop");
 116  001d 9d            nop
 118                     ; 50 		_asm("nop");
 121  001e 9d            nop
 123                     ; 53 		ShifSCLK_SET();
 125  001f 72155000      	bres	20480,#2
 126                     ; 36 	for(count1=0;count1<8;count1++)
 128  0023 0c01          	inc	(OFST-1,sp)
 132  0025 7b01          	ld	a,(OFST-1,sp)
 133  0027 a108          	cp	a,#8
 134  0029 25da          	jrult	L14
 135                     ; 55 	OUT595LCD();
 137  002b ad02          	call	L3_OUT595LCD
 139                     ; 56 }
 142  002d 85            	popw	x
 143  002e 81            	ret
 167                     ; 59 static void OUT595LCD(void)
 167                     ; 60 {
 168                     	switch	.text
 169  002f               L3_OUT595LCD:
 173                     ; 61 	ShifLCDRCK_CLR();
 175  002f 72135000      	bres	20480,#1
 176                     ; 62 	  _asm("nop");
 179  0033 9d            nop
 181                     ; 63 		_asm("nop");
 184  0034 9d            nop
 186                     ; 66 	ShifLCDRCK_SET();  /*上升沿锁存数据*/
 188  0035 72125000      	bset	20480,#1
 189                     ; 67 		_asm("nop");
 192  0039 9d            nop
 194                     ; 68 		_asm("nop");
 197  003a 9d            nop
 199                     ; 69 	ShifLCDRCK_CLR();
 201  003b 72135000      	bres	20480,#1
 202                     ; 70 }
 205  003f 81            	ret
 218                     	xdef	_WR_595
 237                     	end
