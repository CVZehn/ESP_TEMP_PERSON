   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.12 - 20 Jun 2018
   3                     ; Generator (Limited) V4.4.8 - 20 Jun 2018
  53                     ; 4 void DelaySus(uchar n)
  53                     ; 5 {
  55                     	switch	.text
  56  0000               _DelaySus:
  58  0000 88            	push	a
  59       00000000      OFST:	set	0
  62  0001 2002          	jra	L13
  63  0003               L72:
  64                     ; 8 			_asm("nop");
  67  0003 9d            nop
  69                     ; 9       _asm("nop");
  72  0004 9d            nop
  74  0005               L13:
  75                     ; 6     while (n--)
  77  0005 7b01          	ld	a,(OFST+1,sp)
  78  0007 0a01          	dec	(OFST+1,sp)
  79  0009 4d            	tnz	a
  80  000a 26f7          	jrne	L72
  81                     ; 11 }
  84  000c 84            	pop	a
  85  000d 81            	ret
 110                     ; 13 void DQ_Rst(void)
 110                     ; 14 {
 111                     	switch	.text
 112  000e               _DQ_Rst:
 116                     ; 15 		HDCSDA_Output();
 118  000e 72145011      	bset	20497,#2
 119                     ; 16     DelaySus(2);    //5us 无需严格要求
 121  0012 a602          	ld	a,#2
 122  0014 adea          	call	_DelaySus
 124                     ; 17     HDCSDA_CLR();
 126  0016 7215500f      	bres	20495,#2
 127                     ; 18    	delay(114);  //>480us 典型值960us  规格书：tRSTL
 129  001a ae0072        	ldw	x,#114
 130  001d cd0000        	call	_delay
 132                     ; 19     HDCSDA_SET();
 134  0020 7214500f      	bset	20495,#2
 135                     ; 20     DelaySus(7);  //8us  无需严格要求
 137  0024 a607          	ld	a,#7
 138  0026 add8          	call	_DelaySus
 140                     ; 21 }
 143  0028 81            	ret
 178                     ; 24 u8  DQ_Presence(void)
 178                     ; 25 {
 179                     	switch	.text
 180  0029               _DQ_Presence:
 182  0029 88            	push	a
 183       00000001      OFST:	set	1
 186                     ; 26     u8 pulse_time = 0;
 188  002a 0f01          	clr	(OFST+0,sp)
 190                     ; 27 		HDCSDA_Input();
 192  002c 72155011      	bres	20497,#2
 193                     ; 28     DelaySus(2); //5us 无需严格要求
 195  0030 a602          	ld	a,#2
 196  0032 adcc          	call	_DelaySus
 199  0034 2006          	jra	L56
 200  0036               L36:
 201                     ; 31         pulse_time++;
 203  0036 0c01          	inc	(OFST+0,sp)
 205                     ; 32         DelaySus(5);//>6us
 207  0038 a605          	ld	a,#5
 208  003a adc4          	call	_DelaySus
 210  003c               L56:
 211                     ; 29     while( (HDCGet_SDA()) && pulse_time<100 )   //存在检测高电平15~60us 模块响应高电平时间  tPDHIGH 规格书：
 213  003c c65010        	ld	a,20496
 214  003f a504          	bcp	a,#4
 215  0041 2706          	jreq	L17
 217  0043 7b01          	ld	a,(OFST+0,sp)
 218  0045 a164          	cp	a,#100
 219  0047 25ed          	jrult	L36
 220  0049               L17:
 221                     ; 34     if( pulse_time >=20 )
 223  0049 7b01          	ld	a,(OFST+0,sp)
 224  004b a114          	cp	a,#20
 225  004d 2505          	jrult	L37
 226                     ; 35         return 0x01;
 228  004f a601          	ld	a,#1
 231  0051 5b01          	addw	sp,#1
 232  0053 81            	ret
 233  0054               L37:
 234                     ; 37         pulse_time = 0;//应答正常
 236  0054 0f01          	clr	(OFST+0,sp)
 238  0056 2006          	jra	L101
 239  0058               L77:
 240                     ; 41         pulse_time++;
 242  0058 0c01          	inc	(OFST+0,sp)
 244                     ; 42         DelaySus(2);//1~5us
 246  005a a602          	ld	a,#2
 247  005c ada2          	call	_DelaySus
 249  005e               L101:
 250                     ; 39     while((HDCGet_SDA()==0) && pulse_time<240 ) //存在检测低电平时间60~240us  tPDLOW
 252  005e c65010        	ld	a,20496
 253  0061 a504          	bcp	a,#4
 254  0063 2606          	jrne	L501
 256  0065 7b01          	ld	a,(OFST+0,sp)
 257  0067 a1f0          	cp	a,#240
 258  0069 25ed          	jrult	L77
 259  006b               L501:
 260                     ; 44     if( pulse_time >=10 )// 应答正常
 262  006b 7b01          	ld	a,(OFST+0,sp)
 263  006d a10a          	cp	a,#10
 264  006f 2505          	jrult	L701
 265                     ; 46        		return 0x01;
 267  0071 a601          	ld	a,#1
 270  0073 5b01          	addw	sp,#1
 271  0075 81            	ret
 272  0076               L701:
 273                     ; 49         return 0x0;
 275  0076 4f            	clr	a
 278  0077 5b01          	addw	sp,#1
 279  0079 81            	ret
 314                     ; 56 u8 DQ_Read_Bit(void)
 314                     ; 57 {
 315                     	switch	.text
 316  007a               _DQ_Read_Bit:
 318  007a 88            	push	a
 319       00000001      OFST:	set	1
 322                     ; 60 		HDCSDA_Output();
 324  007b 72145011      	bset	20497,#2
 325                     ; 62     HDCSDA_CLR();
 327  007f 7215500f      	bres	20495,#2
 328                     ; 63     DelaySus(2); //tINIT>1us 典型5us <15us  
 330  0083 a602          	ld	a,#2
 331  0085 cd0000        	call	_DelaySus
 333                     ; 65 		HDCSDA_Input();
 335  0088 72155011      	bres	20497,#2
 336                     ; 66     DelaySus(5);//tRC  典型5us 
 338  008c a605          	ld	a,#5
 339  008e cd0000        	call	_DelaySus
 341                     ; 67     if(HDCGet_SDA())//tSample
 343  0091 c65010        	ld	a,20496
 344  0094 a504          	bcp	a,#4
 345  0096 2706          	jreq	L131
 346                     ; 68         dat = 1;
 348  0098 a601          	ld	a,#1
 349  009a 6b01          	ld	(OFST+0,sp),a
 352  009c 2002          	jra	L331
 353  009e               L131:
 354                     ; 70         dat = 0;
 356  009e 0f01          	clr	(OFST+0,sp)
 358  00a0               L331:
 359                     ; 71     DelaySus(33);//tDelay >60us 确保一帧数据传输完毕
 361  00a0 a621          	ld	a,#33
 362  00a2 cd0000        	call	_DelaySus
 364                     ; 72     return dat;
 366  00a5 7b01          	ld	a,(OFST+0,sp)
 369  00a7 5b01          	addw	sp,#1
 370  00a9 81            	ret
 423                     ; 75 u8 DQ_Read_Byte(void)
 423                     ; 76 {
 424                     	switch	.text
 425  00aa               _DQ_Read_Byte:
 427  00aa 5203          	subw	sp,#3
 428       00000003      OFST:	set	3
 431                     ; 77     u8 i, j, dat = 0;
 433  00ac 0f02          	clr	(OFST-1,sp)
 435                     ; 79     for(i=0; i<8; i++)
 437  00ae 0f03          	clr	(OFST+0,sp)
 439  00b0               L361:
 440                     ; 81         j = DQ_Read_Bit();
 442  00b0 adc8          	call	_DQ_Read_Bit
 444  00b2 6b01          	ld	(OFST-2,sp),a
 446                     ; 82         dat = (dat) | (j<<i);
 448  00b4 7b03          	ld	a,(OFST+0,sp)
 449  00b6 5f            	clrw	x
 450  00b7 97            	ld	xl,a
 451  00b8 7b01          	ld	a,(OFST-2,sp)
 452  00ba 5d            	tnzw	x
 453  00bb 2704          	jreq	L61
 454  00bd               L02:
 455  00bd 48            	sll	a
 456  00be 5a            	decw	x
 457  00bf 26fc          	jrne	L02
 458  00c1               L61:
 459  00c1 1a02          	or	a,(OFST-1,sp)
 460  00c3 6b02          	ld	(OFST-1,sp),a
 462                     ; 79     for(i=0; i<8; i++)
 464  00c5 0c03          	inc	(OFST+0,sp)
 468  00c7 7b03          	ld	a,(OFST+0,sp)
 469  00c9 a108          	cp	a,#8
 470  00cb 25e3          	jrult	L361
 471                     ; 84     return dat;
 473  00cd 7b02          	ld	a,(OFST-1,sp)
 476  00cf 5b03          	addw	sp,#3
 477  00d1 81            	ret
 521                     ; 87 void DQ_Write_Bit(u8 bit)
 521                     ; 88 {
 522                     	switch	.text
 523  00d2               _DQ_Write_Bit:
 525  00d2 88            	push	a
 526       00000001      OFST:	set	1
 529                     ; 90     testb = bit&0x01;
 531  00d3 a401          	and	a,#1
 532  00d5 6b01          	ld	(OFST+0,sp),a
 534                     ; 91 		HDCSDA_Output();
 536  00d7 72145011      	bset	20497,#2
 537                     ; 92     if(testb)//写1
 539  00db 0d01          	tnz	(OFST+0,sp)
 540  00dd 2714          	jreq	L312
 541                     ; 94         HDCSDA_CLR();
 543  00df 7215500f      	bres	20495,#2
 544                     ; 95         DelaySus(3);//>1us  <15us
 546  00e3 a603          	ld	a,#3
 547  00e5 cd0000        	call	_DelaySus
 549                     ; 96 				HDCSDA_SET();
 551  00e8 7214500f      	bset	20495,#2
 552                     ; 97         DelaySus(33);//>=60us
 554  00ec a621          	ld	a,#33
 555  00ee cd0000        	call	_DelaySus
 558  00f1 2012          	jra	L512
 559  00f3               L312:
 560                     ; 101         HDCSDA_CLR();
 562  00f3 7215500f      	bres	20495,#2
 563                     ; 102         DelaySus(38);//>=60us
 565  00f7 a626          	ld	a,#38
 566  00f9 cd0000        	call	_DelaySus
 568                     ; 103 				HDCSDA_SET();
 570  00fc 7214500f      	bset	20495,#2
 571                     ; 104         DelaySus(3);//典型5us
 573  0100 a603          	ld	a,#3
 574  0102 cd0000        	call	_DelaySus
 576  0105               L512:
 577                     ; 106 }
 580  0105 84            	pop	a
 581  0106 81            	ret
 634                     ; 108 void  DQ_Write_Byte(uint8_t dat)
 634                     ; 109 {
 635                     	switch	.text
 636  0107               _DQ_Write_Byte:
 638  0107 88            	push	a
 639  0108 89            	pushw	x
 640       00000002      OFST:	set	2
 643                     ; 111 		HDCSDA_Output();
 645  0109 72145011      	bset	20497,#2
 646                     ; 112     for( i=0; i<8; i++ )
 648  010d 0f02          	clr	(OFST+0,sp)
 650  010f               L542:
 651                     ; 114         testb = dat&0x01;
 653  010f 7b03          	ld	a,(OFST+1,sp)
 654  0111 a401          	and	a,#1
 655  0113 6b01          	ld	(OFST-1,sp),a
 657                     ; 115         dat = dat>>1;
 659  0115 0403          	srl	(OFST+1,sp)
 660                     ; 116        if(testb)//写1
 662  0117 0d01          	tnz	(OFST-1,sp)
 663  0119 2714          	jreq	L352
 664                     ; 118 					HDCSDA_CLR();
 666  011b 7215500f      	bres	20495,#2
 667                     ; 119 					DelaySus(3);//>1us  <15us
 669  011f a603          	ld	a,#3
 670  0121 cd0000        	call	_DelaySus
 672                     ; 120 					HDCSDA_SET();
 674  0124 7214500f      	bset	20495,#2
 675                     ; 121 					DelaySus(33);//>=60us
 677  0128 a621          	ld	a,#33
 678  012a cd0000        	call	_DelaySus
 681  012d 2012          	jra	L552
 682  012f               L352:
 683                     ; 125 					HDCSDA_CLR();
 685  012f 7215500f      	bres	20495,#2
 686                     ; 126 					DelaySus(38);//MY_DELAY_US(70);>60us
 688  0133 a626          	ld	a,#38
 689  0135 cd0000        	call	_DelaySus
 691                     ; 127 					HDCSDA_SET();
 693  0138 7214500f      	bset	20495,#2
 694                     ; 128 					DelaySus(3);//典型5us
 696  013c a603          	ld	a,#3
 697  013e cd0000        	call	_DelaySus
 699  0141               L552:
 700                     ; 112     for( i=0; i<8; i++ )
 702  0141 0c02          	inc	(OFST+0,sp)
 706  0143 7b02          	ld	a,(OFST+0,sp)
 707  0145 a108          	cp	a,#8
 708  0147 25c6          	jrult	L542
 709                     ; 131 }
 712  0149 5b03          	addw	sp,#3
 713  014b 81            	ret
 784                     ; 132 u8 CRC8MHT_Cal(u8 *serial, u8 length) 
 784                     ; 133 {
 785                     	switch	.text
 786  014c               _CRC8MHT_Cal:
 788  014c 89            	pushw	x
 789  014d 5203          	subw	sp,#3
 790       00000003      OFST:	set	3
 793                     ; 134     u8 result = 0x00;
 795  014f 0f03          	clr	(OFST+0,sp)
 798  0151 2033          	jra	L123
 799  0153               L513:
 800                     ; 139         pDataBuf = *serial++;
 802  0153 1e04          	ldw	x,(OFST+1,sp)
 803  0155 1c0001        	addw	x,#1
 804  0158 1f04          	ldw	(OFST+1,sp),x
 805  015a 1d0001        	subw	x,#1
 806  015d f6            	ld	a,(x)
 807  015e 6b01          	ld	(OFST-2,sp),a
 809                     ; 140         for(i=0; i<8; i++) {
 811  0160 0f02          	clr	(OFST-1,sp)
 813  0162               L523:
 814                     ; 141             if((result^(pDataBuf))&0x01){
 816  0162 7b03          	ld	a,(OFST+0,sp)
 817  0164 1801          	xor	a,(OFST-2,sp)
 818  0166 a501          	bcp	a,#1
 819  0168 2710          	jreq	L333
 820                     ; 142                 result ^= 0x18;
 822  016a 7b03          	ld	a,(OFST+0,sp)
 823  016c a818          	xor	a,	#24
 824  016e 6b03          	ld	(OFST+0,sp),a
 826                     ; 143                 result >>= 1;
 828  0170 0403          	srl	(OFST+0,sp)
 830                     ; 144                 result |= 0x80;
 832  0172 7b03          	ld	a,(OFST+0,sp)
 833  0174 aa80          	or	a,#128
 834  0176 6b03          	ld	(OFST+0,sp),a
 837  0178 2002          	jra	L533
 838  017a               L333:
 839                     ; 147                 result >>= 1;
 841  017a 0403          	srl	(OFST+0,sp)
 843  017c               L533:
 844                     ; 149             pDataBuf >>= 1;
 846  017c 0401          	srl	(OFST-2,sp)
 848                     ; 140         for(i=0; i<8; i++) {
 850  017e 0c02          	inc	(OFST-1,sp)
 854  0180 7b02          	ld	a,(OFST-1,sp)
 855  0182 a108          	cp	a,#8
 856  0184 25dc          	jrult	L523
 857  0186               L123:
 858                     ; 138     while(length--) {
 860  0186 7b08          	ld	a,(OFST+5,sp)
 861  0188 0a08          	dec	(OFST+5,sp)
 862  018a 4d            	tnz	a
 863  018b 26c6          	jrne	L513
 864                     ; 152     return result;
 866  018d 7b03          	ld	a,(OFST+0,sp)
 869  018f 5b05          	addw	sp,#5
 870  0191 81            	ret
 899                     ; 157 void DHTC11Init_OW(void)
 899                     ; 158 {
 900                     	switch	.text
 901  0192               _DHTC11Init_OW:
 905                     ; 162 Timer4Stop();	//暂停有可能打断通信的中断
 907  0192 725f5340      	clr	21312
 908                     ; 163 	DQ_Rst();
 910  0196 cd000e        	call	_DQ_Rst
 912                     ; 164 	DQ_Presence();
 914  0199 cd0029        	call	_DQ_Presence
 916                     ; 165   DQ_Write_Byte(0xcc);
 918  019c a6cc          	ld	a,#204
 919  019e cd0107        	call	_DQ_Write_Byte
 921                     ; 166 	DQ_Write_Byte(0xdd);
 923  01a1 a6dd          	ld	a,#221
 924  01a3 cd0107        	call	_DQ_Write_Byte
 926                     ; 168 	OwHumA = DQ_Read_Byte();
 928  01a6 cd00aa        	call	_DQ_Read_Byte
 930  01a9 5f            	clrw	x
 931  01aa 97            	ld	xl,a
 932  01ab bf02          	ldw	L733_OwHumA,x
 933                     ; 169 	OwHumA = (OwHumA<<8)|DQ_Read_Byte();
 935  01ad cd00aa        	call	_DQ_Read_Byte
 937  01b0 be02          	ldw	x,L733_OwHumA
 938  01b2 02            	rlwa	x,a
 939  01b3 bf02          	ldw	L733_OwHumA,x
 940                     ; 170 	OwHumB = DQ_Read_Byte();
 942  01b5 cd00aa        	call	_DQ_Read_Byte
 944  01b8 5f            	clrw	x
 945  01b9 97            	ld	xl,a
 946  01ba bf00          	ldw	L143_OwHumB,x
 947                     ; 171 	OwHumB = (OwHumB<<8)|DQ_Read_Byte();
 949  01bc cd00aa        	call	_DQ_Read_Byte
 951  01bf be00          	ldw	x,L143_OwHumB
 952  01c1 02            	rlwa	x,a
 953  01c2 bf00          	ldw	L143_OwHumB,x
 954                     ; 173 Timer4Start();	
 956  01c4 72105340      	bset	21312,#0
 957                     ; 191 }
 960  01c8 81            	ret
1050                     .const:	section	.text
1051  0000               L43:
1052  0000 00000258      	dc.l	600
1053  0004               L63:
1054  0004 0000012c      	dc.l	300
1055  0008               L04:
1056  0008 000003e8      	dc.l	1000
1057                     ; 194 u8 DHTC11_onewire(s16 *tem,u16 *hum)
1057                     ; 195 {
1058                     	switch	.text
1059  01c9               _DHTC11_onewire:
1061  01c9 89            	pushw	x
1062  01ca 5214          	subw	sp,#20
1063       00000014      OFST:	set	20
1066                     ; 196 	u8 ResDat[5],crc=0,ReBit;
1068                     ; 201 Timer4Stop();//单总线通讯 暂停中断
1070  01cc 725f5340      	clr	21312
1071                     ; 202 		DQ_Rst();
1073  01d0 cd000e        	call	_DQ_Rst
1075                     ; 203 		DQ_Presence();
1077  01d3 cd0029        	call	_DQ_Presence
1079                     ; 204 		DQ_Write_Byte(0xcc);
1081  01d6 a6cc          	ld	a,#204
1082  01d8 cd0107        	call	_DQ_Write_Byte
1084                     ; 205 		DQ_Write_Byte(0x10);
1086  01db a610          	ld	a,#16
1087  01dd cd0107        	call	_DQ_Write_Byte
1089                     ; 206 Timer4Start();		
1091  01e0 72105340      	bset	21312,#0
1092                     ; 208 		delay(7075);//2ms*15  35ms  改时间可以去处理其他任务回来读取
1094  01e4 ae1ba3        	ldw	x,#7075
1095  01e7 cd0000        	call	_delay
1097                     ; 210 Timer4Stop();		
1099  01ea 725f5340      	clr	21312
1100                     ; 211 		DQ_Rst();
1102  01ee cd000e        	call	_DQ_Rst
1104                     ; 212 		DQ_Presence();
1106  01f1 cd0029        	call	_DQ_Presence
1108                     ; 213 		DQ_Write_Byte(0xcc);
1110  01f4 a6cc          	ld	a,#204
1111  01f6 cd0107        	call	_DQ_Write_Byte
1113                     ; 214 		DQ_Write_Byte(0xbd);
1115  01f9 a6bd          	ld	a,#189
1116  01fb cd0107        	call	_DQ_Write_Byte
1118                     ; 215 		ResDat[0] = DQ_Read_Byte();
1120  01fe cd00aa        	call	_DQ_Read_Byte
1122  0201 6b0c          	ld	(OFST-8,sp),a
1124                     ; 216 		ResDat[1] = DQ_Read_Byte();
1126  0203 cd00aa        	call	_DQ_Read_Byte
1128  0206 6b0d          	ld	(OFST-7,sp),a
1130                     ; 217 		ResDat[2] = DQ_Read_Byte();
1132  0208 cd00aa        	call	_DQ_Read_Byte
1134  020b 6b0e          	ld	(OFST-6,sp),a
1136                     ; 218 		ResDat[3] = DQ_Read_Byte();
1138  020d cd00aa        	call	_DQ_Read_Byte
1140  0210 6b0f          	ld	(OFST-5,sp),a
1142                     ; 219 		ResDat[4] = DQ_Read_Byte();
1144  0212 cd00aa        	call	_DQ_Read_Byte
1146  0215 6b10          	ld	(OFST-4,sp),a
1148                     ; 222 Timer4Start();
1150  0217 72105340      	bset	21312,#0
1151                     ; 223 		crc = CRC8MHT_Cal(ResDat,5);
1153  021b 4b05          	push	#5
1154  021d 96            	ldw	x,sp
1155  021e 1c000d        	addw	x,#OFST-7
1156  0221 cd014c        	call	_CRC8MHT_Cal
1158  0224 5b01          	addw	sp,#1
1159  0226 6b09          	ld	(OFST-11,sp),a
1161                     ; 224 		if(crc == 0)
1163  0228 0d09          	tnz	(OFST-11,sp)
1164  022a 2703          	jreq	L24
1165  022c cc02f2        	jp	L514
1166  022f               L24:
1167                     ; 226 			TemBuf = (u16)ResDat[1]<<8|(ResDat[0]);
1169  022f 7b0d          	ld	a,(OFST-7,sp)
1170  0231 5f            	clrw	x
1171  0232 97            	ld	xl,a
1172  0233 7b0c          	ld	a,(OFST-8,sp)
1173  0235 02            	rlwa	x,a
1174  0236 1f0a          	ldw	(OFST-10,sp),x
1176                     ; 227 			TemBuf = 400+TemBuf/25.6;//*10 结果*10倍 286即28.6℃
1178  0238 1e0a          	ldw	x,(OFST-10,sp)
1179  023a cd0000        	call	c_itof
1181  023d ae0010        	ldw	x,#L324
1182  0240 cd0000        	call	c_fdiv
1184  0243 ae000c        	ldw	x,#L334
1185  0246 cd0000        	call	c_fadd
1187  0249 cd0000        	call	c_ftoi
1189  024c 1f0a          	ldw	(OFST-10,sp),x
1191                     ; 228 			*tem = TemBuf;
1193  024e 1e15          	ldw	x,(OFST+1,sp)
1194  0250 160a          	ldw	y,(OFST-10,sp)
1195  0252 ff            	ldw	(x),y
1196                     ; 230 		 CapBuf = (u16)ResDat[3]<<8|(ResDat[2]);
1198  0253 7b0f          	ld	a,(OFST-5,sp)
1199  0255 5f            	clrw	x
1200  0256 97            	ld	xl,a
1201  0257 7b0e          	ld	a,(OFST-6,sp)
1202  0259 02            	rlwa	x,a
1203  025a cd0000        	call	c_uitolx
1205  025d 96            	ldw	x,sp
1206  025e 1c0011        	addw	x,#OFST-3
1207  0261 cd0000        	call	c_rtol
1210                     ; 231 		 CapBuf = (CapBuf-OwHumB)*600/(OwHumA-OwHumB)+300;//同样结果*10
1212  0264 be02          	ldw	x,L733_OwHumA
1213  0266 72b00000      	subw	x,L143_OwHumB
1214  026a cd0000        	call	c_uitolx
1216  026d 96            	ldw	x,sp
1217  026e 1c0005        	addw	x,#OFST-15
1218  0271 cd0000        	call	c_rtol
1221  0274 be00          	ldw	x,L143_OwHumB
1222  0276 cd0000        	call	c_uitolx
1224  0279 96            	ldw	x,sp
1225  027a 1c0001        	addw	x,#OFST-19
1226  027d cd0000        	call	c_rtol
1229  0280 96            	ldw	x,sp
1230  0281 1c0011        	addw	x,#OFST-3
1231  0284 cd0000        	call	c_ltor
1233  0287 96            	ldw	x,sp
1234  0288 1c0001        	addw	x,#OFST-19
1235  028b cd0000        	call	c_lsub
1237  028e ae0000        	ldw	x,#L43
1238  0291 cd0000        	call	c_lmul
1240  0294 96            	ldw	x,sp
1241  0295 1c0005        	addw	x,#OFST-15
1242  0298 cd0000        	call	c_ldiv
1244  029b ae0004        	ldw	x,#L63
1245  029e cd0000        	call	c_ladd
1247  02a1 96            	ldw	x,sp
1248  02a2 1c0011        	addw	x,#OFST-3
1249  02a5 cd0000        	call	c_rtol
1252                     ; 233 		 CapBuf = CapBuf+ 25*(TemBuf-250)/100;	
1254  02a8 1e0a          	ldw	x,(OFST-10,sp)
1255  02aa a619          	ld	a,#25
1256  02ac cd0000        	call	c_bmulx
1258  02af 1d186a        	subw	x,#6250
1259  02b2 a664          	ld	a,#100
1260  02b4 cd0000        	call	c_sdivx
1262  02b7 cd0000        	call	c_itolx
1264  02ba 96            	ldw	x,sp
1265  02bb 1c0011        	addw	x,#OFST-3
1266  02be cd0000        	call	c_lgadd
1269                     ; 235 		 if(CapBuf>999)CapBuf = 999;
1271  02c1 9c            	rvf
1272  02c2 96            	ldw	x,sp
1273  02c3 1c0011        	addw	x,#OFST-3
1274  02c6 cd0000        	call	c_ltor
1276  02c9 ae0008        	ldw	x,#L04
1277  02cc cd0000        	call	c_lcmp
1279  02cf 2f0c          	jrslt	L734
1282  02d1 ae03e7        	ldw	x,#999
1283  02d4 1f13          	ldw	(OFST-1,sp),x
1284  02d6 ae0000        	ldw	x,#0
1285  02d9 1f11          	ldw	(OFST-3,sp),x
1288  02db 2010          	jra	L144
1289  02dd               L734:
1290                     ; 236 		 else if(CapBuf<0)CapBuf=0;
1292  02dd 9c            	rvf
1293  02de 9c            	rvf
1294  02df 0d11          	tnz	(OFST-3,sp)
1295  02e1 2e0a          	jrsge	L144
1298  02e3 ae0000        	ldw	x,#0
1299  02e6 1f13          	ldw	(OFST-1,sp),x
1300  02e8 ae0000        	ldw	x,#0
1301  02eb 1f11          	ldw	(OFST-3,sp),x
1303  02ed               L144:
1304                     ; 237 			*hum = (u16)CapBuf;
1306  02ed 1e19          	ldw	x,(OFST+5,sp)
1307  02ef 1613          	ldw	y,(OFST-1,sp)
1308  02f1 ff            	ldw	(x),y
1309  02f2               L514:
1310                     ; 240 	return crc;
1312  02f2 7b09          	ld	a,(OFST-11,sp)
1315  02f4 5b16          	addw	sp,#22
1316  02f6 81            	ret
1349                     	switch	.ubsct
1350  0000               L143_OwHumB:
1351  0000 0000          	ds.b	2
1352  0002               L733_OwHumA:
1353  0002 0000          	ds.b	2
1354                     	xdef	_CRC8MHT_Cal
1355                     	xdef	_DQ_Write_Byte
1356                     	xdef	_DQ_Write_Bit
1357                     	xdef	_DQ_Read_Byte
1358                     	xdef	_DQ_Read_Bit
1359                     	xdef	_DQ_Presence
1360                     	xdef	_DQ_Rst
1361                     	xdef	_DelaySus
1362                     	xdef	_DHTC11_onewire
1363                     	xdef	_DHTC11Init_OW
1364                     	xref	_delay
1365                     	switch	.const
1366  000c               L334:
1367  000c 43c80000      	dc.w	17352,0
1368  0010               L324:
1369  0010 41cccccc      	dc.w	16844,-13108
1370                     	xref.b	c_x
1390                     	xref	c_lcmp
1391                     	xref	c_lgadd
1392                     	xref	c_itolx
1393                     	xref	c_sdivx
1394                     	xref	c_bmulx
1395                     	xref	c_ladd
1396                     	xref	c_ldiv
1397                     	xref	c_lmul
1398                     	xref	c_lsub
1399                     	xref	c_ltor
1400                     	xref	c_rtol
1401                     	xref	c_uitolx
1402                     	xref	c_ftoi
1403                     	xref	c_fadd
1404                     	xref	c_fdiv
1405                     	xref	c_itof
1406                     	end
