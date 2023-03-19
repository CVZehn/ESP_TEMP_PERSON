   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.12 - 20 Jun 2018
   3                     ; Generator (Limited) V4.4.8 - 20 Jun 2018
  43                     ; 8 void start(void){
  45                     	switch	.text
  46  0000               _start:
  50                     ; 9 	HDCSDA_SET();
  52  0000 7214500f      	bset	20495,#2
  53                     ; 10 		delay(10);
  55  0004 ae000a        	ldw	x,#10
  56  0007 cd0000        	call	_delay
  58                     ; 11 	HDCSCL_SET();
  60  000a 721a500f      	bset	20495,#5
  61                     ; 12 		delay(10);
  63  000e ae000a        	ldw	x,#10
  64  0011 cd0000        	call	_delay
  66                     ; 13 	HDCSDA_CLR();
  68  0014 7215500f      	bres	20495,#2
  69                     ; 14 		delay(10);
  71  0018 ae000a        	ldw	x,#10
  72  001b cd0000        	call	_delay
  74                     ; 15 	HDCSCL_CLR();
  76  001e 721b500f      	bres	20495,#5
  77                     ; 16 }
  80  0022 81            	ret
 104                     ; 17 void stop(void){
 105                     	switch	.text
 106  0023               _stop:
 110                     ; 18 	HDCSDA_CLR();
 112  0023 7215500f      	bres	20495,#2
 113                     ; 19 		delay(10);
 115  0027 ae000a        	ldw	x,#10
 116  002a cd0000        	call	_delay
 118                     ; 20 	HDCSCL_SET();
 120  002d 721a500f      	bset	20495,#5
 121                     ; 21 		delay(10);
 123  0031 ae000a        	ldw	x,#10
 124  0034 cd0000        	call	_delay
 126                     ; 22 	HDCSDA_SET();
 128  0037 7214500f      	bset	20495,#2
 129                     ; 23 		delay(10);
 131  003b ae000a        	ldw	x,#10
 132  003e cd0000        	call	_delay
 134                     ; 24 }
 137  0041 81            	ret
 182                     ; 25 u8 respons(void)
 182                     ; 26 {
 183                     	switch	.text
 184  0042               _respons:
 186  0042 89            	pushw	x
 187       00000002      OFST:	set	2
 190                     ; 27 	u8 i=0,error=0;//写完后紧跟着WaitACK，所有可以改变SDA
 192  0043 0f02          	clr	(OFST+0,sp)
 196                     ; 28 	HDCSDA_Input();//???????????????/
 198  0045 72155011      	bres	20497,#2
 199                     ; 30 	HDCSCL_SET();
 201  0049 721a500f      	bset	20495,#5
 202                     ; 31 		delay(10);
 204  004d ae000a        	ldw	x,#10
 205  0050 cd0000        	call	_delay
 207                     ; 32 	ACK_ret = 0;		
 209  0053 3f04          	clr	L3_ACK_ret
 211  0055 2002          	jra	L16
 212  0057               L55:
 213                     ; 33 	while(((HDCGet_SDA())!=0)&&i<50)i++;
 215  0057 0c02          	inc	(OFST+0,sp)
 217  0059               L16:
 220  0059 c65010        	ld	a,20496
 221  005c a504          	bcp	a,#4
 222  005e 2706          	jreq	L56
 224  0060 7b02          	ld	a,(OFST+0,sp)
 225  0062 a132          	cp	a,#50
 226  0064 25f1          	jrult	L55
 227  0066               L56:
 228                     ; 34 	if(i>45) 
 230  0066 7b02          	ld	a,(OFST+0,sp)
 231  0068 a12e          	cp	a,#46
 232  006a 2504          	jrult	L76
 233                     ; 36 	  error = 1;
 235                     ; 37 		ACK_ret = 1;
 237  006c 35010004      	mov	L3_ACK_ret,#1
 238  0070               L76:
 239                     ; 39 	HDCSCL_CLR();//SCK:0可以改变SDA
 241  0070 721b500f      	bres	20495,#5
 242                     ; 40 		delay(10);
 244  0074 ae000a        	ldw	x,#10
 245  0077 cd0000        	call	_delay
 247                     ; 41 	HDCSDA_Output();//???????????????/
 249  007a 72145011      	bset	20497,#2
 250                     ; 43 }
 253  007e 85            	popw	x
 254  007f 81            	ret
 289                     ; 44 void SendACK(u8 ack)
 289                     ; 45 {
 290                     	switch	.text
 291  0080               _SendACK:
 295                     ; 46     if(ack == 0)
 297  0080 4d            	tnz	a
 298  0081 2606          	jrne	L701
 299                     ; 48 			HDCSDA_CLR();
 301  0083 7215500f      	bres	20495,#2
 303  0087 2004          	jra	L111
 304  0089               L701:
 305                     ; 52       HDCSDA_SET();
 307  0089 7214500f      	bset	20495,#2
 308  008d               L111:
 309                     ; 54     delay(10);        
 311  008d ae000a        	ldw	x,#10
 312  0090 cd0000        	call	_delay
 314                     ; 55     HDCSCL_SET();                    
 316  0093 721a500f      	bset	20495,#5
 317                     ; 56      delay(10); 
 319  0097 ae000a        	ldw	x,#10
 320  009a cd0000        	call	_delay
 322                     ; 57 		HDCSCL_CLR();                    
 324  009d 721b500f      	bres	20495,#5
 325                     ; 58      delay(10); 
 327  00a1 ae000a        	ldw	x,#10
 328  00a4 cd0000        	call	_delay
 330                     ; 59 	  HDCSDA_SET();
 332  00a7 7214500f      	bset	20495,#2
 333                     ; 60 }
 336  00ab 81            	ret
 389                     ; 62 void write_byte(u8 date){
 390                     	switch	.text
 391  00ac               _write_byte:
 393  00ac 89            	pushw	x
 394       00000002      OFST:	set	2
 397                     ; 64 	temp=date;
 399  00ad 6b02          	ld	(OFST+0,sp),a
 401                     ; 65 	for(i=0;i<8;i++)
 403  00af 0f01          	clr	(OFST-1,sp)
 405  00b1               L141:
 406                     ; 67 		HDCSCL_CLR();
 408  00b1 721b500f      	bres	20495,#5
 409                     ; 69 		if((temp&0x80)==0x80)
 411  00b5 7b02          	ld	a,(OFST+0,sp)
 412  00b7 a480          	and	a,#128
 413  00b9 a180          	cp	a,#128
 414  00bb 2606          	jrne	L741
 415                     ; 70 			{HDCSDA_SET();}else{HDCSDA_CLR();}
 417  00bd 7214500f      	bset	20495,#2
 419  00c1 2004          	jra	L151
 420  00c3               L741:
 423  00c3 7215500f      	bres	20495,#2
 424  00c7               L151:
 425                     ; 71 			delay(10);
 427  00c7 ae000a        	ldw	x,#10
 428  00ca cd0000        	call	_delay
 430                     ; 72 		HDCSCL_SET();
 432  00cd 721a500f      	bset	20495,#5
 433                     ; 73 			delay(10);
 435  00d1 ae000a        	ldw	x,#10
 436  00d4 cd0000        	call	_delay
 438                     ; 74 		temp=temp<<1;
 440  00d7 0802          	sll	(OFST+0,sp)
 442                     ; 65 	for(i=0;i<8;i++)
 444  00d9 0c01          	inc	(OFST-1,sp)
 448  00db 7b01          	ld	a,(OFST-1,sp)
 449  00dd a108          	cp	a,#8
 450  00df 25d0          	jrult	L141
 451                     ; 76 	HDCSCL_CLR();
 453  00e1 721b500f      	bres	20495,#5
 454                     ; 77 	delay(10);
 456  00e5 ae000a        	ldw	x,#10
 457  00e8 cd0000        	call	_delay
 459                     ; 80 }
 462  00eb 85            	popw	x
 463  00ec 81            	ret
 507                     ; 82 u8 read_byte(void){
 508                     	switch	.text
 509  00ed               _read_byte:
 511  00ed 89            	pushw	x
 512       00000002      OFST:	set	2
 515                     ; 84 	HDCSDA_SET();//让P口准备读数
 517  00ee 7214500f      	bset	20495,#2
 518                     ; 85 	HDCSDA_Input();
 520  00f2 72155011      	bres	20497,#2
 521                     ; 86 	for(i=0;i<8;i++)
 523  00f6 0f01          	clr	(OFST-1,sp)
 525  00f8               L571:
 526                     ; 88 		HDCSCL_SET();
 528  00f8 721a500f      	bset	20495,#5
 529                     ; 89 			delay(10);
 531  00fc ae000a        	ldw	x,#10
 532  00ff cd0000        	call	_delay
 534                     ; 90 		k <<= 1;
 536  0102 0802          	sll	(OFST+0,sp)
 538                     ; 91 		if(HDCGet_SDA())//==0x04
 540  0104 c65010        	ld	a,20496
 541  0107 a504          	bcp	a,#4
 542  0109 2706          	jreq	L302
 543                     ; 92 			k |= 0x01;
 545  010b 7b02          	ld	a,(OFST+0,sp)
 546  010d aa01          	or	a,#1
 547  010f 6b02          	ld	(OFST+0,sp),a
 549  0111               L302:
 550                     ; 93 		HDCSCL_CLR();//SCK:0可以改变SDA
 552  0111 721b500f      	bres	20495,#5
 553                     ; 94 			delay(10);
 555  0115 ae000a        	ldw	x,#10
 556  0118 cd0000        	call	_delay
 558                     ; 86 	for(i=0;i<8;i++)
 560  011b 0c01          	inc	(OFST-1,sp)
 564  011d 7b01          	ld	a,(OFST-1,sp)
 565  011f a108          	cp	a,#8
 566  0121 25d5          	jrult	L571
 567                     ; 96 	HDCSDA_Output();//
 569  0123 72145011      	bset	20497,#2
 570                     ; 97   return k;
 572  0127 7b02          	ld	a,(OFST+0,sp)
 575  0129 85            	popw	x
 576  012a 81            	ret
 579                     .const:	section	.text
 580  0000               _POLYNOMIAL:
 581  0000 0131          	dc.w	305
 651                     ; 102 u8 SHT3x_CheckCrc(u8 data[], u8 nbrOfBytes)  //跟SHT30一样只是将CRC值到会到data后返回
 651                     ; 103 //==============================================================================
 651                     ; 104 {
 652                     	switch	.text
 653  012b               _SHT3x_CheckCrc:
 655  012b 89            	pushw	x
 656  012c 5203          	subw	sp,#3
 657       00000003      OFST:	set	3
 660                     ; 105   u8 crc = 0xff;	//0
 662  012e a6ff          	ld	a,#255
 663  0130 6b03          	ld	(OFST+0,sp),a
 665                     ; 108   for (byteCtr = 0; byteCtr < nbrOfBytes; ++byteCtr)
 667  0132 0f01          	clr	(OFST-2,sp)
 670  0134 202d          	jra	L742
 671  0136               L342:
 672                     ; 109   { crc ^= (data[byteCtr]);
 674  0136 7b04          	ld	a,(OFST+1,sp)
 675  0138 97            	ld	xl,a
 676  0139 7b05          	ld	a,(OFST+2,sp)
 677  013b 1b01          	add	a,(OFST-2,sp)
 678  013d 2401          	jrnc	L22
 679  013f 5c            	incw	x
 680  0140               L22:
 681  0140 02            	rlwa	x,a
 682  0141 7b03          	ld	a,(OFST+0,sp)
 683  0143 f8            	xor	a,	(x)
 684  0144 6b03          	ld	(OFST+0,sp),a
 686                     ; 110     for (bit = 8; bit > 0; --bit)
 688  0146 a608          	ld	a,#8
 689  0148 6b02          	ld	(OFST-1,sp),a
 691  014a               L352:
 692                     ; 111     { if (crc & 0x80) crc = (crc << 1) ^ POLYNOMIAL;
 694  014a 7b03          	ld	a,(OFST+0,sp)
 695  014c a580          	bcp	a,#128
 696  014e 2709          	jreq	L162
 699  0150 7b03          	ld	a,(OFST+0,sp)
 700  0152 48            	sll	a
 701  0153 a831          	xor	a,#49
 702  0155 6b03          	ld	(OFST+0,sp),a
 705  0157 2002          	jra	L362
 706  0159               L162:
 707                     ; 112       else crc = (crc << 1);
 709  0159 0803          	sll	(OFST+0,sp)
 711  015b               L362:
 712                     ; 110     for (bit = 8; bit > 0; --bit)
 714  015b 0a02          	dec	(OFST-1,sp)
 718  015d 0d02          	tnz	(OFST-1,sp)
 719  015f 26e9          	jrne	L352
 720                     ; 108   for (byteCtr = 0; byteCtr < nbrOfBytes; ++byteCtr)
 722  0161 0c01          	inc	(OFST-2,sp)
 724  0163               L742:
 727  0163 7b01          	ld	a,(OFST-2,sp)
 728  0165 1108          	cp	a,(OFST+5,sp)
 729  0167 25cd          	jrult	L342
 730                     ; 115   if (crc != data[nbrOfBytes]) 
 732  0169 7b04          	ld	a,(OFST+1,sp)
 733  016b 97            	ld	xl,a
 734  016c 7b05          	ld	a,(OFST+2,sp)
 735  016e 1b08          	add	a,(OFST+5,sp)
 736  0170 2401          	jrnc	L42
 737  0172 5c            	incw	x
 738  0173               L42:
 739  0173 02            	rlwa	x,a
 740  0174 f6            	ld	a,(x)
 741  0175 1103          	cp	a,(OFST+0,sp)
 742  0177 2712          	jreq	L562
 743                     ; 117 		data[nbrOfBytes] = crc;
 745  0179 7b04          	ld	a,(OFST+1,sp)
 746  017b 97            	ld	xl,a
 747  017c 7b05          	ld	a,(OFST+2,sp)
 748  017e 1b08          	add	a,(OFST+5,sp)
 749  0180 2401          	jrnc	L62
 750  0182 5c            	incw	x
 751  0183               L62:
 752  0183 02            	rlwa	x,a
 753  0184 7b03          	ld	a,(OFST+0,sp)
 754  0186 f7            	ld	(x),a
 755                     ; 118 		return 0x01;
 757  0187 a601          	ld	a,#1
 759  0189 2001          	jra	L03
 760  018b               L562:
 761                     ; 120   else return 0;
 763  018b 4f            	clr	a
 765  018c               L03:
 767  018c 5b05          	addw	sp,#5
 768  018e 81            	ret
 796                     ; 126 void ResetMD(void)
 796                     ; 127 {
 797                     	switch	.text
 798  018f               _ResetMD:
 802                     ; 128 	start();
 804  018f cd0000        	call	_start
 806                     ; 129 	write_byte(V4_I2C_ADDR<<1);// Add+W
 808  0192 a688          	ld	a,#136
 809  0194 cd00ac        	call	_write_byte
 811                     ; 130 	delay(1);
 813  0197 ae0001        	ldw	x,#1
 814  019a cd0000        	call	_delay
 816                     ; 131 	respons();
 818  019d cd0042        	call	_respons
 820                     ; 132 	write_byte(0x30);
 822  01a0 a630          	ld	a,#48
 823  01a2 cd00ac        	call	_write_byte
 825                     ; 133 	respons();
 827  01a5 cd0042        	call	_respons
 829                     ; 134 	write_byte(0xA2);
 831  01a8 a6a2          	ld	a,#162
 832  01aa cd00ac        	call	_write_byte
 834                     ; 135 	respons();
 836  01ad cd0042        	call	_respons
 838                     ; 136 	stop();
 840  01b0 cd0023        	call	_stop
 842                     ; 137 }
 845  01b3 81            	ret
 915                     ; 139 u16 Read_Rg(u8 AddRg)
 915                     ; 140 {
 916                     	switch	.text
 917  01b4               _Read_Rg:
 919  01b4 88            	push	a
 920  01b5 5206          	subw	sp,#6
 921       00000006      OFST:	set	6
 924                     ; 144 	start();
 926  01b7 cd0000        	call	_start
 928                     ; 145 	write_byte(V4_I2C_ADDR<<1);// Add+W
 930  01ba a688          	ld	a,#136
 931  01bc cd00ac        	call	_write_byte
 933                     ; 146 	delay(1);
 935  01bf ae0001        	ldw	x,#1
 936  01c2 cd0000        	call	_delay
 938                     ; 147 	respons();
 940  01c5 cd0042        	call	_respons
 942                     ; 148 	write_byte(0xD2);//单字节读取寄存器 指令D2xx 
 944  01c8 a6d2          	ld	a,#210
 945  01ca cd00ac        	call	_write_byte
 947                     ; 149 	respons();
 949  01cd cd0042        	call	_respons
 951                     ; 150 	write_byte(AddRg);
 953  01d0 7b07          	ld	a,(OFST+1,sp)
 954  01d2 cd00ac        	call	_write_byte
 956                     ; 151 	respons();
 958  01d5 cd0042        	call	_respons
 960                     ; 153 	delay(10);
 962  01d8 ae000a        	ldw	x,#10
 963  01db cd0000        	call	_delay
 965                     ; 154 	start();
 967  01de cd0000        	call	_start
 969                     ; 155 	write_byte(V4_I2C_ADDR<<1|0x01);// Add+R
 971  01e1 a689          	ld	a,#137
 972  01e3 cd00ac        	call	_write_byte
 974                     ; 156 	errRe=respons();
 976  01e6 cd0042        	call	_respons
 978                     ; 159 	ReadDatSH[0] = read_byte();
 980  01e9 cd00ed        	call	_read_byte
 982  01ec 6b04          	ld	(OFST-2,sp),a
 984                     ; 160 	SendACK(ACK);
 986  01ee 4f            	clr	a
 987  01ef cd0080        	call	_SendACK
 989                     ; 161 	ReadDatSH[1] = read_byte();
 991  01f2 cd00ed        	call	_read_byte
 993  01f5 6b05          	ld	(OFST-1,sp),a
 995                     ; 162 	SendACK(ACK);
 997  01f7 4f            	clr	a
 998  01f8 cd0080        	call	_SendACK
1000                     ; 163 	ReadDatSH[2] = read_byte();
1002  01fb cd00ed        	call	_read_byte
1004  01fe 6b06          	ld	(OFST+0,sp),a
1006                     ; 164 	SendACK(NACK);
1008  0200 a601          	ld	a,#1
1009  0202 cd0080        	call	_SendACK
1011                     ; 166 	stop();
1013  0205 cd0023        	call	_stop
1015                     ; 167 	errRe = SHT3x_CheckCrc(ReadDatSH,2);
1017  0208 4b02          	push	#2
1018  020a 96            	ldw	x,sp
1019  020b 1c0005        	addw	x,#OFST-1
1020  020e cd012b        	call	_SHT3x_CheckCrc
1022  0211 5b01          	addw	sp,#1
1023  0213 6b01          	ld	(OFST-5,sp),a
1025                     ; 168 	if(errRe==0)
1027  0215 0d01          	tnz	(OFST-5,sp)
1028  0217 2608          	jrne	L333
1029                     ; 170 		ReDat = ReadDatSH[0];
1031  0219 7b04          	ld	a,(OFST-2,sp)
1032  021b 5f            	clrw	x
1033  021c 97            	ld	xl,a
1034  021d 1f02          	ldw	(OFST-4,sp),x
1037  021f 2005          	jra	L533
1038  0221               L333:
1039                     ; 173 		ReDat = 0xff;
1041  0221 ae00ff        	ldw	x,#255
1042  0224 1f02          	ldw	(OFST-4,sp),x
1044  0226               L533:
1045                     ; 175 	return ReDat;
1047  0226 1e02          	ldw	x,(OFST-4,sp)
1050  0228 5b07          	addw	sp,#7
1051  022a 81            	ret
1079                     ; 207 void DHTC12_MInit(void)
1079                     ; 208 {	
1080                     	switch	.text
1081  022b               _DHTC12_MInit:
1083  022b 89            	pushw	x
1084       00000002      OFST:	set	2
1087                     ; 209 	ResetMD();
1089  022c cd018f        	call	_ResetMD
1091                     ; 210 	delay(10);
1093  022f ae000a        	ldw	x,#10
1094  0232 cd0000        	call	_delay
1096                     ; 211 	HumA = Read_Rg(8);
1098  0235 a608          	ld	a,#8
1099  0237 cd01b4        	call	_Read_Rg
1101  023a bf02          	ldw	L733_HumA,x
1102                     ; 212 	HumA = (HumA<<8)|Read_Rg(9);
1104  023c a609          	ld	a,#9
1105  023e cd01b4        	call	_Read_Rg
1107  0241 1f01          	ldw	(OFST-1,sp),x
1109  0243 be02          	ldw	x,L733_HumA
1110  0245 4f            	clr	a
1111  0246 02            	rlwa	x,a
1112  0247 01            	rrwa	x,a
1113  0248 1a02          	or	a,(OFST+0,sp)
1114  024a 01            	rrwa	x,a
1115  024b 1a01          	or	a,(OFST-1,sp)
1116  024d 01            	rrwa	x,a
1117  024e bf02          	ldw	L733_HumA,x
1118                     ; 213 	HumB = Read_Rg(10);
1120  0250 a60a          	ld	a,#10
1121  0252 cd01b4        	call	_Read_Rg
1123  0255 bf00          	ldw	L143_HumB,x
1124                     ; 214 	HumB = (HumB<<8)|Read_Rg(11);
1126  0257 a60b          	ld	a,#11
1127  0259 cd01b4        	call	_Read_Rg
1129  025c 1f01          	ldw	(OFST-1,sp),x
1131  025e be00          	ldw	x,L143_HumB
1132  0260 4f            	clr	a
1133  0261 02            	rlwa	x,a
1134  0262 01            	rrwa	x,a
1135  0263 1a02          	or	a,(OFST+0,sp)
1136  0265 01            	rrwa	x,a
1137  0266 1a01          	or	a,(OFST-1,sp)
1138  0268 01            	rrwa	x,a
1139  0269 bf00          	ldw	L143_HumB,x
1140                     ; 215 }
1143  026b 85            	popw	x
1144  026c 81            	ret
1147                     	bsct
1148  0000               L353_initFlag:
1149  0000 00            	dc.b	0
1277                     	switch	.const
1278  0002               L24:
1279  0002 00000258      	dc.l	600
1280  0006               L44:
1281  0006 0000012c      	dc.l	300
1282  000a               L64:
1283  000a 000003e9      	dc.l	1001
1284                     ; 218 u8 ReadDHTC12_M(s16 *tem,u16 *hum)
1284                     ; 219 {
1285                     	switch	.text
1286  026d               _ReadDHTC12_M:
1288  026d 89            	pushw	x
1289  026e 5219          	subw	sp,#25
1290       00000019      OFST:	set	25
1293                     ; 225 	start();
1295  0270 cd0000        	call	_start
1297                     ; 226 	write_byte(V4_I2C_ADDR<<1);// Add+W
1299  0273 a688          	ld	a,#136
1300  0275 cd00ac        	call	_write_byte
1302                     ; 227 	delay(1);
1304  0278 ae0001        	ldw	x,#1
1305  027b cd0000        	call	_delay
1307                     ; 228 	respons();
1309  027e cd0042        	call	_respons
1311                     ; 229 	write_byte(0x2c);//单字节读取寄存器 指令D2xx 
1313  0281 a62c          	ld	a,#44
1314  0283 cd00ac        	call	_write_byte
1316                     ; 230 	respons();
1318  0286 cd0042        	call	_respons
1320                     ; 231 	write_byte(0x10);
1322  0289 a610          	ld	a,#16
1323  028b cd00ac        	call	_write_byte
1325                     ; 232 	respons();
1327  028e cd0042        	call	_respons
1329                     ; 233 	stop();
1331  0291 cd0023        	call	_stop
1333                     ; 234 	delay(465);//2ms  SCL空闲最小1ms  
1335  0294 ae01d1        	ldw	x,#465
1336  0297 cd0000        	call	_delay
1338                     ; 236 	for(i=0;i<50;i++)//查询5次看测完结果
1340  029a 0f13          	clr	(OFST-6,sp)
1342  029c               L734:
1343                     ; 238 		delay(230);//1ms
1345  029c ae00e6        	ldw	x,#230
1346  029f cd0000        	call	_delay
1348                     ; 239 		delay(230);
1350  02a2 ae00e6        	ldw	x,#230
1351  02a5 cd0000        	call	_delay
1353                     ; 240 		delay(230);
1355  02a8 ae00e6        	ldw	x,#230
1356  02ab cd0000        	call	_delay
1358                     ; 242 		start();
1360  02ae cd0000        	call	_start
1362                     ; 243 		write_byte(V4_I2C_ADDR<<1|0x01);// Add+R
1364  02b1 a689          	ld	a,#137
1365  02b3 cd00ac        	call	_write_byte
1367                     ; 244 		errRe=respons();
1369  02b6 cd0042        	call	_respons
1371                     ; 245 		if(ACK_ret==0)
1373  02b9 3d04          	tnz	L3_ACK_ret
1374  02bb 270b          	jreq	L344
1375                     ; 246 			break;//测量完成
1377                     ; 248 			stop();
1379  02bd cd0023        	call	_stop
1381                     ; 236 	for(i=0;i<50;i++)//查询5次看测完结果
1383  02c0 0c13          	inc	(OFST-6,sp)
1387  02c2 7b13          	ld	a,(OFST-6,sp)
1388  02c4 a132          	cp	a,#50
1389  02c6 25d4          	jrult	L734
1390  02c8               L344:
1391                     ; 251 	if(ACK_ret == 0)
1393  02c8 3d04          	tnz	L3_ACK_ret
1394  02ca 263a          	jrne	L154
1395                     ; 253 		ReadDatSH[0] = read_byte();
1397  02cc cd00ed        	call	_read_byte
1399  02cf 6b14          	ld	(OFST-5,sp),a
1401                     ; 254 		SendACK(ACK);
1403  02d1 4f            	clr	a
1404  02d2 cd0080        	call	_SendACK
1406                     ; 255 		ReadDatSH[1] = read_byte();
1408  02d5 cd00ed        	call	_read_byte
1410  02d8 6b15          	ld	(OFST-4,sp),a
1412                     ; 256 		SendACK(ACK);
1414  02da 4f            	clr	a
1415  02db cd0080        	call	_SendACK
1417                     ; 257 		ReadDatSH[2] = read_byte();
1419  02de cd00ed        	call	_read_byte
1421  02e1 6b16          	ld	(OFST-3,sp),a
1423                     ; 258 		SendACK(ACK);
1425  02e3 4f            	clr	a
1426  02e4 cd0080        	call	_SendACK
1428                     ; 259 		ReadDatSH[3] = read_byte();
1430  02e7 cd00ed        	call	_read_byte
1432  02ea 6b17          	ld	(OFST-2,sp),a
1434                     ; 260 		SendACK(ACK);
1436  02ec 4f            	clr	a
1437  02ed cd0080        	call	_SendACK
1439                     ; 261 		ReadDatSH[4] = read_byte();
1441  02f0 cd00ed        	call	_read_byte
1443  02f3 6b18          	ld	(OFST-1,sp),a
1445                     ; 262 		SendACK(ACK);
1447  02f5 4f            	clr	a
1448  02f6 cd0080        	call	_SendACK
1450                     ; 263 		ReadDatSH[5] = read_byte();
1452  02f9 cd00ed        	call	_read_byte
1454  02fc 6b19          	ld	(OFST+0,sp),a
1456                     ; 264 		SendACK(NACK);
1458  02fe a601          	ld	a,#1
1459  0300 cd0080        	call	_SendACK
1461                     ; 265 		stop();
1463  0303 cd0023        	call	_stop
1465  0306               L154:
1466                     ; 267 	CalCRC[0] = ReadDatSH[0];
1468  0306 7b14          	ld	a,(OFST-5,sp)
1469  0308 6b0c          	ld	(OFST-13,sp),a
1471                     ; 268 	CalCRC[1] = ReadDatSH[1];
1473  030a 7b15          	ld	a,(OFST-4,sp)
1474  030c 6b0d          	ld	(OFST-12,sp),a
1476                     ; 269 	CalCRC[2] = ReadDatSH[2];
1478  030e 7b16          	ld	a,(OFST-3,sp)
1479  0310 6b0e          	ld	(OFST-11,sp),a
1481                     ; 270 	errorflag = SHT3x_CheckCrc(CalCRC,2);
1483  0312 4b02          	push	#2
1484  0314 96            	ldw	x,sp
1485  0315 1c000d        	addw	x,#OFST-12
1486  0318 cd012b        	call	_SHT3x_CheckCrc
1488  031b 5b01          	addw	sp,#1
1489  031d 6b13          	ld	(OFST-6,sp),a
1491                     ; 271 	if(errorflag==0)
1493  031f 0d13          	tnz	(OFST-6,sp)
1494  0321 2624          	jrne	L354
1495                     ; 273 		TemBuf = (u16)ReadDatSH[0]<<8|(ReadDatSH[1]);
1497  0323 7b14          	ld	a,(OFST-5,sp)
1498  0325 5f            	clrw	x
1499  0326 97            	ld	xl,a
1500  0327 7b15          	ld	a,(OFST-4,sp)
1501  0329 02            	rlwa	x,a
1502  032a 1f0a          	ldw	(OFST-15,sp),x
1504                     ; 274 		TemBuf = 400+TemBuf/25.6;//*10 结果*10倍 286即28.6℃
1506  032c 1e0a          	ldw	x,(OFST-15,sp)
1507  032e cd0000        	call	c_itof
1509  0331 ae0012        	ldw	x,#L164
1510  0334 cd0000        	call	c_fdiv
1512  0337 ae000e        	ldw	x,#L174
1513  033a cd0000        	call	c_fadd
1515  033d cd0000        	call	c_ftoi
1517  0340 1f0a          	ldw	(OFST-15,sp),x
1519                     ; 275 		*tem = TemBuf;
1521  0342 1e1a          	ldw	x,(OFST+1,sp)
1522  0344 160a          	ldw	y,(OFST-15,sp)
1523  0346 ff            	ldw	(x),y
1524  0347               L354:
1525                     ; 278 	CalCRC[0] = ReadDatSH[3];
1527  0347 7b17          	ld	a,(OFST-2,sp)
1528  0349 6b0c          	ld	(OFST-13,sp),a
1530                     ; 279 	CalCRC[1] = ReadDatSH[4];
1532  034b 7b18          	ld	a,(OFST-1,sp)
1533  034d 6b0d          	ld	(OFST-12,sp),a
1535                     ; 280 	CalCRC[2] = ReadDatSH[5];
1537  034f 7b19          	ld	a,(OFST+0,sp)
1538  0351 6b0e          	ld	(OFST-11,sp),a
1540                     ; 281 	errorflag |= SHT3x_CheckCrc(CalCRC,2);
1542  0353 4b02          	push	#2
1543  0355 96            	ldw	x,sp
1544  0356 1c000d        	addw	x,#OFST-12
1545  0359 cd012b        	call	_SHT3x_CheckCrc
1547  035c 5b01          	addw	sp,#1
1548  035e 1a13          	or	a,(OFST-6,sp)
1549  0360 6b13          	ld	(OFST-6,sp),a
1551                     ; 282 	if(errorflag==0)
1553  0362 0d13          	tnz	(OFST-6,sp)
1554  0364 2703          	jreq	L05
1555  0366 cc0408        	jp	L574
1556  0369               L05:
1557                     ; 284 	 CapBuf = ReadDatSH[3]<<8|(ReadDatSH[4]);
1559  0369 7b17          	ld	a,(OFST-2,sp)
1560  036b 5f            	clrw	x
1561  036c 97            	ld	xl,a
1562  036d 7b18          	ld	a,(OFST-1,sp)
1563  036f 02            	rlwa	x,a
1564  0370 cd0000        	call	c_uitolx
1566  0373 96            	ldw	x,sp
1567  0374 1c000f        	addw	x,#OFST-10
1568  0377 cd0000        	call	c_rtol
1571                     ; 285 	 CapBuf = (CapBuf-HumB)*600/(HumA-HumB)+300;
1573  037a be02          	ldw	x,L733_HumA
1574  037c 72b00000      	subw	x,L143_HumB
1575  0380 cd0000        	call	c_uitolx
1577  0383 96            	ldw	x,sp
1578  0384 1c0005        	addw	x,#OFST-20
1579  0387 cd0000        	call	c_rtol
1582  038a be00          	ldw	x,L143_HumB
1583  038c cd0000        	call	c_uitolx
1585  038f 96            	ldw	x,sp
1586  0390 1c0001        	addw	x,#OFST-24
1587  0393 cd0000        	call	c_rtol
1590  0396 96            	ldw	x,sp
1591  0397 1c000f        	addw	x,#OFST-10
1592  039a cd0000        	call	c_ltor
1594  039d 96            	ldw	x,sp
1595  039e 1c0001        	addw	x,#OFST-24
1596  03a1 cd0000        	call	c_lsub
1598  03a4 ae0002        	ldw	x,#L24
1599  03a7 cd0000        	call	c_lmul
1601  03aa 96            	ldw	x,sp
1602  03ab 1c0005        	addw	x,#OFST-20
1603  03ae cd0000        	call	c_ldiv
1605  03b1 ae0006        	ldw	x,#L44
1606  03b4 cd0000        	call	c_ladd
1608  03b7 96            	ldw	x,sp
1609  03b8 1c000f        	addw	x,#OFST-10
1610  03bb cd0000        	call	c_rtol
1613                     ; 287 	 CapBuf = CapBuf+ 25*(TemBuf-250)/100;		
1615  03be 1e0a          	ldw	x,(OFST-15,sp)
1616  03c0 a619          	ld	a,#25
1617  03c2 cd0000        	call	c_bmulx
1619  03c5 1d186a        	subw	x,#6250
1620  03c8 a664          	ld	a,#100
1621  03ca cd0000        	call	c_sdivx
1623  03cd cd0000        	call	c_itolx
1625  03d0 96            	ldw	x,sp
1626  03d1 1c000f        	addw	x,#OFST-10
1627  03d4 cd0000        	call	c_lgadd
1630                     ; 289 	 if(CapBuf>1000)
1632  03d7 9c            	rvf
1633  03d8 96            	ldw	x,sp
1634  03d9 1c000f        	addw	x,#OFST-10
1635  03dc cd0000        	call	c_ltor
1637  03df ae000a        	ldw	x,#L64
1638  03e2 cd0000        	call	c_lcmp
1640  03e5 2f0c          	jrslt	L774
1641                     ; 290 	  CapBuf = 999;
1643  03e7 ae03e7        	ldw	x,#999
1644  03ea 1f11          	ldw	(OFST-8,sp),x
1645  03ec ae0000        	ldw	x,#0
1646  03ef 1f0f          	ldw	(OFST-10,sp),x
1649  03f1 2010          	jra	L105
1650  03f3               L774:
1651                     ; 291 	 else if(CapBuf<0)
1653  03f3 9c            	rvf
1654  03f4 9c            	rvf
1655  03f5 0d0f          	tnz	(OFST-10,sp)
1656  03f7 2e0a          	jrsge	L105
1657                     ; 292 		CapBuf = 0;
1659  03f9 ae0000        	ldw	x,#0
1660  03fc 1f11          	ldw	(OFST-8,sp),x
1661  03fe ae0000        	ldw	x,#0
1662  0401 1f0f          	ldw	(OFST-10,sp),x
1664  0403               L105:
1665                     ; 294 		*hum = (u16)CapBuf;//同样结果*10
1667  0403 1e1e          	ldw	x,(OFST+5,sp)
1668  0405 1611          	ldw	y,(OFST-8,sp)
1669  0407 ff            	ldw	(x),y
1670  0408               L574:
1671                     ; 297 	return errorflag;
1673  0408 7b13          	ld	a,(OFST-6,sp)
1676  040a 5b1b          	addw	sp,#27
1677  040c 81            	ret
1728                     	switch	.ubsct
1729  0000               L143_HumB:
1730  0000 0000          	ds.b	2
1731  0002               L733_HumA:
1732  0002 0000          	ds.b	2
1733                     	xdef	_Read_Rg
1734                     	xdef	_ResetMD
1735                     	xdef	_SHT3x_CheckCrc
1736                     	xdef	_POLYNOMIAL
1737                     	xdef	_read_byte
1738                     	xdef	_write_byte
1739                     	xdef	_SendACK
1740                     	xdef	_respons
1741                     	xdef	_stop
1742                     	xdef	_start
1743  0004               L3_ACK_ret:
1744  0004 00            	ds.b	1
1745                     	xdef	_ReadDHTC12_M
1746                     	xdef	_DHTC12_MInit
1747                     	xref	_delay
1748                     	switch	.const
1749  000e               L174:
1750  000e 43c80000      	dc.w	17352,0
1751  0012               L164:
1752  0012 41cccccc      	dc.w	16844,-13108
1753                     	xref.b	c_x
1773                     	xref	c_lcmp
1774                     	xref	c_lgadd
1775                     	xref	c_itolx
1776                     	xref	c_sdivx
1777                     	xref	c_bmulx
1778                     	xref	c_ladd
1779                     	xref	c_ldiv
1780                     	xref	c_lmul
1781                     	xref	c_lsub
1782                     	xref	c_ltor
1783                     	xref	c_rtol
1784                     	xref	c_uitolx
1785                     	xref	c_ftoi
1786                     	xref	c_fadd
1787                     	xref	c_fdiv
1788                     	xref	c_itof
1789                     	end
