   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.12 - 20 Jun 2018
   3                     ; Generator (Limited) V4.4.8 - 20 Jun 2018
  14                     .const:	section	.text
  15  0000               _HSIDivFactor:
  16  0000 01            	dc.b	1
  17  0001 02            	dc.b	2
  18  0002 04            	dc.b	4
  19  0003 08            	dc.b	8
  20  0004               _CLKPrescTable:
  21  0004 01            	dc.b	1
  22  0005 02            	dc.b	2
  23  0006 04            	dc.b	4
  24  0007 08            	dc.b	8
  25  0008 0a            	dc.b	10
  26  0009 10            	dc.b	16
  27  000a 14            	dc.b	20
  28  000b 28            	dc.b	40
  57                     ; 66 void CLK_DeInit(void)
  57                     ; 67 {
  59                     	switch	.text
  60  0000               _CLK_DeInit:
  64                     ; 69     CLK->ICKR = CLK_ICKR_RESET_VALUE;
  66  0000 350150c0      	mov	20672,#1
  67                     ; 70     CLK->ECKR = CLK_ECKR_RESET_VALUE;
  69  0004 725f50c1      	clr	20673
  70                     ; 71     CLK->SWR  = CLK_SWR_RESET_VALUE;
  72  0008 35e150c4      	mov	20676,#225
  73                     ; 72     CLK->SWCR = CLK_SWCR_RESET_VALUE;
  75  000c 725f50c5      	clr	20677
  76                     ; 73     CLK->CKDIVR = CLK_CKDIVR_RESET_VALUE;
  78  0010 351850c6      	mov	20678,#24
  79                     ; 74     CLK->PCKENR1 = CLK_PCKENR1_RESET_VALUE;
  81  0014 35ff50c7      	mov	20679,#255
  82                     ; 75     CLK->PCKENR2 = CLK_PCKENR2_RESET_VALUE;
  84  0018 35ff50ca      	mov	20682,#255
  85                     ; 76     CLK->CSSR = CLK_CSSR_RESET_VALUE;
  87  001c 725f50c8      	clr	20680
  88                     ; 77     CLK->CCOR = CLK_CCOR_RESET_VALUE;
  90  0020 725f50c9      	clr	20681
  92  0024               L52:
  93                     ; 78     while ((CLK->CCOR & CLK_CCOR_CCOEN)!= 0)
  95  0024 c650c9        	ld	a,20681
  96  0027 a501          	bcp	a,#1
  97  0029 26f9          	jrne	L52
  98                     ; 80     CLK->CCOR = CLK_CCOR_RESET_VALUE;
 100  002b 725f50c9      	clr	20681
 101                     ; 81     CLK->HSITRIMR = CLK_HSITRIMR_RESET_VALUE;
 103  002f 725f50cc      	clr	20684
 104                     ; 82     CLK->SWIMCCR = CLK_SWIMCCR_RESET_VALUE;
 106  0033 725f50cd      	clr	20685
 107                     ; 84 }
 110  0037 81            	ret
 167                     ; 95 void CLK_FastHaltWakeUpCmd(FunctionalState NewState)
 167                     ; 96 {
 168                     	switch	.text
 169  0038               _CLK_FastHaltWakeUpCmd:
 171  0038 88            	push	a
 172       00000000      OFST:	set	0
 175                     ; 99     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 177  0039 4d            	tnz	a
 178  003a 2704          	jreq	L21
 179  003c a101          	cp	a,#1
 180  003e 2603          	jrne	L01
 181  0040               L21:
 182  0040 4f            	clr	a
 183  0041 2010          	jra	L41
 184  0043               L01:
 185  0043 ae0063        	ldw	x,#99
 186  0046 89            	pushw	x
 187  0047 ae0000        	ldw	x,#0
 188  004a 89            	pushw	x
 189  004b ae000c        	ldw	x,#L75
 190  004e cd0000        	call	_assert_failed
 192  0051 5b04          	addw	sp,#4
 193  0053               L41:
 194                     ; 101     if (NewState != DISABLE)
 196  0053 0d01          	tnz	(OFST+1,sp)
 197  0055 2706          	jreq	L16
 198                     ; 104         CLK->ICKR |= CLK_ICKR_FHWU;
 200  0057 721450c0      	bset	20672,#2
 202  005b 2004          	jra	L36
 203  005d               L16:
 204                     ; 109         CLK->ICKR &= (uint8_t)(~CLK_ICKR_FHWU);
 206  005d 721550c0      	bres	20672,#2
 207  0061               L36:
 208                     ; 112 }
 211  0061 84            	pop	a
 212  0062 81            	ret
 248                     ; 119 void CLK_HSECmd(FunctionalState NewState)
 248                     ; 120 {
 249                     	switch	.text
 250  0063               _CLK_HSECmd:
 252  0063 88            	push	a
 253       00000000      OFST:	set	0
 256                     ; 123     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 258  0064 4d            	tnz	a
 259  0065 2704          	jreq	L22
 260  0067 a101          	cp	a,#1
 261  0069 2603          	jrne	L02
 262  006b               L22:
 263  006b 4f            	clr	a
 264  006c 2010          	jra	L42
 265  006e               L02:
 266  006e ae007b        	ldw	x,#123
 267  0071 89            	pushw	x
 268  0072 ae0000        	ldw	x,#0
 269  0075 89            	pushw	x
 270  0076 ae000c        	ldw	x,#L75
 271  0079 cd0000        	call	_assert_failed
 273  007c 5b04          	addw	sp,#4
 274  007e               L42:
 275                     ; 125     if (NewState != DISABLE)
 277  007e 0d01          	tnz	(OFST+1,sp)
 278  0080 2706          	jreq	L301
 279                     ; 128         CLK->ECKR |= CLK_ECKR_HSEEN;
 281  0082 721050c1      	bset	20673,#0
 283  0086 2004          	jra	L501
 284  0088               L301:
 285                     ; 133         CLK->ECKR &= (uint8_t)(~CLK_ECKR_HSEEN);
 287  0088 721150c1      	bres	20673,#0
 288  008c               L501:
 289                     ; 136 }
 292  008c 84            	pop	a
 293  008d 81            	ret
 329                     ; 143 void CLK_HSICmd(FunctionalState NewState)
 329                     ; 144 {
 330                     	switch	.text
 331  008e               _CLK_HSICmd:
 333  008e 88            	push	a
 334       00000000      OFST:	set	0
 337                     ; 147     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 339  008f 4d            	tnz	a
 340  0090 2704          	jreq	L23
 341  0092 a101          	cp	a,#1
 342  0094 2603          	jrne	L03
 343  0096               L23:
 344  0096 4f            	clr	a
 345  0097 2010          	jra	L43
 346  0099               L03:
 347  0099 ae0093        	ldw	x,#147
 348  009c 89            	pushw	x
 349  009d ae0000        	ldw	x,#0
 350  00a0 89            	pushw	x
 351  00a1 ae000c        	ldw	x,#L75
 352  00a4 cd0000        	call	_assert_failed
 354  00a7 5b04          	addw	sp,#4
 355  00a9               L43:
 356                     ; 149     if (NewState != DISABLE)
 358  00a9 0d01          	tnz	(OFST+1,sp)
 359  00ab 2706          	jreq	L521
 360                     ; 152         CLK->ICKR |= CLK_ICKR_HSIEN;
 362  00ad 721050c0      	bset	20672,#0
 364  00b1 2004          	jra	L721
 365  00b3               L521:
 366                     ; 157         CLK->ICKR &= (uint8_t)(~CLK_ICKR_HSIEN);
 368  00b3 721150c0      	bres	20672,#0
 369  00b7               L721:
 370                     ; 160 }
 373  00b7 84            	pop	a
 374  00b8 81            	ret
 410                     ; 167 void CLK_LSICmd(FunctionalState NewState)
 410                     ; 168 {
 411                     	switch	.text
 412  00b9               _CLK_LSICmd:
 414  00b9 88            	push	a
 415       00000000      OFST:	set	0
 418                     ; 171     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 420  00ba 4d            	tnz	a
 421  00bb 2704          	jreq	L24
 422  00bd a101          	cp	a,#1
 423  00bf 2603          	jrne	L04
 424  00c1               L24:
 425  00c1 4f            	clr	a
 426  00c2 2010          	jra	L44
 427  00c4               L04:
 428  00c4 ae00ab        	ldw	x,#171
 429  00c7 89            	pushw	x
 430  00c8 ae0000        	ldw	x,#0
 431  00cb 89            	pushw	x
 432  00cc ae000c        	ldw	x,#L75
 433  00cf cd0000        	call	_assert_failed
 435  00d2 5b04          	addw	sp,#4
 436  00d4               L44:
 437                     ; 173     if (NewState != DISABLE)
 439  00d4 0d01          	tnz	(OFST+1,sp)
 440  00d6 2706          	jreq	L741
 441                     ; 176         CLK->ICKR |= CLK_ICKR_LSIEN;
 443  00d8 721650c0      	bset	20672,#3
 445  00dc 2004          	jra	L151
 446  00de               L741:
 447                     ; 181         CLK->ICKR &= (uint8_t)(~CLK_ICKR_LSIEN);
 449  00de 721750c0      	bres	20672,#3
 450  00e2               L151:
 451                     ; 184 }
 454  00e2 84            	pop	a
 455  00e3 81            	ret
 491                     ; 192 void CLK_CCOCmd(FunctionalState NewState)
 491                     ; 193 {
 492                     	switch	.text
 493  00e4               _CLK_CCOCmd:
 495  00e4 88            	push	a
 496       00000000      OFST:	set	0
 499                     ; 196     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 501  00e5 4d            	tnz	a
 502  00e6 2704          	jreq	L25
 503  00e8 a101          	cp	a,#1
 504  00ea 2603          	jrne	L05
 505  00ec               L25:
 506  00ec 4f            	clr	a
 507  00ed 2010          	jra	L45
 508  00ef               L05:
 509  00ef ae00c4        	ldw	x,#196
 510  00f2 89            	pushw	x
 511  00f3 ae0000        	ldw	x,#0
 512  00f6 89            	pushw	x
 513  00f7 ae000c        	ldw	x,#L75
 514  00fa cd0000        	call	_assert_failed
 516  00fd 5b04          	addw	sp,#4
 517  00ff               L45:
 518                     ; 198     if (NewState != DISABLE)
 520  00ff 0d01          	tnz	(OFST+1,sp)
 521  0101 2706          	jreq	L171
 522                     ; 201         CLK->CCOR |= CLK_CCOR_CCOEN;
 524  0103 721050c9      	bset	20681,#0
 526  0107 2004          	jra	L371
 527  0109               L171:
 528                     ; 206         CLK->CCOR &= (uint8_t)(~CLK_CCOR_CCOEN);
 530  0109 721150c9      	bres	20681,#0
 531  010d               L371:
 532                     ; 209 }
 535  010d 84            	pop	a
 536  010e 81            	ret
 572                     ; 218 void CLK_ClockSwitchCmd(FunctionalState NewState)
 572                     ; 219 {
 573                     	switch	.text
 574  010f               _CLK_ClockSwitchCmd:
 576  010f 88            	push	a
 577       00000000      OFST:	set	0
 580                     ; 222     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 582  0110 4d            	tnz	a
 583  0111 2704          	jreq	L26
 584  0113 a101          	cp	a,#1
 585  0115 2603          	jrne	L06
 586  0117               L26:
 587  0117 4f            	clr	a
 588  0118 2010          	jra	L46
 589  011a               L06:
 590  011a ae00de        	ldw	x,#222
 591  011d 89            	pushw	x
 592  011e ae0000        	ldw	x,#0
 593  0121 89            	pushw	x
 594  0122 ae000c        	ldw	x,#L75
 595  0125 cd0000        	call	_assert_failed
 597  0128 5b04          	addw	sp,#4
 598  012a               L46:
 599                     ; 224     if (NewState != DISABLE )
 601  012a 0d01          	tnz	(OFST+1,sp)
 602  012c 2706          	jreq	L312
 603                     ; 227         CLK->SWCR |= CLK_SWCR_SWEN;
 605  012e 721250c5      	bset	20677,#1
 607  0132 2004          	jra	L512
 608  0134               L312:
 609                     ; 232         CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWEN);
 611  0134 721350c5      	bres	20677,#1
 612  0138               L512:
 613                     ; 235 }
 616  0138 84            	pop	a
 617  0139 81            	ret
 654                     ; 245 void CLK_SlowActiveHaltWakeUpCmd(FunctionalState NewState)
 654                     ; 246 {
 655                     	switch	.text
 656  013a               _CLK_SlowActiveHaltWakeUpCmd:
 658  013a 88            	push	a
 659       00000000      OFST:	set	0
 662                     ; 249     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 664  013b 4d            	tnz	a
 665  013c 2704          	jreq	L27
 666  013e a101          	cp	a,#1
 667  0140 2603          	jrne	L07
 668  0142               L27:
 669  0142 4f            	clr	a
 670  0143 2010          	jra	L47
 671  0145               L07:
 672  0145 ae00f9        	ldw	x,#249
 673  0148 89            	pushw	x
 674  0149 ae0000        	ldw	x,#0
 675  014c 89            	pushw	x
 676  014d ae000c        	ldw	x,#L75
 677  0150 cd0000        	call	_assert_failed
 679  0153 5b04          	addw	sp,#4
 680  0155               L47:
 681                     ; 251     if (NewState != DISABLE)
 683  0155 0d01          	tnz	(OFST+1,sp)
 684  0157 2706          	jreq	L532
 685                     ; 254         CLK->ICKR |= CLK_ICKR_SWUAH;
 687  0159 721a50c0      	bset	20672,#5
 689  015d 2004          	jra	L732
 690  015f               L532:
 691                     ; 259         CLK->ICKR &= (uint8_t)(~CLK_ICKR_SWUAH);
 693  015f 721b50c0      	bres	20672,#5
 694  0163               L732:
 695                     ; 262 }
 698  0163 84            	pop	a
 699  0164 81            	ret
 859                     ; 272 void CLK_PeripheralClockConfig(CLK_Peripheral_TypeDef CLK_Peripheral, FunctionalState NewState)
 859                     ; 273 {
 860                     	switch	.text
 861  0165               _CLK_PeripheralClockConfig:
 863  0165 89            	pushw	x
 864       00000000      OFST:	set	0
 867                     ; 276     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 869  0166 9f            	ld	a,xl
 870  0167 4d            	tnz	a
 871  0168 2705          	jreq	L201
 872  016a 9f            	ld	a,xl
 873  016b a101          	cp	a,#1
 874  016d 2603          	jrne	L001
 875  016f               L201:
 876  016f 4f            	clr	a
 877  0170 2010          	jra	L401
 878  0172               L001:
 879  0172 ae0114        	ldw	x,#276
 880  0175 89            	pushw	x
 881  0176 ae0000        	ldw	x,#0
 882  0179 89            	pushw	x
 883  017a ae000c        	ldw	x,#L75
 884  017d cd0000        	call	_assert_failed
 886  0180 5b04          	addw	sp,#4
 887  0182               L401:
 888                     ; 277     assert_param(IS_CLK_PERIPHERAL_OK(CLK_Peripheral));
 890  0182 0d01          	tnz	(OFST+1,sp)
 891  0184 274e          	jreq	L011
 892  0186 7b01          	ld	a,(OFST+1,sp)
 893  0188 a101          	cp	a,#1
 894  018a 2748          	jreq	L011
 895  018c 7b01          	ld	a,(OFST+1,sp)
 896  018e a103          	cp	a,#3
 897  0190 2742          	jreq	L011
 898  0192 7b01          	ld	a,(OFST+1,sp)
 899  0194 a103          	cp	a,#3
 900  0196 273c          	jreq	L011
 901  0198 7b01          	ld	a,(OFST+1,sp)
 902  019a a103          	cp	a,#3
 903  019c 2736          	jreq	L011
 904  019e 7b01          	ld	a,(OFST+1,sp)
 905  01a0 a104          	cp	a,#4
 906  01a2 2730          	jreq	L011
 907  01a4 7b01          	ld	a,(OFST+1,sp)
 908  01a6 a105          	cp	a,#5
 909  01a8 272a          	jreq	L011
 910  01aa 7b01          	ld	a,(OFST+1,sp)
 911  01ac a105          	cp	a,#5
 912  01ae 2724          	jreq	L011
 913  01b0 7b01          	ld	a,(OFST+1,sp)
 914  01b2 a104          	cp	a,#4
 915  01b4 271e          	jreq	L011
 916  01b6 7b01          	ld	a,(OFST+1,sp)
 917  01b8 a106          	cp	a,#6
 918  01ba 2718          	jreq	L011
 919  01bc 7b01          	ld	a,(OFST+1,sp)
 920  01be a107          	cp	a,#7
 921  01c0 2712          	jreq	L011
 922  01c2 7b01          	ld	a,(OFST+1,sp)
 923  01c4 a117          	cp	a,#23
 924  01c6 270c          	jreq	L011
 925  01c8 7b01          	ld	a,(OFST+1,sp)
 926  01ca a113          	cp	a,#19
 927  01cc 2706          	jreq	L011
 928  01ce 7b01          	ld	a,(OFST+1,sp)
 929  01d0 a112          	cp	a,#18
 930  01d2 2603          	jrne	L601
 931  01d4               L011:
 932  01d4 4f            	clr	a
 933  01d5 2010          	jra	L211
 934  01d7               L601:
 935  01d7 ae0115        	ldw	x,#277
 936  01da 89            	pushw	x
 937  01db ae0000        	ldw	x,#0
 938  01de 89            	pushw	x
 939  01df ae000c        	ldw	x,#L75
 940  01e2 cd0000        	call	_assert_failed
 942  01e5 5b04          	addw	sp,#4
 943  01e7               L211:
 944                     ; 279     if (((uint8_t)CLK_Peripheral & (uint8_t)0x10) == 0x00)
 946  01e7 7b01          	ld	a,(OFST+1,sp)
 947  01e9 a510          	bcp	a,#16
 948  01eb 2633          	jrne	L323
 949                     ; 281         if (NewState != DISABLE)
 951  01ed 0d02          	tnz	(OFST+2,sp)
 952  01ef 2717          	jreq	L523
 953                     ; 284             CLK->PCKENR1 |= (uint8_t)((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F));
 955  01f1 7b01          	ld	a,(OFST+1,sp)
 956  01f3 a40f          	and	a,#15
 957  01f5 5f            	clrw	x
 958  01f6 97            	ld	xl,a
 959  01f7 a601          	ld	a,#1
 960  01f9 5d            	tnzw	x
 961  01fa 2704          	jreq	L411
 962  01fc               L611:
 963  01fc 48            	sll	a
 964  01fd 5a            	decw	x
 965  01fe 26fc          	jrne	L611
 966  0200               L411:
 967  0200 ca50c7        	or	a,20679
 968  0203 c750c7        	ld	20679,a
 970  0206 2049          	jra	L133
 971  0208               L523:
 972                     ; 289             CLK->PCKENR1 &= (uint8_t)(~(uint8_t)(((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F))));
 974  0208 7b01          	ld	a,(OFST+1,sp)
 975  020a a40f          	and	a,#15
 976  020c 5f            	clrw	x
 977  020d 97            	ld	xl,a
 978  020e a601          	ld	a,#1
 979  0210 5d            	tnzw	x
 980  0211 2704          	jreq	L021
 981  0213               L221:
 982  0213 48            	sll	a
 983  0214 5a            	decw	x
 984  0215 26fc          	jrne	L221
 985  0217               L021:
 986  0217 43            	cpl	a
 987  0218 c450c7        	and	a,20679
 988  021b c750c7        	ld	20679,a
 989  021e 2031          	jra	L133
 990  0220               L323:
 991                     ; 294         if (NewState != DISABLE)
 993  0220 0d02          	tnz	(OFST+2,sp)
 994  0222 2717          	jreq	L333
 995                     ; 297             CLK->PCKENR2 |= (uint8_t)((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F));
 997  0224 7b01          	ld	a,(OFST+1,sp)
 998  0226 a40f          	and	a,#15
 999  0228 5f            	clrw	x
1000  0229 97            	ld	xl,a
1001  022a a601          	ld	a,#1
1002  022c 5d            	tnzw	x
1003  022d 2704          	jreq	L421
1004  022f               L621:
1005  022f 48            	sll	a
1006  0230 5a            	decw	x
1007  0231 26fc          	jrne	L621
1008  0233               L421:
1009  0233 ca50ca        	or	a,20682
1010  0236 c750ca        	ld	20682,a
1012  0239 2016          	jra	L133
1013  023b               L333:
1014                     ; 302             CLK->PCKENR2 &= (uint8_t)(~(uint8_t)(((uint8_t)1 << ((uint8_t)CLK_Peripheral & (uint8_t)0x0F))));
1016  023b 7b01          	ld	a,(OFST+1,sp)
1017  023d a40f          	and	a,#15
1018  023f 5f            	clrw	x
1019  0240 97            	ld	xl,a
1020  0241 a601          	ld	a,#1
1021  0243 5d            	tnzw	x
1022  0244 2704          	jreq	L031
1023  0246               L231:
1024  0246 48            	sll	a
1025  0247 5a            	decw	x
1026  0248 26fc          	jrne	L231
1027  024a               L031:
1028  024a 43            	cpl	a
1029  024b c450ca        	and	a,20682
1030  024e c750ca        	ld	20682,a
1031  0251               L133:
1032                     ; 306 }
1035  0251 85            	popw	x
1036  0252 81            	ret
1225                     ; 319 ErrorStatus CLK_ClockSwitchConfig(CLK_SwitchMode_TypeDef CLK_SwitchMode, CLK_Source_TypeDef CLK_NewClock, FunctionalState ITState, CLK_CurrentClockState_TypeDef CLK_CurrentClockState)
1225                     ; 320 {
1226                     	switch	.text
1227  0253               _CLK_ClockSwitchConfig:
1229  0253 89            	pushw	x
1230  0254 5204          	subw	sp,#4
1231       00000004      OFST:	set	4
1234                     ; 323     uint16_t DownCounter = CLK_TIMEOUT;
1236  0256 ae0491        	ldw	x,#1169
1237  0259 1f03          	ldw	(OFST-1,sp),x
1239                     ; 324     ErrorStatus Swif = ERROR;
1241                     ; 327     assert_param(IS_CLK_SOURCE_OK(CLK_NewClock));
1243  025b 7b06          	ld	a,(OFST+2,sp)
1244  025d a1e1          	cp	a,#225
1245  025f 270c          	jreq	L041
1246  0261 7b06          	ld	a,(OFST+2,sp)
1247  0263 a1d2          	cp	a,#210
1248  0265 2706          	jreq	L041
1249  0267 7b06          	ld	a,(OFST+2,sp)
1250  0269 a1b4          	cp	a,#180
1251  026b 2603          	jrne	L631
1252  026d               L041:
1253  026d 4f            	clr	a
1254  026e 2010          	jra	L241
1255  0270               L631:
1256  0270 ae0147        	ldw	x,#327
1257  0273 89            	pushw	x
1258  0274 ae0000        	ldw	x,#0
1259  0277 89            	pushw	x
1260  0278 ae000c        	ldw	x,#L75
1261  027b cd0000        	call	_assert_failed
1263  027e 5b04          	addw	sp,#4
1264  0280               L241:
1265                     ; 328     assert_param(IS_CLK_SWITCHMODE_OK(CLK_SwitchMode));
1267  0280 0d05          	tnz	(OFST+1,sp)
1268  0282 2706          	jreq	L641
1269  0284 7b05          	ld	a,(OFST+1,sp)
1270  0286 a101          	cp	a,#1
1271  0288 2603          	jrne	L441
1272  028a               L641:
1273  028a 4f            	clr	a
1274  028b 2010          	jra	L051
1275  028d               L441:
1276  028d ae0148        	ldw	x,#328
1277  0290 89            	pushw	x
1278  0291 ae0000        	ldw	x,#0
1279  0294 89            	pushw	x
1280  0295 ae000c        	ldw	x,#L75
1281  0298 cd0000        	call	_assert_failed
1283  029b 5b04          	addw	sp,#4
1284  029d               L051:
1285                     ; 329     assert_param(IS_FUNCTIONALSTATE_OK(ITState));
1287  029d 0d09          	tnz	(OFST+5,sp)
1288  029f 2706          	jreq	L451
1289  02a1 7b09          	ld	a,(OFST+5,sp)
1290  02a3 a101          	cp	a,#1
1291  02a5 2603          	jrne	L251
1292  02a7               L451:
1293  02a7 4f            	clr	a
1294  02a8 2010          	jra	L651
1295  02aa               L251:
1296  02aa ae0149        	ldw	x,#329
1297  02ad 89            	pushw	x
1298  02ae ae0000        	ldw	x,#0
1299  02b1 89            	pushw	x
1300  02b2 ae000c        	ldw	x,#L75
1301  02b5 cd0000        	call	_assert_failed
1303  02b8 5b04          	addw	sp,#4
1304  02ba               L651:
1305                     ; 330     assert_param(IS_CLK_CURRENTCLOCKSTATE_OK(CLK_CurrentClockState));
1307  02ba 0d0a          	tnz	(OFST+6,sp)
1308  02bc 2706          	jreq	L261
1309  02be 7b0a          	ld	a,(OFST+6,sp)
1310  02c0 a101          	cp	a,#1
1311  02c2 2603          	jrne	L061
1312  02c4               L261:
1313  02c4 4f            	clr	a
1314  02c5 2010          	jra	L461
1315  02c7               L061:
1316  02c7 ae014a        	ldw	x,#330
1317  02ca 89            	pushw	x
1318  02cb ae0000        	ldw	x,#0
1319  02ce 89            	pushw	x
1320  02cf ae000c        	ldw	x,#L75
1321  02d2 cd0000        	call	_assert_failed
1323  02d5 5b04          	addw	sp,#4
1324  02d7               L461:
1325                     ; 333     clock_master = (CLK_Source_TypeDef)CLK->CMSR;
1327  02d7 c650c3        	ld	a,20675
1328  02da 6b01          	ld	(OFST-3,sp),a
1330                     ; 336     if (CLK_SwitchMode == CLK_SWITCHMODE_AUTO)
1332  02dc 7b05          	ld	a,(OFST+1,sp)
1333  02de a101          	cp	a,#1
1334  02e0 2639          	jrne	L744
1335                     ; 340         CLK->SWCR |= CLK_SWCR_SWEN;
1337  02e2 721250c5      	bset	20677,#1
1338                     ; 343         if (ITState != DISABLE)
1340  02e6 0d09          	tnz	(OFST+5,sp)
1341  02e8 2706          	jreq	L154
1342                     ; 345             CLK->SWCR |= CLK_SWCR_SWIEN;
1344  02ea 721450c5      	bset	20677,#2
1346  02ee 2004          	jra	L354
1347  02f0               L154:
1348                     ; 349             CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIEN);
1350  02f0 721550c5      	bres	20677,#2
1351  02f4               L354:
1352                     ; 353         CLK->SWR = (uint8_t)CLK_NewClock;
1354  02f4 7b06          	ld	a,(OFST+2,sp)
1355  02f6 c750c4        	ld	20676,a
1357  02f9 2007          	jra	L164
1358  02fb               L554:
1359                     ; 357             DownCounter--;
1361  02fb 1e03          	ldw	x,(OFST-1,sp)
1362  02fd 1d0001        	subw	x,#1
1363  0300 1f03          	ldw	(OFST-1,sp),x
1365  0302               L164:
1366                     ; 355         while ((((CLK->SWCR & CLK_SWCR_SWBSY) != 0 )&& (DownCounter != 0)))
1368  0302 c650c5        	ld	a,20677
1369  0305 a501          	bcp	a,#1
1370  0307 2704          	jreq	L564
1372  0309 1e03          	ldw	x,(OFST-1,sp)
1373  030b 26ee          	jrne	L554
1374  030d               L564:
1375                     ; 360         if (DownCounter != 0)
1377  030d 1e03          	ldw	x,(OFST-1,sp)
1378  030f 2706          	jreq	L764
1379                     ; 362             Swif = SUCCESS;
1381  0311 a601          	ld	a,#1
1382  0313 6b02          	ld	(OFST-2,sp),a
1385  0315 201b          	jra	L374
1386  0317               L764:
1387                     ; 366             Swif = ERROR;
1389  0317 0f02          	clr	(OFST-2,sp)
1391  0319 2017          	jra	L374
1392  031b               L744:
1393                     ; 374         if (ITState != DISABLE)
1395  031b 0d09          	tnz	(OFST+5,sp)
1396  031d 2706          	jreq	L574
1397                     ; 376             CLK->SWCR |= CLK_SWCR_SWIEN;
1399  031f 721450c5      	bset	20677,#2
1401  0323 2004          	jra	L774
1402  0325               L574:
1403                     ; 380             CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIEN);
1405  0325 721550c5      	bres	20677,#2
1406  0329               L774:
1407                     ; 384         CLK->SWR = (uint8_t)CLK_NewClock;
1409  0329 7b06          	ld	a,(OFST+2,sp)
1410  032b c750c4        	ld	20676,a
1411                     ; 388         Swif = SUCCESS;
1413  032e a601          	ld	a,#1
1414  0330 6b02          	ld	(OFST-2,sp),a
1416  0332               L374:
1417                     ; 393     if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_HSI))
1419  0332 0d0a          	tnz	(OFST+6,sp)
1420  0334 260c          	jrne	L105
1422  0336 7b01          	ld	a,(OFST-3,sp)
1423  0338 a1e1          	cp	a,#225
1424  033a 2606          	jrne	L105
1425                     ; 395         CLK->ICKR &= (uint8_t)(~CLK_ICKR_HSIEN);
1427  033c 721150c0      	bres	20672,#0
1429  0340 201e          	jra	L305
1430  0342               L105:
1431                     ; 397     else if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_LSI))
1433  0342 0d0a          	tnz	(OFST+6,sp)
1434  0344 260c          	jrne	L505
1436  0346 7b01          	ld	a,(OFST-3,sp)
1437  0348 a1d2          	cp	a,#210
1438  034a 2606          	jrne	L505
1439                     ; 399         CLK->ICKR &= (uint8_t)(~CLK_ICKR_LSIEN);
1441  034c 721750c0      	bres	20672,#3
1443  0350 200e          	jra	L305
1444  0352               L505:
1445                     ; 401     else if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_HSE))
1447  0352 0d0a          	tnz	(OFST+6,sp)
1448  0354 260a          	jrne	L305
1450  0356 7b01          	ld	a,(OFST-3,sp)
1451  0358 a1b4          	cp	a,#180
1452  035a 2604          	jrne	L305
1453                     ; 403         CLK->ECKR &= (uint8_t)(~CLK_ECKR_HSEEN);
1455  035c 721150c1      	bres	20673,#0
1456  0360               L305:
1457                     ; 406     return(Swif);
1459  0360 7b02          	ld	a,(OFST-2,sp)
1462  0362 5b06          	addw	sp,#6
1463  0364 81            	ret
1602                     ; 416 void CLK_HSIPrescalerConfig(CLK_Prescaler_TypeDef HSIPrescaler)
1602                     ; 417 {
1603                     	switch	.text
1604  0365               _CLK_HSIPrescalerConfig:
1606  0365 88            	push	a
1607       00000000      OFST:	set	0
1610                     ; 420     assert_param(IS_CLK_HSIPRESCALER_OK(HSIPrescaler));
1612  0366 4d            	tnz	a
1613  0367 270c          	jreq	L271
1614  0369 a108          	cp	a,#8
1615  036b 2708          	jreq	L271
1616  036d a110          	cp	a,#16
1617  036f 2704          	jreq	L271
1618  0371 a118          	cp	a,#24
1619  0373 2603          	jrne	L071
1620  0375               L271:
1621  0375 4f            	clr	a
1622  0376 2010          	jra	L471
1623  0378               L071:
1624  0378 ae01a4        	ldw	x,#420
1625  037b 89            	pushw	x
1626  037c ae0000        	ldw	x,#0
1627  037f 89            	pushw	x
1628  0380 ae000c        	ldw	x,#L75
1629  0383 cd0000        	call	_assert_failed
1631  0386 5b04          	addw	sp,#4
1632  0388               L471:
1633                     ; 423     CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_HSIDIV);
1635  0388 c650c6        	ld	a,20678
1636  038b a4e7          	and	a,#231
1637  038d c750c6        	ld	20678,a
1638                     ; 426     CLK->CKDIVR |= (uint8_t)HSIPrescaler;
1640  0390 c650c6        	ld	a,20678
1641  0393 1a01          	or	a,(OFST+1,sp)
1642  0395 c750c6        	ld	20678,a
1643                     ; 428 }
1646  0398 84            	pop	a
1647  0399 81            	ret
1783                     ; 439 void CLK_CCOConfig(CLK_Output_TypeDef CLK_CCO)
1783                     ; 440 {
1784                     	switch	.text
1785  039a               _CLK_CCOConfig:
1787  039a 88            	push	a
1788       00000000      OFST:	set	0
1791                     ; 443     assert_param(IS_CLK_OUTPUT_OK(CLK_CCO));
1793  039b 4d            	tnz	a
1794  039c 2730          	jreq	L202
1795  039e a104          	cp	a,#4
1796  03a0 272c          	jreq	L202
1797  03a2 a102          	cp	a,#2
1798  03a4 2728          	jreq	L202
1799  03a6 a108          	cp	a,#8
1800  03a8 2724          	jreq	L202
1801  03aa a10a          	cp	a,#10
1802  03ac 2720          	jreq	L202
1803  03ae a10c          	cp	a,#12
1804  03b0 271c          	jreq	L202
1805  03b2 a10e          	cp	a,#14
1806  03b4 2718          	jreq	L202
1807  03b6 a110          	cp	a,#16
1808  03b8 2714          	jreq	L202
1809  03ba a112          	cp	a,#18
1810  03bc 2710          	jreq	L202
1811  03be a114          	cp	a,#20
1812  03c0 270c          	jreq	L202
1813  03c2 a116          	cp	a,#22
1814  03c4 2708          	jreq	L202
1815  03c6 a118          	cp	a,#24
1816  03c8 2704          	jreq	L202
1817  03ca a11a          	cp	a,#26
1818  03cc 2603          	jrne	L002
1819  03ce               L202:
1820  03ce 4f            	clr	a
1821  03cf 2010          	jra	L402
1822  03d1               L002:
1823  03d1 ae01bb        	ldw	x,#443
1824  03d4 89            	pushw	x
1825  03d5 ae0000        	ldw	x,#0
1826  03d8 89            	pushw	x
1827  03d9 ae000c        	ldw	x,#L75
1828  03dc cd0000        	call	_assert_failed
1830  03df 5b04          	addw	sp,#4
1831  03e1               L402:
1832                     ; 446     CLK->CCOR &= (uint8_t)(~CLK_CCOR_CCOSEL);
1834  03e1 c650c9        	ld	a,20681
1835  03e4 a4e1          	and	a,#225
1836  03e6 c750c9        	ld	20681,a
1837                     ; 449     CLK->CCOR |= (uint8_t)CLK_CCO;
1839  03e9 c650c9        	ld	a,20681
1840  03ec 1a01          	or	a,(OFST+1,sp)
1841  03ee c750c9        	ld	20681,a
1842                     ; 452     CLK->CCOR |= CLK_CCOR_CCOEN;
1844  03f1 721050c9      	bset	20681,#0
1845                     ; 454 }
1848  03f5 84            	pop	a
1849  03f6 81            	ret
1915                     ; 464 void CLK_ITConfig(CLK_IT_TypeDef CLK_IT, FunctionalState NewState)
1915                     ; 465 {
1916                     	switch	.text
1917  03f7               _CLK_ITConfig:
1919  03f7 89            	pushw	x
1920       00000000      OFST:	set	0
1923                     ; 468     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1925  03f8 9f            	ld	a,xl
1926  03f9 4d            	tnz	a
1927  03fa 2705          	jreq	L212
1928  03fc 9f            	ld	a,xl
1929  03fd a101          	cp	a,#1
1930  03ff 2603          	jrne	L012
1931  0401               L212:
1932  0401 4f            	clr	a
1933  0402 2010          	jra	L412
1934  0404               L012:
1935  0404 ae01d4        	ldw	x,#468
1936  0407 89            	pushw	x
1937  0408 ae0000        	ldw	x,#0
1938  040b 89            	pushw	x
1939  040c ae000c        	ldw	x,#L75
1940  040f cd0000        	call	_assert_failed
1942  0412 5b04          	addw	sp,#4
1943  0414               L412:
1944                     ; 469     assert_param(IS_CLK_IT_OK(CLK_IT));
1946  0414 7b01          	ld	a,(OFST+1,sp)
1947  0416 a10c          	cp	a,#12
1948  0418 2706          	jreq	L022
1949  041a 7b01          	ld	a,(OFST+1,sp)
1950  041c a11c          	cp	a,#28
1951  041e 2603          	jrne	L612
1952  0420               L022:
1953  0420 4f            	clr	a
1954  0421 2010          	jra	L222
1955  0423               L612:
1956  0423 ae01d5        	ldw	x,#469
1957  0426 89            	pushw	x
1958  0427 ae0000        	ldw	x,#0
1959  042a 89            	pushw	x
1960  042b ae000c        	ldw	x,#L75
1961  042e cd0000        	call	_assert_failed
1963  0431 5b04          	addw	sp,#4
1964  0433               L222:
1965                     ; 471     if (NewState != DISABLE)
1967  0433 0d02          	tnz	(OFST+2,sp)
1968  0435 271a          	jreq	L707
1969                     ; 473         switch (CLK_IT)
1971  0437 7b01          	ld	a,(OFST+1,sp)
1973                     ; 481         default:
1973                     ; 482             break;
1974  0439 a00c          	sub	a,#12
1975  043b 270a          	jreq	L346
1976  043d a010          	sub	a,#16
1977  043f 2624          	jrne	L517
1978                     ; 475         case CLK_IT_SWIF: /* Enable the clock switch interrupt */
1978                     ; 476             CLK->SWCR |= CLK_SWCR_SWIEN;
1980  0441 721450c5      	bset	20677,#2
1981                     ; 477             break;
1983  0445 201e          	jra	L517
1984  0447               L346:
1985                     ; 478         case CLK_IT_CSSD: /* Enable the clock security system detection interrupt */
1985                     ; 479             CLK->CSSR |= CLK_CSSR_CSSDIE;
1987  0447 721450c8      	bset	20680,#2
1988                     ; 480             break;
1990  044b 2018          	jra	L517
1991  044d               L546:
1992                     ; 481         default:
1992                     ; 482             break;
1994  044d 2016          	jra	L517
1995  044f               L317:
1997  044f 2014          	jra	L517
1998  0451               L707:
1999                     ; 487         switch (CLK_IT)
2001  0451 7b01          	ld	a,(OFST+1,sp)
2003                     ; 495         default:
2003                     ; 496             break;
2004  0453 a00c          	sub	a,#12
2005  0455 270a          	jreq	L156
2006  0457 a010          	sub	a,#16
2007  0459 260a          	jrne	L517
2008                     ; 489         case CLK_IT_SWIF: /* Disable the clock switch interrupt */
2008                     ; 490             CLK->SWCR  &= (uint8_t)(~CLK_SWCR_SWIEN);
2010  045b 721550c5      	bres	20677,#2
2011                     ; 491             break;
2013  045f 2004          	jra	L517
2014  0461               L156:
2015                     ; 492         case CLK_IT_CSSD: /* Disable the clock security system detection interrupt */
2015                     ; 493             CLK->CSSR &= (uint8_t)(~CLK_CSSR_CSSDIE);
2017  0461 721550c8      	bres	20680,#2
2018                     ; 494             break;
2019  0465               L517:
2020                     ; 500 }
2023  0465 85            	popw	x
2024  0466 81            	ret
2025  0467               L356:
2026                     ; 495         default:
2026                     ; 496             break;
2028  0467 20fc          	jra	L517
2029  0469               L127:
2030  0469 20fa          	jra	L517
2066                     ; 507 void CLK_SYSCLKConfig(CLK_Prescaler_TypeDef CLK_Prescaler)
2066                     ; 508 {
2067                     	switch	.text
2068  046b               _CLK_SYSCLKConfig:
2070  046b 88            	push	a
2071       00000000      OFST:	set	0
2074                     ; 511     assert_param(IS_CLK_PRESCALER_OK(CLK_Prescaler));
2076  046c 4d            	tnz	a
2077  046d 272c          	jreq	L032
2078  046f a108          	cp	a,#8
2079  0471 2728          	jreq	L032
2080  0473 a110          	cp	a,#16
2081  0475 2724          	jreq	L032
2082  0477 a118          	cp	a,#24
2083  0479 2720          	jreq	L032
2084  047b a180          	cp	a,#128
2085  047d 271c          	jreq	L032
2086  047f a181          	cp	a,#129
2087  0481 2718          	jreq	L032
2088  0483 a182          	cp	a,#130
2089  0485 2714          	jreq	L032
2090  0487 a183          	cp	a,#131
2091  0489 2710          	jreq	L032
2092  048b a184          	cp	a,#132
2093  048d 270c          	jreq	L032
2094  048f a185          	cp	a,#133
2095  0491 2708          	jreq	L032
2096  0493 a186          	cp	a,#134
2097  0495 2704          	jreq	L032
2098  0497 a187          	cp	a,#135
2099  0499 2603          	jrne	L622
2100  049b               L032:
2101  049b 4f            	clr	a
2102  049c 2010          	jra	L232
2103  049e               L622:
2104  049e ae01ff        	ldw	x,#511
2105  04a1 89            	pushw	x
2106  04a2 ae0000        	ldw	x,#0
2107  04a5 89            	pushw	x
2108  04a6 ae000c        	ldw	x,#L75
2109  04a9 cd0000        	call	_assert_failed
2111  04ac 5b04          	addw	sp,#4
2112  04ae               L232:
2113                     ; 513     if (((uint8_t)CLK_Prescaler & (uint8_t)0x80) == 0x00) /* Bit7 = 0 means HSI divider */
2115  04ae 7b01          	ld	a,(OFST+1,sp)
2116  04b0 a580          	bcp	a,#128
2117  04b2 2614          	jrne	L147
2118                     ; 515         CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_HSIDIV);
2120  04b4 c650c6        	ld	a,20678
2121  04b7 a4e7          	and	a,#231
2122  04b9 c750c6        	ld	20678,a
2123                     ; 516         CLK->CKDIVR |= (uint8_t)((uint8_t)CLK_Prescaler & (uint8_t)CLK_CKDIVR_HSIDIV);
2125  04bc 7b01          	ld	a,(OFST+1,sp)
2126  04be a418          	and	a,#24
2127  04c0 ca50c6        	or	a,20678
2128  04c3 c750c6        	ld	20678,a
2130  04c6 2012          	jra	L347
2131  04c8               L147:
2132                     ; 520         CLK->CKDIVR &= (uint8_t)(~CLK_CKDIVR_CPUDIV);
2134  04c8 c650c6        	ld	a,20678
2135  04cb a4f8          	and	a,#248
2136  04cd c750c6        	ld	20678,a
2137                     ; 521         CLK->CKDIVR |= (uint8_t)((uint8_t)CLK_Prescaler & (uint8_t)CLK_CKDIVR_CPUDIV);
2139  04d0 7b01          	ld	a,(OFST+1,sp)
2140  04d2 a407          	and	a,#7
2141  04d4 ca50c6        	or	a,20678
2142  04d7 c750c6        	ld	20678,a
2143  04da               L347:
2144                     ; 524 }
2147  04da 84            	pop	a
2148  04db 81            	ret
2205                     ; 531 void CLK_SWIMConfig(CLK_SWIMDivider_TypeDef CLK_SWIMDivider)
2205                     ; 532 {
2206                     	switch	.text
2207  04dc               _CLK_SWIMConfig:
2209  04dc 88            	push	a
2210       00000000      OFST:	set	0
2213                     ; 535     assert_param(IS_CLK_SWIMDIVIDER_OK(CLK_SWIMDivider));
2215  04dd 4d            	tnz	a
2216  04de 2704          	jreq	L042
2217  04e0 a101          	cp	a,#1
2218  04e2 2603          	jrne	L632
2219  04e4               L042:
2220  04e4 4f            	clr	a
2221  04e5 2010          	jra	L242
2222  04e7               L632:
2223  04e7 ae0217        	ldw	x,#535
2224  04ea 89            	pushw	x
2225  04eb ae0000        	ldw	x,#0
2226  04ee 89            	pushw	x
2227  04ef ae000c        	ldw	x,#L75
2228  04f2 cd0000        	call	_assert_failed
2230  04f5 5b04          	addw	sp,#4
2231  04f7               L242:
2232                     ; 537     if (CLK_SWIMDivider != CLK_SWIMDIVIDER_2)
2234  04f7 0d01          	tnz	(OFST+1,sp)
2235  04f9 2706          	jreq	L377
2236                     ; 540         CLK->SWIMCCR |= CLK_SWIMCCR_SWIMDIV;
2238  04fb 721050cd      	bset	20685,#0
2240  04ff 2004          	jra	L577
2241  0501               L377:
2242                     ; 545         CLK->SWIMCCR &= (uint8_t)(~CLK_SWIMCCR_SWIMDIV);
2244  0501 721150cd      	bres	20685,#0
2245  0505               L577:
2246                     ; 548 }
2249  0505 84            	pop	a
2250  0506 81            	ret
2274                     ; 557 void CLK_ClockSecuritySystemEnable(void)
2274                     ; 558 {
2275                     	switch	.text
2276  0507               _CLK_ClockSecuritySystemEnable:
2280                     ; 560     CLK->CSSR |= CLK_CSSR_CSSEN;
2282  0507 721050c8      	bset	20680,#0
2283                     ; 561 }
2286  050b 81            	ret
2311                     ; 569 CLK_Source_TypeDef CLK_GetSYSCLKSource(void)
2311                     ; 570 {
2312                     	switch	.text
2313  050c               _CLK_GetSYSCLKSource:
2317                     ; 571     return((CLK_Source_TypeDef)CLK->CMSR);
2319  050c c650c3        	ld	a,20675
2322  050f 81            	ret
2385                     ; 579 uint32_t CLK_GetClockFreq(void)
2385                     ; 580 {
2386                     	switch	.text
2387  0510               _CLK_GetClockFreq:
2389  0510 5209          	subw	sp,#9
2390       00000009      OFST:	set	9
2393                     ; 582     uint32_t clockfrequency = 0;
2395                     ; 583     CLK_Source_TypeDef clocksource = CLK_SOURCE_HSI;
2397                     ; 584     uint8_t tmp = 0, presc = 0;
2401                     ; 587     clocksource = (CLK_Source_TypeDef)CLK->CMSR;
2403  0512 c650c3        	ld	a,20675
2404  0515 6b09          	ld	(OFST+0,sp),a
2406                     ; 589     if (clocksource == CLK_SOURCE_HSI)
2408  0517 7b09          	ld	a,(OFST+0,sp)
2409  0519 a1e1          	cp	a,#225
2410  051b 2641          	jrne	L1501
2411                     ; 591         tmp = (uint8_t)(CLK->CKDIVR & CLK_CKDIVR_HSIDIV);
2413  051d c650c6        	ld	a,20678
2414  0520 a418          	and	a,#24
2415  0522 6b09          	ld	(OFST+0,sp),a
2417                     ; 592         tmp = (uint8_t)(tmp >> 3);
2419  0524 0409          	srl	(OFST+0,sp)
2420  0526 0409          	srl	(OFST+0,sp)
2421  0528 0409          	srl	(OFST+0,sp)
2423                     ; 593         presc = HSIDivFactor[tmp];
2425  052a 7b09          	ld	a,(OFST+0,sp)
2426  052c 5f            	clrw	x
2427  052d 97            	ld	xl,a
2428  052e d60000        	ld	a,(_HSIDivFactor,x)
2429  0531 6b09          	ld	(OFST+0,sp),a
2431                     ; 594         clockfrequency = HSI_VALUE / presc;
2433  0533 7b09          	ld	a,(OFST+0,sp)
2434  0535 b703          	ld	c_lreg+3,a
2435  0537 3f02          	clr	c_lreg+2
2436  0539 3f01          	clr	c_lreg+1
2437  053b 3f00          	clr	c_lreg
2438  053d 96            	ldw	x,sp
2439  053e 1c0001        	addw	x,#OFST-8
2440  0541 cd0000        	call	c_rtol
2443  0544 ae2400        	ldw	x,#9216
2444  0547 bf02          	ldw	c_lreg+2,x
2445  0549 ae00f4        	ldw	x,#244
2446  054c bf00          	ldw	c_lreg,x
2447  054e 96            	ldw	x,sp
2448  054f 1c0001        	addw	x,#OFST-8
2449  0552 cd0000        	call	c_ludv
2451  0555 96            	ldw	x,sp
2452  0556 1c0005        	addw	x,#OFST-4
2453  0559 cd0000        	call	c_rtol
2457  055c 201c          	jra	L3501
2458  055e               L1501:
2459                     ; 596     else if ( clocksource == CLK_SOURCE_LSI)
2461  055e 7b09          	ld	a,(OFST+0,sp)
2462  0560 a1d2          	cp	a,#210
2463  0562 260c          	jrne	L5501
2464                     ; 598         clockfrequency = LSI_VALUE;
2466  0564 aef400        	ldw	x,#62464
2467  0567 1f07          	ldw	(OFST-2,sp),x
2468  0569 ae0001        	ldw	x,#1
2469  056c 1f05          	ldw	(OFST-4,sp),x
2472  056e 200a          	jra	L3501
2473  0570               L5501:
2474                     ; 602         clockfrequency = HSE_VALUE;
2476  0570 ae2400        	ldw	x,#9216
2477  0573 1f07          	ldw	(OFST-2,sp),x
2478  0575 ae00f4        	ldw	x,#244
2479  0578 1f05          	ldw	(OFST-4,sp),x
2481  057a               L3501:
2482                     ; 605     return((uint32_t)clockfrequency);
2484  057a 96            	ldw	x,sp
2485  057b 1c0005        	addw	x,#OFST-4
2486  057e cd0000        	call	c_ltor
2490  0581 5b09          	addw	sp,#9
2491  0583 81            	ret
2591                     ; 616 void CLK_AdjustHSICalibrationValue(CLK_HSITrimValue_TypeDef CLK_HSICalibrationValue)
2591                     ; 617 {
2592                     	switch	.text
2593  0584               _CLK_AdjustHSICalibrationValue:
2595  0584 88            	push	a
2596       00000000      OFST:	set	0
2599                     ; 620     assert_param(IS_CLK_HSITRIMVALUE_OK(CLK_HSICalibrationValue));
2601  0585 4d            	tnz	a
2602  0586 271c          	jreq	L652
2603  0588 a101          	cp	a,#1
2604  058a 2718          	jreq	L652
2605  058c a102          	cp	a,#2
2606  058e 2714          	jreq	L652
2607  0590 a103          	cp	a,#3
2608  0592 2710          	jreq	L652
2609  0594 a104          	cp	a,#4
2610  0596 270c          	jreq	L652
2611  0598 a105          	cp	a,#5
2612  059a 2708          	jreq	L652
2613  059c a106          	cp	a,#6
2614  059e 2704          	jreq	L652
2615  05a0 a107          	cp	a,#7
2616  05a2 2603          	jrne	L452
2617  05a4               L652:
2618  05a4 4f            	clr	a
2619  05a5 2010          	jra	L062
2620  05a7               L452:
2621  05a7 ae026c        	ldw	x,#620
2622  05aa 89            	pushw	x
2623  05ab ae0000        	ldw	x,#0
2624  05ae 89            	pushw	x
2625  05af ae000c        	ldw	x,#L75
2626  05b2 cd0000        	call	_assert_failed
2628  05b5 5b04          	addw	sp,#4
2629  05b7               L062:
2630                     ; 623     CLK->HSITRIMR = (uint8_t)( (uint8_t)(CLK->HSITRIMR & (uint8_t)(~CLK_HSITRIMR_HSITRIM))|((uint8_t)CLK_HSICalibrationValue));
2632  05b7 c650cc        	ld	a,20684
2633  05ba a4f8          	and	a,#248
2634  05bc 1a01          	or	a,(OFST+1,sp)
2635  05be c750cc        	ld	20684,a
2636                     ; 625 }
2639  05c1 84            	pop	a
2640  05c2 81            	ret
2664                     ; 636 void CLK_SYSCLKEmergencyClear(void)
2664                     ; 637 {
2665                     	switch	.text
2666  05c3               _CLK_SYSCLKEmergencyClear:
2670                     ; 638     CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWBSY);
2672  05c3 721150c5      	bres	20677,#0
2673                     ; 639 }
2676  05c7 81            	ret
2830                     ; 648 FlagStatus CLK_GetFlagStatus(CLK_Flag_TypeDef CLK_FLAG)
2830                     ; 649 {
2831                     	switch	.text
2832  05c8               _CLK_GetFlagStatus:
2834  05c8 89            	pushw	x
2835  05c9 5203          	subw	sp,#3
2836       00000003      OFST:	set	3
2839                     ; 651     uint16_t statusreg = 0;
2841                     ; 652     uint8_t tmpreg = 0;
2843                     ; 653     FlagStatus bitstatus = RESET;
2845                     ; 656     assert_param(IS_CLK_FLAG_OK(CLK_FLAG));
2847  05cb a30110        	cpw	x,#272
2848  05ce 2728          	jreq	L072
2849  05d0 a30102        	cpw	x,#258
2850  05d3 2723          	jreq	L072
2851  05d5 a30202        	cpw	x,#514
2852  05d8 271e          	jreq	L072
2853  05da a30308        	cpw	x,#776
2854  05dd 2719          	jreq	L072
2855  05df a30301        	cpw	x,#769
2856  05e2 2714          	jreq	L072
2857  05e4 a30408        	cpw	x,#1032
2858  05e7 270f          	jreq	L072
2859  05e9 a30402        	cpw	x,#1026
2860  05ec 270a          	jreq	L072
2861  05ee a30504        	cpw	x,#1284
2862  05f1 2705          	jreq	L072
2863  05f3 a30502        	cpw	x,#1282
2864  05f6 2603          	jrne	L662
2865  05f8               L072:
2866  05f8 4f            	clr	a
2867  05f9 2010          	jra	L272
2868  05fb               L662:
2869  05fb ae0290        	ldw	x,#656
2870  05fe 89            	pushw	x
2871  05ff ae0000        	ldw	x,#0
2872  0602 89            	pushw	x
2873  0603 ae000c        	ldw	x,#L75
2874  0606 cd0000        	call	_assert_failed
2876  0609 5b04          	addw	sp,#4
2877  060b               L272:
2878                     ; 659     statusreg = (uint16_t)((uint16_t)CLK_FLAG & (uint16_t)0xFF00);
2880  060b 7b04          	ld	a,(OFST+1,sp)
2881  060d 97            	ld	xl,a
2882  060e 7b05          	ld	a,(OFST+2,sp)
2883  0610 9f            	ld	a,xl
2884  0611 a4ff          	and	a,#255
2885  0613 97            	ld	xl,a
2886  0614 4f            	clr	a
2887  0615 02            	rlwa	x,a
2888  0616 1f01          	ldw	(OFST-2,sp),x
2889  0618 01            	rrwa	x,a
2891                     ; 662     if (statusreg == 0x0100) /* The flag to check is in ICKRregister */
2893  0619 1e01          	ldw	x,(OFST-2,sp)
2894  061b a30100        	cpw	x,#256
2895  061e 2607          	jrne	L3221
2896                     ; 664         tmpreg = CLK->ICKR;
2898  0620 c650c0        	ld	a,20672
2899  0623 6b03          	ld	(OFST+0,sp),a
2902  0625 202f          	jra	L5221
2903  0627               L3221:
2904                     ; 666     else if (statusreg == 0x0200) /* The flag to check is in ECKRregister */
2906  0627 1e01          	ldw	x,(OFST-2,sp)
2907  0629 a30200        	cpw	x,#512
2908  062c 2607          	jrne	L7221
2909                     ; 668         tmpreg = CLK->ECKR;
2911  062e c650c1        	ld	a,20673
2912  0631 6b03          	ld	(OFST+0,sp),a
2915  0633 2021          	jra	L5221
2916  0635               L7221:
2917                     ; 670     else if (statusreg == 0x0300) /* The flag to check is in SWIC register */
2919  0635 1e01          	ldw	x,(OFST-2,sp)
2920  0637 a30300        	cpw	x,#768
2921  063a 2607          	jrne	L3321
2922                     ; 672         tmpreg = CLK->SWCR;
2924  063c c650c5        	ld	a,20677
2925  063f 6b03          	ld	(OFST+0,sp),a
2928  0641 2013          	jra	L5221
2929  0643               L3321:
2930                     ; 674     else if (statusreg == 0x0400) /* The flag to check is in CSS register */
2932  0643 1e01          	ldw	x,(OFST-2,sp)
2933  0645 a30400        	cpw	x,#1024
2934  0648 2607          	jrne	L7321
2935                     ; 676         tmpreg = CLK->CSSR;
2937  064a c650c8        	ld	a,20680
2938  064d 6b03          	ld	(OFST+0,sp),a
2941  064f 2005          	jra	L5221
2942  0651               L7321:
2943                     ; 680         tmpreg = CLK->CCOR;
2945  0651 c650c9        	ld	a,20681
2946  0654 6b03          	ld	(OFST+0,sp),a
2948  0656               L5221:
2949                     ; 683     if ((tmpreg & (uint8_t)CLK_FLAG) != (uint8_t)RESET)
2951  0656 7b05          	ld	a,(OFST+2,sp)
2952  0658 1503          	bcp	a,(OFST+0,sp)
2953  065a 2706          	jreq	L3421
2954                     ; 685         bitstatus = SET;
2956  065c a601          	ld	a,#1
2957  065e 6b03          	ld	(OFST+0,sp),a
2960  0660 2002          	jra	L5421
2961  0662               L3421:
2962                     ; 689         bitstatus = RESET;
2964  0662 0f03          	clr	(OFST+0,sp)
2966  0664               L5421:
2967                     ; 693     return((FlagStatus)bitstatus);
2969  0664 7b03          	ld	a,(OFST+0,sp)
2972  0666 5b05          	addw	sp,#5
2973  0668 81            	ret
3020                     ; 703 ITStatus CLK_GetITStatus(CLK_IT_TypeDef CLK_IT)
3020                     ; 704 {
3021                     	switch	.text
3022  0669               _CLK_GetITStatus:
3024  0669 88            	push	a
3025  066a 88            	push	a
3026       00000001      OFST:	set	1
3029                     ; 706     ITStatus bitstatus = RESET;
3031                     ; 709     assert_param(IS_CLK_IT_OK(CLK_IT));
3033  066b a10c          	cp	a,#12
3034  066d 2704          	jreq	L003
3035  066f a11c          	cp	a,#28
3036  0671 2603          	jrne	L672
3037  0673               L003:
3038  0673 4f            	clr	a
3039  0674 2010          	jra	L203
3040  0676               L672:
3041  0676 ae02c5        	ldw	x,#709
3042  0679 89            	pushw	x
3043  067a ae0000        	ldw	x,#0
3044  067d 89            	pushw	x
3045  067e ae000c        	ldw	x,#L75
3046  0681 cd0000        	call	_assert_failed
3048  0684 5b04          	addw	sp,#4
3049  0686               L203:
3050                     ; 711     if (CLK_IT == CLK_IT_SWIF)
3052  0686 7b02          	ld	a,(OFST+1,sp)
3053  0688 a11c          	cp	a,#28
3054  068a 2613          	jrne	L1721
3055                     ; 714         if ((CLK->SWCR & (uint8_t)CLK_IT) == (uint8_t)0x0C)
3057  068c c650c5        	ld	a,20677
3058  068f 1402          	and	a,(OFST+1,sp)
3059  0691 a10c          	cp	a,#12
3060  0693 2606          	jrne	L3721
3061                     ; 716             bitstatus = SET;
3063  0695 a601          	ld	a,#1
3064  0697 6b01          	ld	(OFST+0,sp),a
3067  0699 2015          	jra	L7721
3068  069b               L3721:
3069                     ; 720             bitstatus = RESET;
3071  069b 0f01          	clr	(OFST+0,sp)
3073  069d 2011          	jra	L7721
3074  069f               L1721:
3075                     ; 726         if ((CLK->CSSR & (uint8_t)CLK_IT) == (uint8_t)0x0C)
3077  069f c650c8        	ld	a,20680
3078  06a2 1402          	and	a,(OFST+1,sp)
3079  06a4 a10c          	cp	a,#12
3080  06a6 2606          	jrne	L1031
3081                     ; 728             bitstatus = SET;
3083  06a8 a601          	ld	a,#1
3084  06aa 6b01          	ld	(OFST+0,sp),a
3087  06ac 2002          	jra	L7721
3088  06ae               L1031:
3089                     ; 732             bitstatus = RESET;
3091  06ae 0f01          	clr	(OFST+0,sp)
3093  06b0               L7721:
3094                     ; 737     return bitstatus;
3096  06b0 7b01          	ld	a,(OFST+0,sp)
3099  06b2 85            	popw	x
3100  06b3 81            	ret
3137                     ; 747 void CLK_ClearITPendingBit(CLK_IT_TypeDef CLK_IT)
3137                     ; 748 {
3138                     	switch	.text
3139  06b4               _CLK_ClearITPendingBit:
3141  06b4 88            	push	a
3142       00000000      OFST:	set	0
3145                     ; 751     assert_param(IS_CLK_IT_OK(CLK_IT));
3147  06b5 a10c          	cp	a,#12
3148  06b7 2704          	jreq	L013
3149  06b9 a11c          	cp	a,#28
3150  06bb 2603          	jrne	L603
3151  06bd               L013:
3152  06bd 4f            	clr	a
3153  06be 2010          	jra	L213
3154  06c0               L603:
3155  06c0 ae02ef        	ldw	x,#751
3156  06c3 89            	pushw	x
3157  06c4 ae0000        	ldw	x,#0
3158  06c7 89            	pushw	x
3159  06c8 ae000c        	ldw	x,#L75
3160  06cb cd0000        	call	_assert_failed
3162  06ce 5b04          	addw	sp,#4
3163  06d0               L213:
3164                     ; 753     if (CLK_IT == (uint8_t)CLK_IT_CSSD)
3166  06d0 7b01          	ld	a,(OFST+1,sp)
3167  06d2 a10c          	cp	a,#12
3168  06d4 2606          	jrne	L3231
3169                     ; 756         CLK->CSSR &= (uint8_t)(~CLK_CSSR_CSSD);
3171  06d6 721750c8      	bres	20680,#3
3173  06da 2004          	jra	L5231
3174  06dc               L3231:
3175                     ; 761         CLK->SWCR &= (uint8_t)(~CLK_SWCR_SWIF);
3177  06dc 721750c5      	bres	20677,#3
3178  06e0               L5231:
3179                     ; 764 }
3182  06e0 84            	pop	a
3183  06e1 81            	ret
3218                     	xdef	_CLKPrescTable
3219                     	xdef	_HSIDivFactor
3220                     	xdef	_CLK_ClearITPendingBit
3221                     	xdef	_CLK_GetITStatus
3222                     	xdef	_CLK_GetFlagStatus
3223                     	xdef	_CLK_GetSYSCLKSource
3224                     	xdef	_CLK_GetClockFreq
3225                     	xdef	_CLK_AdjustHSICalibrationValue
3226                     	xdef	_CLK_SYSCLKEmergencyClear
3227                     	xdef	_CLK_ClockSecuritySystemEnable
3228                     	xdef	_CLK_SWIMConfig
3229                     	xdef	_CLK_SYSCLKConfig
3230                     	xdef	_CLK_ITConfig
3231                     	xdef	_CLK_CCOConfig
3232                     	xdef	_CLK_HSIPrescalerConfig
3233                     	xdef	_CLK_ClockSwitchConfig
3234                     	xdef	_CLK_PeripheralClockConfig
3235                     	xdef	_CLK_SlowActiveHaltWakeUpCmd
3236                     	xdef	_CLK_FastHaltWakeUpCmd
3237                     	xdef	_CLK_ClockSwitchCmd
3238                     	xdef	_CLK_CCOCmd
3239                     	xdef	_CLK_LSICmd
3240                     	xdef	_CLK_HSICmd
3241                     	xdef	_CLK_HSECmd
3242                     	xdef	_CLK_DeInit
3243                     	xref	_assert_failed
3244                     	switch	.const
3245  000c               L75:
3246  000c 73746d38735f  	dc.b	"stm8s_stdperiph_dr"
3247  001e 697665725c73  	dc.b	"iver\src\stm8s_clk"
3248  0030 2e6300        	dc.b	".c",0
3249                     	xref.b	c_lreg
3250                     	xref.b	c_x
3270                     	xref	c_ltor
3271                     	xref	c_ludv
3272                     	xref	c_rtol
3273                     	end
