   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.12 - 20 Jun 2018
   3                     ; Generator (Limited) V4.4.8 - 20 Jun 2018
  42                     ; 96 void Timer4Init(void)
  42                     ; 97 {
  44                     	switch	.text
  45  0000               _Timer4Init:
  49                     ; 98 	TIM4->IER = 0X00;//禁止中断
  51  0000 725f5343      	clr	21315
  52                     ; 103 	TIM4->PSCR = 0x6;
  54  0004 35065347      	mov	21319,#6
  55                     ; 104 	TIM4->ARR = 0xff;
  57  0008 35ff5348      	mov	21320,#255
  58                     ; 105 	TIM4->CNTR = 0;
  60  000c 725f5346      	clr	21318
  61                     ; 106 	TIM4->EGR = TIM4_PSCRELOADMODE_IMMEDIATE;
  63  0010 35015345      	mov	21317,#1
  64                     ; 107 	TIM4->SR1 = 0;
  66  0014 725f5344      	clr	21316
  67                     ; 108 	TIM4->IER = TIM4_IT_UPDATE;
  69  0018 35015343      	mov	21315,#1
  70                     ; 109 	TIM4->CR1 |= TIM4_CR1_CEN;//启动
  72  001c 72105340      	bset	21312,#0
  73                     ; 110 }
  76  0020 81            	ret
  79                     .const:	section	.text
  80  0000               _Disdat:
  81  0000 3f            	dc.b	63
  82  0001 06            	dc.b	6
  83  0002 5b            	dc.b	91
  84  0003 4f            	dc.b	79
  85  0004 66            	dc.b	102
  86  0005 6d            	dc.b	109
  87  0006 7d            	dc.b	125
  88  0007 07            	dc.b	7
  89  0008 7f            	dc.b	127
  90  0009 6f            	dc.b	111
  91  000a 40            	dc.b	64
  92  000b 79            	dc.b	121
  93  000c 50            	dc.b	80
  94  000d 5c            	dc.b	92
  95  000e 39            	dc.b	57
  96  000f 76            	dc.b	118
  97  0010 00            	dc.b	0
  98                     	bsct
  99  0000               L53_DotFlag:
 100  0000 00            	dc.b	0
 166                     ; 116 void reflashDat(u16 TemBl,u16 HumBl)
 166                     ; 117 {
 167                     	switch	.text
 168  0021               _reflashDat:
 170  0021 89            	pushw	x
 171  0022 89            	pushw	x
 172       00000002      OFST:	set	2
 175                     ; 120 	TemGG = (s16)TemBl;
 177  0023 1f01          	ldw	(OFST-1,sp),x
 179                     ; 121 	if(TemGG<0)
 181  0025 9c            	rvf
 182  0026 1e01          	ldw	x,(OFST-1,sp)
 183  0028 2e32          	jrsge	L17
 184                     ; 123 		DotFlag = 0;//无小数点
 186  002a 3f00          	clr	L53_DotFlag
 187                     ; 124 		dat0 = 10;//-
 189  002c 350a0005      	mov	L12_dat0,#10
 190                     ; 125 		TemGG = -TemGG;
 192  0030 1e01          	ldw	x,(OFST-1,sp)
 193  0032 50            	negw	x
 194  0033 1f01          	ldw	(OFST-1,sp),x
 196                     ; 126 		dat1 = TemGG/100;
 198  0035 1e01          	ldw	x,(OFST-1,sp)
 199  0037 a664          	ld	a,#100
 200  0039 cd0000        	call	c_sdivx
 202  003c 01            	rrwa	x,a
 203  003d b704          	ld	L32_dat1,a
 204  003f 02            	rlwa	x,a
 205                     ; 127 		if(dat1==0)dat1 = 16;// 高位不显示
 207  0040 3d04          	tnz	L32_dat1
 208  0042 2604          	jrne	L37
 211  0044 35100004      	mov	L32_dat1,#16
 212  0048               L37:
 213                     ; 128 		buf = TemGG%100;
 215  0048 1e01          	ldw	x,(OFST-1,sp)
 216  004a a664          	ld	a,#100
 217  004c cd0000        	call	c_smodx
 219  004f 1f01          	ldw	(OFST-1,sp),x
 221                     ; 129 		dat2 = buf/10;
 223  0051 1e01          	ldw	x,(OFST-1,sp)
 224  0053 a60a          	ld	a,#10
 225  0055 62            	div	x,a
 226  0056 01            	rrwa	x,a
 227  0057 b703          	ld	L52_dat2,a
 228  0059 02            	rlwa	x,a
 230  005a 2034          	jra	L57
 231  005c               L17:
 232                     ; 132 		DotFlag = 1;//小数点
 234  005c 35010000      	mov	L53_DotFlag,#1
 235                     ; 133 		dat0 = TemGG/100;
 237  0060 1e01          	ldw	x,(OFST-1,sp)
 238  0062 a664          	ld	a,#100
 239  0064 cd0000        	call	c_sdivx
 241  0067 01            	rrwa	x,a
 242  0068 b705          	ld	L12_dat0,a
 243  006a 02            	rlwa	x,a
 244                     ; 134 		if(dat0==0)dat0 = 16;// 高位不显示
 246  006b 3d05          	tnz	L12_dat0
 247  006d 2604          	jrne	L77
 250  006f 35100005      	mov	L12_dat0,#16
 251  0073               L77:
 252                     ; 135 		buf = TemGG%100;
 254  0073 1e01          	ldw	x,(OFST-1,sp)
 255  0075 a664          	ld	a,#100
 256  0077 cd0000        	call	c_smodx
 258  007a 1f01          	ldw	(OFST-1,sp),x
 260                     ; 136 		dat1 = buf/10;
 262  007c 1e01          	ldw	x,(OFST-1,sp)
 263  007e a60a          	ld	a,#10
 264  0080 62            	div	x,a
 265  0081 01            	rrwa	x,a
 266  0082 b704          	ld	L32_dat1,a
 267  0084 02            	rlwa	x,a
 268                     ; 137 		dat2 = buf%10;
 270  0085 1e01          	ldw	x,(OFST-1,sp)
 271  0087 a60a          	ld	a,#10
 272  0089 62            	div	x,a
 273  008a 5f            	clrw	x
 274  008b 97            	ld	xl,a
 275  008c 01            	rrwa	x,a
 276  008d b703          	ld	L52_dat2,a
 277  008f 02            	rlwa	x,a
 278  0090               L57:
 279                     ; 141 	if(HumBl!=0xffff)
 281  0090 1e07          	ldw	x,(OFST+5,sp)
 282  0092 a3ffff        	cpw	x,#65535
 283  0095 2728          	jreq	L101
 284                     ; 143 		dat3 = HumBl/100;
 286  0097 1e07          	ldw	x,(OFST+5,sp)
 287  0099 a664          	ld	a,#100
 288  009b 62            	div	x,a
 289  009c 01            	rrwa	x,a
 290  009d b702          	ld	L72_dat3,a
 291  009f 02            	rlwa	x,a
 292                     ; 144 		buf = HumBl%100;
 294  00a0 1e07          	ldw	x,(OFST+5,sp)
 295  00a2 a664          	ld	a,#100
 296  00a4 62            	div	x,a
 297  00a5 5f            	clrw	x
 298  00a6 97            	ld	xl,a
 299  00a7 1f01          	ldw	(OFST-1,sp),x
 301                     ; 145 		dat4 = buf/10;
 303  00a9 1e01          	ldw	x,(OFST-1,sp)
 304  00ab a60a          	ld	a,#10
 305  00ad 62            	div	x,a
 306  00ae 01            	rrwa	x,a
 307  00af b701          	ld	L13_dat4,a
 308  00b1 02            	rlwa	x,a
 309                     ; 146 		dat5 = buf%10;
 311  00b2 1e01          	ldw	x,(OFST-1,sp)
 312  00b4 a60a          	ld	a,#10
 313  00b6 62            	div	x,a
 314  00b7 5f            	clrw	x
 315  00b8 97            	ld	xl,a
 316  00b9 01            	rrwa	x,a
 317  00ba b700          	ld	L33_dat5,a
 318  00bc 02            	rlwa	x,a
 320  00bd 2018          	jra	L301
 321  00bf               L101:
 322                     ; 149 		dat0 = 10;
 324  00bf 350a0005      	mov	L12_dat0,#10
 325                     ; 150 		dat1 = 10;
 327  00c3 350a0004      	mov	L32_dat1,#10
 328                     ; 151 		dat2 = 10;
 330  00c7 350a0003      	mov	L52_dat2,#10
 331                     ; 152 		dat3 = 10;
 333  00cb 350a0002      	mov	L72_dat3,#10
 334                     ; 153 		dat4 = 10;
 336  00cf 350a0001      	mov	L13_dat4,#10
 337                     ; 154 		dat5 = 10;
 339  00d3 350a0000      	mov	L33_dat5,#10
 340  00d7               L301:
 341                     ; 156 }
 344  00d7 5b04          	addw	sp,#4
 345  00d9 81            	ret
 348                     	bsct
 349  0001               L501_Disnum:
 350  0001 00            	dc.b	0
 391                     ; 159 @far @interrupt void TIM4_UPD_OVF_Inter(void)
 391                     ; 160 {
 393                     	switch	.text
 394  00da               f_TIM4_UPD_OVF_Inter:
 396  00da 8a            	push	cc
 397  00db 84            	pop	a
 398  00dc a4bf          	and	a,#191
 399  00de 88            	push	a
 400  00df 86            	pop	cc
 401  00e0 3b0002        	push	c_x+2
 402  00e3 be00          	ldw	x,c_x
 403  00e5 89            	pushw	x
 404  00e6 3b0002        	push	c_y+2
 405  00e9 be00          	ldw	x,c_y
 406  00eb 89            	pushw	x
 409                     ; 163 	TIM4->SR1 = 0;
 411  00ec 725f5344      	clr	21316
 412                     ; 167 		if(++Disnum>5)Disnum = 0;
 414  00f0 3c01          	inc	L501_Disnum
 415  00f2 b601          	ld	a,L501_Disnum
 416  00f4 a106          	cp	a,#6
 417  00f6 2502          	jrult	L341
 420  00f8 3f01          	clr	L501_Disnum
 421  00fa               L341:
 422                     ; 169 		switch(Disnum)
 424  00fa b601          	ld	a,L501_Disnum
 426                     ; 204 			default:
 426                     ; 205 				break;
 427  00fc 4d            	tnz	a
 428  00fd 2717          	jreq	L701
 429  00ff 4a            	dec	a
 430  0100 2728          	jreq	L111
 431  0102 4a            	dec	a
 432  0103 274b          	jreq	L311
 433  0105 4a            	dec	a
 434  0106 275c          	jreq	L511
 435  0108 4a            	dec	a
 436  0109 276d          	jreq	L711
 437  010b 4a            	dec	a
 438  010c 2604ac8e018e  	jreq	L121
 439  0112 aca001a0      	jra	L741
 440  0116               L701:
 441                     ; 171 			case 0:
 441                     ; 172 					Dis_L6_SET();
 443  0116 721c500a      	bset	20490,#6
 444                     ; 173 					WR_595(Disdat[dat0]);
 446  011a b605          	ld	a,L12_dat0
 447  011c 5f            	clrw	x
 448  011d 97            	ld	xl,a
 449  011e d60000        	ld	a,(_Disdat,x)
 450  0121 cd0000        	call	_WR_595
 452                     ; 174 					Dis_L1_CLR();
 454  0124 721b5005      	bres	20485,#5
 455                     ; 175 				break;
 457  0128 2076          	jra	L741
 458  012a               L111:
 459                     ; 176 			case 1:
 459                     ; 177 					Dis_L1_SET();
 461  012a 721a5005      	bset	20485,#5
 462                     ; 178 					if(DotFlag)
 464  012e 3d00          	tnz	L53_DotFlag
 465  0130 270e          	jreq	L151
 466                     ; 179 						WR_595(Disdat[dat1]|0x80);
 468  0132 b604          	ld	a,L32_dat1
 469  0134 5f            	clrw	x
 470  0135 97            	ld	xl,a
 471  0136 d60000        	ld	a,(_Disdat,x)
 472  0139 aa80          	or	a,#128
 473  013b cd0000        	call	_WR_595
 476  013e 200a          	jra	L351
 477  0140               L151:
 478                     ; 181 						WR_595(Disdat[dat1]);
 480  0140 b604          	ld	a,L32_dat1
 481  0142 5f            	clrw	x
 482  0143 97            	ld	xl,a
 483  0144 d60000        	ld	a,(_Disdat,x)
 484  0147 cd0000        	call	_WR_595
 486  014a               L351:
 487                     ; 182 					Dis_L2_CLR();
 489  014a 72195005      	bres	20485,#4
 490                     ; 183 				break;
 492  014e 2050          	jra	L741
 493  0150               L311:
 494                     ; 184 			case 2:
 494                     ; 185 					Dis_L2_SET();
 496  0150 72185005      	bset	20485,#4
 497                     ; 186 					WR_595(Disdat[dat2]);
 499  0154 b603          	ld	a,L52_dat2
 500  0156 5f            	clrw	x
 501  0157 97            	ld	xl,a
 502  0158 d60000        	ld	a,(_Disdat,x)
 503  015b cd0000        	call	_WR_595
 505                     ; 187 					Dis_L3_CLR();
 507  015e 7217500a      	bres	20490,#3
 508                     ; 188 				break;
 510  0162 203c          	jra	L741
 511  0164               L511:
 512                     ; 189 			case 3:
 512                     ; 190 					Dis_L3_SET();					
 514  0164 7216500a      	bset	20490,#3
 515                     ; 191 					WR_595(Disdat[dat3]);
 517  0168 b602          	ld	a,L72_dat3
 518  016a 5f            	clrw	x
 519  016b 97            	ld	xl,a
 520  016c d60000        	ld	a,(_Disdat,x)
 521  016f cd0000        	call	_WR_595
 523                     ; 192 					Dis_L4_CLR();
 525  0172 7219500a      	bres	20490,#4
 526                     ; 193 				break;
 528  0176 2028          	jra	L741
 529  0178               L711:
 530                     ; 194 			case 4:
 530                     ; 195 					Dis_L4_SET();					
 532  0178 7218500a      	bset	20490,#4
 533                     ; 196 					WR_595(Disdat[dat4]|0x80);
 535  017c b601          	ld	a,L13_dat4
 536  017e 5f            	clrw	x
 537  017f 97            	ld	xl,a
 538  0180 d60000        	ld	a,(_Disdat,x)
 539  0183 aa80          	or	a,#128
 540  0185 cd0000        	call	_WR_595
 542                     ; 197 					Dis_L5_CLR();
 544  0188 721b500a      	bres	20490,#5
 545                     ; 198 				break;
 547  018c 2012          	jra	L741
 548  018e               L121:
 549                     ; 199 			case 5:
 549                     ; 200 					Dis_L5_SET();					
 551  018e 721a500a      	bset	20490,#5
 552                     ; 201 					WR_595(Disdat[dat5]);
 554  0192 b600          	ld	a,L33_dat5
 555  0194 5f            	clrw	x
 556  0195 97            	ld	xl,a
 557  0196 d60000        	ld	a,(_Disdat,x)
 558  0199 cd0000        	call	_WR_595
 560                     ; 202 					Dis_L6_CLR();
 562  019c 721d500a      	bres	20490,#6
 563                     ; 203 				break;
 565  01a0               L321:
 566                     ; 204 			default:
 566                     ; 205 				break;
 568  01a0               L741:
 569                     ; 208 }
 572  01a0 85            	popw	x
 573  01a1 bf00          	ldw	c_y,x
 574  01a3 320002        	pop	c_y+2
 575  01a6 85            	popw	x
 576  01a7 bf00          	ldw	c_x,x
 577  01a9 320002        	pop	c_x+2
 578  01ac 80            	iret
 612                     ; 343 void delay(u16 n)
 612                     ; 344 {
 614                     	switch	.text
 615  01ad               _delay:
 617  01ad 89            	pushw	x
 618       00000000      OFST:	set	0
 621  01ae 2004          	jra	L571
 622  01b0               L371:
 623                     ; 347 			_asm("nop");_asm("nop");
 626  01b0 9d            nop
 631  01b1 9d            nop
 633                     ; 348       _asm("nop");_asm("nop");
 636  01b2 9d            nop
 641  01b3 9d            nop
 643  01b4               L571:
 644                     ; 345 	  while(n--)
 646  01b4 1e01          	ldw	x,(OFST+1,sp)
 647  01b6 1d0001        	subw	x,#1
 648  01b9 1f01          	ldw	(OFST+1,sp),x
 649  01bb 1c0001        	addw	x,#1
 650  01be a30000        	cpw	x,#0
 651  01c1 26ed          	jrne	L371
 652                     ; 350 }
 655  01c3 85            	popw	x
 656  01c4 81            	ret
 690                     ; 352 void DelayXus(uchar n)
 690                     ; 353 {
 691                     	switch	.text
 692  01c5               _DelayXus:
 694  01c5 88            	push	a
 695       00000000      OFST:	set	0
 698  01c6 2002          	jra	L122
 699  01c8               L712:
 700                     ; 356 			_asm("nop");
 703  01c8 9d            nop
 705                     ; 357       _asm("nop");
 708  01c9 9d            nop
 710  01ca               L122:
 711                     ; 354     while (n--)
 713  01ca 7b01          	ld	a,(OFST+1,sp)
 714  01cc 0a01          	dec	(OFST+1,sp)
 715  01ce 4d            	tnz	a
 716  01cf 26f7          	jrne	L712
 717                     ; 359 }
 720  01d1 84            	pop	a
 721  01d2 81            	ret
 809                     	xdef	_DelayXus
 810                     	xdef	f_TIM4_UPD_OVF_Inter
 811                     	switch	.ubsct
 812  0000               L33_dat5:
 813  0000 00            	ds.b	1
 814  0001               L13_dat4:
 815  0001 00            	ds.b	1
 816  0002               L72_dat3:
 817  0002 00            	ds.b	1
 818  0003               L52_dat2:
 819  0003 00            	ds.b	1
 820  0004               L32_dat1:
 821  0004 00            	ds.b	1
 822  0005               L12_dat0:
 823  0005 00            	ds.b	1
 824                     	xdef	_Disdat
 825                     	xref	_WR_595
 826                     	xdef	_delay
 827                     	xdef	_Timer4Init
 828                     	xdef	_reflashDat
 829                     	xref.b	c_x
 830                     	xref.b	c_y
 850                     	xref	c_smodx
 851                     	xref	c_sdivx
 852                     	end
