   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.12 - 20 Jun 2018
   3                     ; Generator (Limited) V4.4.8 - 20 Jun 2018
  42                     ; 7 void IODivInit(void)
  42                     ; 8 {	
  44                     	switch	.text
  45  0000               _IODivInit:
  49                     ; 9 	IOInit();
  51  0000 c65002        	ld	a,20482
  52  0003 aaff          	or	a,#255
  53  0005 c75002        	ld	20482,a
  56  0008 c65007        	ld	a,20487
  57  000b aaff          	or	a,#255
  58  000d c75007        	ld	20487,a
  61  0010 c6500c        	ld	a,20492
  62  0013 aaff          	or	a,#255
  63  0015 c7500c        	ld	20492,a
  66  0018 c65000        	ld	a,20480
  69  001b c65005        	ld	a,20485
  72  001e c6500a        	ld	a,20490
  73                     ; 10 	HC595_SER_Output();
  75  0021 721c5011      	bset	20497,#6
  76                     ; 11 	HC595_RCLK_Output();	
  78  0025 72125002      	bset	20482,#1
  79                     ; 12 	HC595_SCLK_Output();
  81  0029 72145002      	bset	20482,#2
  82                     ; 13 	HC595_RCLK_Pull();
  84  002d 72125003      	bset	20483,#1
  85                     ; 14 	HC595_SER_Pull();
  87  0031 721c5012      	bset	20498,#6
  88                     ; 15 	HC595_SCLK_Pull();
  90  0035 72145003      	bset	20483,#2
  91                     ; 16 	Dis_L1_L2_Output();
  93  0039 c65007        	ld	a,20487
  94  003c aa30          	or	a,#48
  95  003e c75007        	ld	20487,a
  96                     ; 17 	Dis_L3_L6_Output();
  98  0041 c6500c        	ld	a,20492
  99  0044 aa78          	or	a,#120
 100  0046 c7500c        	ld	20492,a
 101                     ; 18 	Dis_L1_SET();
 103  0049 721a5005      	bset	20485,#5
 104                     ; 19 	Dis_L2_SET();
 106  004d 72185005      	bset	20485,#4
 107                     ; 20 	Dis_L3_SET();
 109  0051 7216500a      	bset	20490,#3
 110                     ; 21 	Dis_L4_SET();
 112  0055 7218500a      	bset	20490,#4
 113                     ; 22 	Dis_L5_SET();
 115  0059 721a500a      	bset	20490,#5
 116                     ; 23 	Dis_L6_SET();
 118  005d 721c500a      	bset	20490,#6
 119                     ; 24 	Key1_Input();
 121  0061 721f500c      	bres	20492,#7
 122                     ; 25 	LED_Output();
 124  0065 72165002      	bset	20482,#3
 125                     ; 26 	LED_CLR();
 127  0069 72175000      	bres	20480,#3
 128                     ; 28 	HDCIIC_pull();
 130  006d c65012        	ld	a,20498
 131  0070 aa24          	or	a,#36
 132  0072 c75012        	ld	20498,a
 133                     ; 29 	HDCSDA_Output();
 135  0075 72145011      	bset	20497,#2
 136                     ; 30 	HDCSCL_Output();
 138  0079 721a5011      	bset	20497,#5
 139                     ; 31 	HDCSCL_SET();
 141  007d 721a500f      	bset	20495,#5
 142                     ; 32 	HDCSDA_SET();
 144  0081 7214500f      	bset	20495,#2
 145                     ; 33 	HDCSCL_CLR();//进入单总线模式
 147  0085 721b500f      	bres	20495,#5
 148                     ; 34 	HTMCToG_CLR();
 150  0089 7217500f      	bres	20495,#3
 151                     ; 35 }
 154  008d 81            	ret
 214                     ; 36 void main(void)
 214                     ; 37 {
 215                     	switch	.text
 216  008e               _main:
 218  008e 5205          	subw	sp,#5
 219       00000005      OFST:	set	5
 222                     ; 42 	IODivInit();
 224  0090 cd0000        	call	_IODivInit
 226                     ; 43 	CLKInner_Init();
 228  0093 cd0000        	call	_CLKInner_Init
 230                     ; 44 	Timer4Init();
 232  0096 cd0000        	call	_Timer4Init
 234                     ; 45 	reflashDat(0,0);
 236  0099 5f            	clrw	x
 237  009a 89            	pushw	x
 238  009b 5f            	clrw	x
 239  009c cd0000        	call	_reflashDat
 241  009f 85            	popw	x
 242                     ; 46 	enableInterrupts();
 245  00a0 9a            rim
 247                     ; 47 	delay(0xffff);
 250  00a1 aeffff        	ldw	x,#65535
 251  00a4 cd0000        	call	_delay
 253                     ; 49 	DHTC12_MInit();//IIC模块DHTC12  DHT22
 255  00a7 cd0000        	call	_DHTC12_MInit
 257  00aa               L35:
 258                     ; 56 			delay(0xffff);delay(0xffff);
 260  00aa aeffff        	ldw	x,#65535
 261  00ad cd0000        	call	_delay
 265  00b0 aeffff        	ldw	x,#65535
 266  00b3 cd0000        	call	_delay
 268                     ; 57 			delay(0xffff);delay(0xffff);
 270  00b6 aeffff        	ldw	x,#65535
 271  00b9 cd0000        	call	_delay
 275  00bc aeffff        	ldw	x,#65535
 276  00bf cd0000        	call	_delay
 278                     ; 58 			delay(0xffff);delay(0xffff);
 280  00c2 aeffff        	ldw	x,#65535
 281  00c5 cd0000        	call	_delay
 285  00c8 aeffff        	ldw	x,#65535
 286  00cb cd0000        	call	_delay
 288                     ; 59 			delay(0xffff);delay(0xffff);
 290  00ce aeffff        	ldw	x,#65535
 291  00d1 cd0000        	call	_delay
 295  00d4 aeffff        	ldw	x,#65535
 296  00d7 cd0000        	call	_delay
 298                     ; 60 			LED_CPL();
 300  00da 90165000      	bcpl	20480,#3
 301                     ; 62 			errorflag = ReadDHTC12_M(&ResultTe,&ResultHu);    //IIC模块DHTC12   DHT22
 303  00de 96            	ldw	x,sp
 304  00df 1c0001        	addw	x,#OFST-4
 305  00e2 89            	pushw	x
 306  00e3 96            	ldw	x,sp
 307  00e4 1c0005        	addw	x,#OFST+0
 308  00e7 cd0000        	call	_ReadDHTC12_M
 310  00ea 85            	popw	x
 311  00eb 6b05          	ld	(OFST+0,sp),a
 313                     ; 66       if(errorflag)
 315  00ed 0d05          	tnz	(OFST+0,sp)
 316  00ef 270d          	jreq	L75
 317                     ; 67 				reflashDat(0xffff,0xffff);
 319  00f1 aeffff        	ldw	x,#65535
 320  00f4 89            	pushw	x
 321  00f5 aeffff        	ldw	x,#65535
 322  00f8 cd0000        	call	_reflashDat
 324  00fb 85            	popw	x
 326  00fc 20ac          	jra	L35
 327  00fe               L75:
 328                     ; 69 				reflashDat(ResultTe,ResultHu);
 330  00fe 1e01          	ldw	x,(OFST-4,sp)
 331  0100 89            	pushw	x
 332  0101 1e05          	ldw	x,(OFST+0,sp)
 333  0103 cd0000        	call	_reflashDat
 335  0106 85            	popw	x
 336  0107 20a1          	jra	L35
 371                     ; 85 void assert_failed(u8* file, u32 line)
 371                     ; 86 { 
 372                     	switch	.text
 373  0109               _assert_failed:
 377  0109               L101:
 378  0109 20fe          	jra	L101
 391                     	xdef	_main
 392                     	xdef	_IODivInit
 393                     	xref	_ReadDHTC12_M
 394                     	xref	_DHTC12_MInit
 395                     	xref	_delay
 396                     	xref	_Timer4Init
 397                     	xref	_reflashDat
 398                     	xref	_CLKInner_Init
 399                     	xdef	_assert_failed
 418                     	end
