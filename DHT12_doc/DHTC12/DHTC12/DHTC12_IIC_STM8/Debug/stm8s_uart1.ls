   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.12 - 20 Jun 2018
   3                     ; Generator (Limited) V4.4.8 - 20 Jun 2018
  42                     ; 46 void UART1_DeInit(void)
  42                     ; 47 {
  44                     	switch	.text
  45  0000               _UART1_DeInit:
  49                     ; 50     (void)UART1->SR;
  51  0000 c65230        	ld	a,21040
  52                     ; 51     (void)UART1->DR;
  54  0003 c65231        	ld	a,21041
  55                     ; 53     UART1->BRR2 = UART1_BRR2_RESET_VALUE;  /* Set UART1_BRR2 to reset value 0x00 */
  57  0006 725f5233      	clr	21043
  58                     ; 54     UART1->BRR1 = UART1_BRR1_RESET_VALUE;  /* Set UART1_BRR1 to reset value 0x00 */
  60  000a 725f5232      	clr	21042
  61                     ; 56     UART1->CR1 = UART1_CR1_RESET_VALUE;  /* Set UART1_CR1 to reset value 0x00 */
  63  000e 725f5234      	clr	21044
  64                     ; 57     UART1->CR2 = UART1_CR2_RESET_VALUE;  /* Set UART1_CR2 to reset value 0x00 */
  66  0012 725f5235      	clr	21045
  67                     ; 58     UART1->CR3 = UART1_CR3_RESET_VALUE;  /* Set UART1_CR3 to reset value 0x00 */
  69  0016 725f5236      	clr	21046
  70                     ; 59     UART1->CR4 = UART1_CR4_RESET_VALUE;  /* Set UART1_CR4 to reset value 0x00 */
  72  001a 725f5237      	clr	21047
  73                     ; 60     UART1->CR5 = UART1_CR5_RESET_VALUE;  /* Set UART1_CR5 to reset value 0x00 */
  75  001e 725f5238      	clr	21048
  76                     ; 62     UART1->GTR = UART1_GTR_RESET_VALUE;
  78  0022 725f5239      	clr	21049
  79                     ; 63     UART1->PSCR = UART1_PSCR_RESET_VALUE;
  81  0026 725f523a      	clr	21050
  82                     ; 64 }
  85  002a 81            	ret
 389                     .const:	section	.text
 390  0000               L21:
 391  0000 00098969      	dc.l	625001
 392  0004               L25:
 393  0004 00000064      	dc.l	100
 394                     ; 83 void UART1_Init(uint32_t BaudRate, UART1_WordLength_TypeDef WordLength, 
 394                     ; 84                 UART1_StopBits_TypeDef StopBits, UART1_Parity_TypeDef Parity, 
 394                     ; 85                 UART1_SyncMode_TypeDef SyncMode, UART1_Mode_TypeDef Mode)
 394                     ; 86 {
 395                     	switch	.text
 396  002b               _UART1_Init:
 398  002b 520c          	subw	sp,#12
 399       0000000c      OFST:	set	12
 402                     ; 87     uint32_t BaudRate_Mantissa = 0, BaudRate_Mantissa100 = 0;
 406                     ; 90     assert_param(IS_UART1_BAUDRATE_OK(BaudRate));
 408  002d 96            	ldw	x,sp
 409  002e 1c000f        	addw	x,#OFST+3
 410  0031 cd0000        	call	c_ltor
 412  0034 ae0000        	ldw	x,#L21
 413  0037 cd0000        	call	c_lcmp
 415  003a 2403          	jruge	L01
 416  003c 4f            	clr	a
 417  003d 2010          	jra	L41
 418  003f               L01:
 419  003f ae005a        	ldw	x,#90
 420  0042 89            	pushw	x
 421  0043 ae0000        	ldw	x,#0
 422  0046 89            	pushw	x
 423  0047 ae0008        	ldw	x,#L371
 424  004a cd0000        	call	_assert_failed
 426  004d 5b04          	addw	sp,#4
 427  004f               L41:
 428                     ; 91     assert_param(IS_UART1_WORDLENGTH_OK(WordLength));
 430  004f 0d13          	tnz	(OFST+7,sp)
 431  0051 2706          	jreq	L02
 432  0053 7b13          	ld	a,(OFST+7,sp)
 433  0055 a110          	cp	a,#16
 434  0057 2603          	jrne	L61
 435  0059               L02:
 436  0059 4f            	clr	a
 437  005a 2010          	jra	L22
 438  005c               L61:
 439  005c ae005b        	ldw	x,#91
 440  005f 89            	pushw	x
 441  0060 ae0000        	ldw	x,#0
 442  0063 89            	pushw	x
 443  0064 ae0008        	ldw	x,#L371
 444  0067 cd0000        	call	_assert_failed
 446  006a 5b04          	addw	sp,#4
 447  006c               L22:
 448                     ; 92     assert_param(IS_UART1_STOPBITS_OK(StopBits));
 450  006c 0d14          	tnz	(OFST+8,sp)
 451  006e 2712          	jreq	L62
 452  0070 7b14          	ld	a,(OFST+8,sp)
 453  0072 a110          	cp	a,#16
 454  0074 270c          	jreq	L62
 455  0076 7b14          	ld	a,(OFST+8,sp)
 456  0078 a120          	cp	a,#32
 457  007a 2706          	jreq	L62
 458  007c 7b14          	ld	a,(OFST+8,sp)
 459  007e a130          	cp	a,#48
 460  0080 2603          	jrne	L42
 461  0082               L62:
 462  0082 4f            	clr	a
 463  0083 2010          	jra	L03
 464  0085               L42:
 465  0085 ae005c        	ldw	x,#92
 466  0088 89            	pushw	x
 467  0089 ae0000        	ldw	x,#0
 468  008c 89            	pushw	x
 469  008d ae0008        	ldw	x,#L371
 470  0090 cd0000        	call	_assert_failed
 472  0093 5b04          	addw	sp,#4
 473  0095               L03:
 474                     ; 93     assert_param(IS_UART1_PARITY_OK(Parity));
 476  0095 0d15          	tnz	(OFST+9,sp)
 477  0097 270c          	jreq	L43
 478  0099 7b15          	ld	a,(OFST+9,sp)
 479  009b a104          	cp	a,#4
 480  009d 2706          	jreq	L43
 481  009f 7b15          	ld	a,(OFST+9,sp)
 482  00a1 a106          	cp	a,#6
 483  00a3 2603          	jrne	L23
 484  00a5               L43:
 485  00a5 4f            	clr	a
 486  00a6 2010          	jra	L63
 487  00a8               L23:
 488  00a8 ae005d        	ldw	x,#93
 489  00ab 89            	pushw	x
 490  00ac ae0000        	ldw	x,#0
 491  00af 89            	pushw	x
 492  00b0 ae0008        	ldw	x,#L371
 493  00b3 cd0000        	call	_assert_failed
 495  00b6 5b04          	addw	sp,#4
 496  00b8               L63:
 497                     ; 94     assert_param(IS_UART1_MODE_OK((uint8_t)Mode));
 499  00b8 7b17          	ld	a,(OFST+11,sp)
 500  00ba a108          	cp	a,#8
 501  00bc 2730          	jreq	L24
 502  00be 7b17          	ld	a,(OFST+11,sp)
 503  00c0 a140          	cp	a,#64
 504  00c2 272a          	jreq	L24
 505  00c4 7b17          	ld	a,(OFST+11,sp)
 506  00c6 a104          	cp	a,#4
 507  00c8 2724          	jreq	L24
 508  00ca 7b17          	ld	a,(OFST+11,sp)
 509  00cc a180          	cp	a,#128
 510  00ce 271e          	jreq	L24
 511  00d0 7b17          	ld	a,(OFST+11,sp)
 512  00d2 a10c          	cp	a,#12
 513  00d4 2718          	jreq	L24
 514  00d6 7b17          	ld	a,(OFST+11,sp)
 515  00d8 a10c          	cp	a,#12
 516  00da 2712          	jreq	L24
 517  00dc 7b17          	ld	a,(OFST+11,sp)
 518  00de a144          	cp	a,#68
 519  00e0 270c          	jreq	L24
 520  00e2 7b17          	ld	a,(OFST+11,sp)
 521  00e4 a1c0          	cp	a,#192
 522  00e6 2706          	jreq	L24
 523  00e8 7b17          	ld	a,(OFST+11,sp)
 524  00ea a188          	cp	a,#136
 525  00ec 2603          	jrne	L04
 526  00ee               L24:
 527  00ee 4f            	clr	a
 528  00ef 2010          	jra	L44
 529  00f1               L04:
 530  00f1 ae005e        	ldw	x,#94
 531  00f4 89            	pushw	x
 532  00f5 ae0000        	ldw	x,#0
 533  00f8 89            	pushw	x
 534  00f9 ae0008        	ldw	x,#L371
 535  00fc cd0000        	call	_assert_failed
 537  00ff 5b04          	addw	sp,#4
 538  0101               L44:
 539                     ; 95     assert_param(IS_UART1_SYNCMODE_OK((uint8_t)SyncMode));
 541  0101 7b16          	ld	a,(OFST+10,sp)
 542  0103 a488          	and	a,#136
 543  0105 a188          	cp	a,#136
 544  0107 271b          	jreq	L64
 545  0109 7b16          	ld	a,(OFST+10,sp)
 546  010b a444          	and	a,#68
 547  010d a144          	cp	a,#68
 548  010f 2713          	jreq	L64
 549  0111 7b16          	ld	a,(OFST+10,sp)
 550  0113 a422          	and	a,#34
 551  0115 a122          	cp	a,#34
 552  0117 270b          	jreq	L64
 553  0119 7b16          	ld	a,(OFST+10,sp)
 554  011b a411          	and	a,#17
 555  011d a111          	cp	a,#17
 556  011f 2703          	jreq	L64
 557  0121 4f            	clr	a
 558  0122 2010          	jra	L05
 559  0124               L64:
 560  0124 ae005f        	ldw	x,#95
 561  0127 89            	pushw	x
 562  0128 ae0000        	ldw	x,#0
 563  012b 89            	pushw	x
 564  012c ae0008        	ldw	x,#L371
 565  012f cd0000        	call	_assert_failed
 567  0132 5b04          	addw	sp,#4
 568  0134               L05:
 569                     ; 98     UART1->CR1 &= (uint8_t)(~UART1_CR1_M);  
 571  0134 72195234      	bres	21044,#4
 572                     ; 101     UART1->CR1 |= (uint8_t)WordLength;
 574  0138 c65234        	ld	a,21044
 575  013b 1a13          	or	a,(OFST+7,sp)
 576  013d c75234        	ld	21044,a
 577                     ; 104     UART1->CR3 &= (uint8_t)(~UART1_CR3_STOP);  
 579  0140 c65236        	ld	a,21046
 580  0143 a4cf          	and	a,#207
 581  0145 c75236        	ld	21046,a
 582                     ; 106     UART1->CR3 |= (uint8_t)StopBits;  
 584  0148 c65236        	ld	a,21046
 585  014b 1a14          	or	a,(OFST+8,sp)
 586  014d c75236        	ld	21046,a
 587                     ; 109     UART1->CR1 &= (uint8_t)(~(UART1_CR1_PCEN | UART1_CR1_PS  ));  
 589  0150 c65234        	ld	a,21044
 590  0153 a4f9          	and	a,#249
 591  0155 c75234        	ld	21044,a
 592                     ; 111     UART1->CR1 |= (uint8_t)Parity;  
 594  0158 c65234        	ld	a,21044
 595  015b 1a15          	or	a,(OFST+9,sp)
 596  015d c75234        	ld	21044,a
 597                     ; 114     UART1->BRR1 &= (uint8_t)(~UART1_BRR1_DIVM);  
 599  0160 725f5232      	clr	21042
 600                     ; 116     UART1->BRR2 &= (uint8_t)(~UART1_BRR2_DIVM);  
 602  0164 c65233        	ld	a,21043
 603  0167 a40f          	and	a,#15
 604  0169 c75233        	ld	21043,a
 605                     ; 118     UART1->BRR2 &= (uint8_t)(~UART1_BRR2_DIVF);  
 607  016c c65233        	ld	a,21043
 608  016f a4f0          	and	a,#240
 609  0171 c75233        	ld	21043,a
 610                     ; 121     BaudRate_Mantissa    = ((uint32_t)CLK_GetClockFreq() / (BaudRate << 4));
 612  0174 96            	ldw	x,sp
 613  0175 1c000f        	addw	x,#OFST+3
 614  0178 cd0000        	call	c_ltor
 616  017b a604          	ld	a,#4
 617  017d cd0000        	call	c_llsh
 619  0180 96            	ldw	x,sp
 620  0181 1c0001        	addw	x,#OFST-11
 621  0184 cd0000        	call	c_rtol
 624  0187 cd0000        	call	_CLK_GetClockFreq
 626  018a 96            	ldw	x,sp
 627  018b 1c0001        	addw	x,#OFST-11
 628  018e cd0000        	call	c_ludv
 630  0191 96            	ldw	x,sp
 631  0192 1c0009        	addw	x,#OFST-3
 632  0195 cd0000        	call	c_rtol
 635                     ; 122     BaudRate_Mantissa100 = (((uint32_t)CLK_GetClockFreq() * 100) / (BaudRate << 4));
 637  0198 96            	ldw	x,sp
 638  0199 1c000f        	addw	x,#OFST+3
 639  019c cd0000        	call	c_ltor
 641  019f a604          	ld	a,#4
 642  01a1 cd0000        	call	c_llsh
 644  01a4 96            	ldw	x,sp
 645  01a5 1c0001        	addw	x,#OFST-11
 646  01a8 cd0000        	call	c_rtol
 649  01ab cd0000        	call	_CLK_GetClockFreq
 651  01ae a664          	ld	a,#100
 652  01b0 cd0000        	call	c_smul
 654  01b3 96            	ldw	x,sp
 655  01b4 1c0001        	addw	x,#OFST-11
 656  01b7 cd0000        	call	c_ludv
 658  01ba 96            	ldw	x,sp
 659  01bb 1c0005        	addw	x,#OFST-7
 660  01be cd0000        	call	c_rtol
 663                     ; 124     UART1->BRR2 |= (uint8_t)((uint8_t)(((BaudRate_Mantissa100 - (BaudRate_Mantissa * 100)) << 4) / 100) & (uint8_t)0x0F); 
 665  01c1 96            	ldw	x,sp
 666  01c2 1c0009        	addw	x,#OFST-3
 667  01c5 cd0000        	call	c_ltor
 669  01c8 a664          	ld	a,#100
 670  01ca cd0000        	call	c_smul
 672  01cd 96            	ldw	x,sp
 673  01ce 1c0001        	addw	x,#OFST-11
 674  01d1 cd0000        	call	c_rtol
 677  01d4 96            	ldw	x,sp
 678  01d5 1c0005        	addw	x,#OFST-7
 679  01d8 cd0000        	call	c_ltor
 681  01db 96            	ldw	x,sp
 682  01dc 1c0001        	addw	x,#OFST-11
 683  01df cd0000        	call	c_lsub
 685  01e2 a604          	ld	a,#4
 686  01e4 cd0000        	call	c_llsh
 688  01e7 ae0004        	ldw	x,#L25
 689  01ea cd0000        	call	c_ludv
 691  01ed b603          	ld	a,c_lreg+3
 692  01ef a40f          	and	a,#15
 693  01f1 ca5233        	or	a,21043
 694  01f4 c75233        	ld	21043,a
 695                     ; 126     UART1->BRR2 |= (uint8_t)((BaudRate_Mantissa >> 4) & (uint8_t)0xF0); 
 697  01f7 96            	ldw	x,sp
 698  01f8 1c0009        	addw	x,#OFST-3
 699  01fb cd0000        	call	c_ltor
 701  01fe a604          	ld	a,#4
 702  0200 cd0000        	call	c_lursh
 704  0203 b603          	ld	a,c_lreg+3
 705  0205 a4f0          	and	a,#240
 706  0207 b703          	ld	c_lreg+3,a
 707  0209 3f02          	clr	c_lreg+2
 708  020b 3f01          	clr	c_lreg+1
 709  020d 3f00          	clr	c_lreg
 710  020f b603          	ld	a,c_lreg+3
 711  0211 ca5233        	or	a,21043
 712  0214 c75233        	ld	21043,a
 713                     ; 128     UART1->BRR1 |= (uint8_t)BaudRate_Mantissa;           
 715  0217 c65232        	ld	a,21042
 716  021a 1a0c          	or	a,(OFST+0,sp)
 717  021c c75232        	ld	21042,a
 718                     ; 131     UART1->CR2 &= (uint8_t)~(UART1_CR2_TEN | UART1_CR2_REN); 
 720  021f c65235        	ld	a,21045
 721  0222 a4f3          	and	a,#243
 722  0224 c75235        	ld	21045,a
 723                     ; 133     UART1->CR3 &= (uint8_t)~(UART1_CR3_CPOL | UART1_CR3_CPHA | UART1_CR3_LBCL); 
 725  0227 c65236        	ld	a,21046
 726  022a a4f8          	and	a,#248
 727  022c c75236        	ld	21046,a
 728                     ; 135     UART1->CR3 |= (uint8_t)((uint8_t)SyncMode & (uint8_t)(UART1_CR3_CPOL | 
 728                     ; 136                                               UART1_CR3_CPHA | UART1_CR3_LBCL));  
 730  022f 7b16          	ld	a,(OFST+10,sp)
 731  0231 a407          	and	a,#7
 732  0233 ca5236        	or	a,21046
 733  0236 c75236        	ld	21046,a
 734                     ; 138     if ((uint8_t)(Mode & UART1_MODE_TX_ENABLE))
 736  0239 7b17          	ld	a,(OFST+11,sp)
 737  023b a504          	bcp	a,#4
 738  023d 2706          	jreq	L571
 739                     ; 141         UART1->CR2 |= (uint8_t)UART1_CR2_TEN;  
 741  023f 72165235      	bset	21045,#3
 743  0243 2004          	jra	L771
 744  0245               L571:
 745                     ; 146         UART1->CR2 &= (uint8_t)(~UART1_CR2_TEN);  
 747  0245 72175235      	bres	21045,#3
 748  0249               L771:
 749                     ; 148     if ((uint8_t)(Mode & UART1_MODE_RX_ENABLE))
 751  0249 7b17          	ld	a,(OFST+11,sp)
 752  024b a508          	bcp	a,#8
 753  024d 2706          	jreq	L102
 754                     ; 151         UART1->CR2 |= (uint8_t)UART1_CR2_REN;  
 756  024f 72145235      	bset	21045,#2
 758  0253 2004          	jra	L302
 759  0255               L102:
 760                     ; 156         UART1->CR2 &= (uint8_t)(~UART1_CR2_REN);  
 762  0255 72155235      	bres	21045,#2
 763  0259               L302:
 764                     ; 160     if ((uint8_t)(SyncMode & UART1_SYNCMODE_CLOCK_DISABLE))
 766  0259 7b16          	ld	a,(OFST+10,sp)
 767  025b a580          	bcp	a,#128
 768  025d 2706          	jreq	L502
 769                     ; 163         UART1->CR3 &= (uint8_t)(~UART1_CR3_CKEN); 
 771  025f 72175236      	bres	21046,#3
 773  0263 200a          	jra	L702
 774  0265               L502:
 775                     ; 167         UART1->CR3 |= (uint8_t)((uint8_t)SyncMode & UART1_CR3_CKEN);
 777  0265 7b16          	ld	a,(OFST+10,sp)
 778  0267 a408          	and	a,#8
 779  0269 ca5236        	or	a,21046
 780  026c c75236        	ld	21046,a
 781  026f               L702:
 782                     ; 169 }
 785  026f 5b0c          	addw	sp,#12
 786  0271 81            	ret
 841                     ; 177 void UART1_Cmd(FunctionalState NewState)
 841                     ; 178 {
 842                     	switch	.text
 843  0272               _UART1_Cmd:
 847                     ; 179     if (NewState != DISABLE)
 849  0272 4d            	tnz	a
 850  0273 2706          	jreq	L732
 851                     ; 182         UART1->CR1 &= (uint8_t)(~UART1_CR1_UARTD); 
 853  0275 721b5234      	bres	21044,#5
 855  0279 2004          	jra	L142
 856  027b               L732:
 857                     ; 187         UART1->CR1 |= UART1_CR1_UARTD;  
 859  027b 721a5234      	bset	21044,#5
 860  027f               L142:
 861                     ; 189 }
 864  027f 81            	ret
 990                     ; 205 void UART1_ITConfig(UART1_IT_TypeDef UART1_IT, FunctionalState NewState)
 990                     ; 206 {
 991                     	switch	.text
 992  0280               _UART1_ITConfig:
 994  0280 89            	pushw	x
 995  0281 89            	pushw	x
 996       00000002      OFST:	set	2
 999                     ; 207     uint8_t uartreg = 0, itpos = 0x00;
1003                     ; 210     assert_param(IS_UART1_CONFIG_IT_OK(UART1_IT));
1005  0282 a30100        	cpw	x,#256
1006  0285 2719          	jreq	L26
1007  0287 a30277        	cpw	x,#631
1008  028a 2714          	jreq	L26
1009  028c a30266        	cpw	x,#614
1010  028f 270f          	jreq	L26
1011  0291 a30205        	cpw	x,#517
1012  0294 270a          	jreq	L26
1013  0296 a30244        	cpw	x,#580
1014  0299 2705          	jreq	L26
1015  029b a30346        	cpw	x,#838
1016  029e 2603          	jrne	L06
1017  02a0               L26:
1018  02a0 4f            	clr	a
1019  02a1 2010          	jra	L46
1020  02a3               L06:
1021  02a3 ae00d2        	ldw	x,#210
1022  02a6 89            	pushw	x
1023  02a7 ae0000        	ldw	x,#0
1024  02aa 89            	pushw	x
1025  02ab ae0008        	ldw	x,#L371
1026  02ae cd0000        	call	_assert_failed
1028  02b1 5b04          	addw	sp,#4
1029  02b3               L46:
1030                     ; 211     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1032  02b3 0d07          	tnz	(OFST+5,sp)
1033  02b5 2706          	jreq	L07
1034  02b7 7b07          	ld	a,(OFST+5,sp)
1035  02b9 a101          	cp	a,#1
1036  02bb 2603          	jrne	L66
1037  02bd               L07:
1038  02bd 4f            	clr	a
1039  02be 2010          	jra	L27
1040  02c0               L66:
1041  02c0 ae00d3        	ldw	x,#211
1042  02c3 89            	pushw	x
1043  02c4 ae0000        	ldw	x,#0
1044  02c7 89            	pushw	x
1045  02c8 ae0008        	ldw	x,#L371
1046  02cb cd0000        	call	_assert_failed
1048  02ce 5b04          	addw	sp,#4
1049  02d0               L27:
1050                     ; 214     uartreg = (uint8_t)((uint16_t)UART1_IT >> 0x08);
1052  02d0 7b03          	ld	a,(OFST+1,sp)
1053  02d2 6b01          	ld	(OFST-1,sp),a
1055                     ; 216     itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)UART1_IT & (uint8_t)0x0F));
1057  02d4 7b04          	ld	a,(OFST+2,sp)
1058  02d6 a40f          	and	a,#15
1059  02d8 5f            	clrw	x
1060  02d9 97            	ld	xl,a
1061  02da a601          	ld	a,#1
1062  02dc 5d            	tnzw	x
1063  02dd 2704          	jreq	L47
1064  02df               L67:
1065  02df 48            	sll	a
1066  02e0 5a            	decw	x
1067  02e1 26fc          	jrne	L67
1068  02e3               L47:
1069  02e3 6b02          	ld	(OFST+0,sp),a
1071                     ; 218     if (NewState != DISABLE)
1073  02e5 0d07          	tnz	(OFST+5,sp)
1074  02e7 272a          	jreq	L123
1075                     ; 221         if (uartreg == 0x01)
1077  02e9 7b01          	ld	a,(OFST-1,sp)
1078  02eb a101          	cp	a,#1
1079  02ed 260a          	jrne	L323
1080                     ; 223             UART1->CR1 |= itpos;
1082  02ef c65234        	ld	a,21044
1083  02f2 1a02          	or	a,(OFST+0,sp)
1084  02f4 c75234        	ld	21044,a
1086  02f7 2045          	jra	L333
1087  02f9               L323:
1088                     ; 225         else if (uartreg == 0x02)
1090  02f9 7b01          	ld	a,(OFST-1,sp)
1091  02fb a102          	cp	a,#2
1092  02fd 260a          	jrne	L723
1093                     ; 227             UART1->CR2 |= itpos;
1095  02ff c65235        	ld	a,21045
1096  0302 1a02          	or	a,(OFST+0,sp)
1097  0304 c75235        	ld	21045,a
1099  0307 2035          	jra	L333
1100  0309               L723:
1101                     ; 231             UART1->CR4 |= itpos;
1103  0309 c65237        	ld	a,21047
1104  030c 1a02          	or	a,(OFST+0,sp)
1105  030e c75237        	ld	21047,a
1106  0311 202b          	jra	L333
1107  0313               L123:
1108                     ; 237         if (uartreg == 0x01)
1110  0313 7b01          	ld	a,(OFST-1,sp)
1111  0315 a101          	cp	a,#1
1112  0317 260b          	jrne	L533
1113                     ; 239             UART1->CR1 &= (uint8_t)(~itpos);
1115  0319 7b02          	ld	a,(OFST+0,sp)
1116  031b 43            	cpl	a
1117  031c c45234        	and	a,21044
1118  031f c75234        	ld	21044,a
1120  0322 201a          	jra	L333
1121  0324               L533:
1122                     ; 241         else if (uartreg == 0x02)
1124  0324 7b01          	ld	a,(OFST-1,sp)
1125  0326 a102          	cp	a,#2
1126  0328 260b          	jrne	L143
1127                     ; 243             UART1->CR2 &= (uint8_t)(~itpos);
1129  032a 7b02          	ld	a,(OFST+0,sp)
1130  032c 43            	cpl	a
1131  032d c45235        	and	a,21045
1132  0330 c75235        	ld	21045,a
1134  0333 2009          	jra	L333
1135  0335               L143:
1136                     ; 247             UART1->CR4 &= (uint8_t)(~itpos);
1138  0335 7b02          	ld	a,(OFST+0,sp)
1139  0337 43            	cpl	a
1140  0338 c45237        	and	a,21047
1141  033b c75237        	ld	21047,a
1142  033e               L333:
1143                     ; 251 }
1146  033e 5b04          	addw	sp,#4
1147  0340 81            	ret
1184                     ; 258 void UART1_HalfDuplexCmd(FunctionalState NewState)
1184                     ; 259 {
1185                     	switch	.text
1186  0341               _UART1_HalfDuplexCmd:
1188  0341 88            	push	a
1189       00000000      OFST:	set	0
1192                     ; 260     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1194  0342 4d            	tnz	a
1195  0343 2704          	jreq	L401
1196  0345 a101          	cp	a,#1
1197  0347 2603          	jrne	L201
1198  0349               L401:
1199  0349 4f            	clr	a
1200  034a 2010          	jra	L601
1201  034c               L201:
1202  034c ae0104        	ldw	x,#260
1203  034f 89            	pushw	x
1204  0350 ae0000        	ldw	x,#0
1205  0353 89            	pushw	x
1206  0354 ae0008        	ldw	x,#L371
1207  0357 cd0000        	call	_assert_failed
1209  035a 5b04          	addw	sp,#4
1210  035c               L601:
1211                     ; 262     if (NewState != DISABLE)
1213  035c 0d01          	tnz	(OFST+1,sp)
1214  035e 2706          	jreq	L363
1215                     ; 264         UART1->CR5 |= UART1_CR5_HDSEL;  /**< UART1 Half Duplex Enable  */
1217  0360 72165238      	bset	21048,#3
1219  0364 2004          	jra	L563
1220  0366               L363:
1221                     ; 268         UART1->CR5 &= (uint8_t)~UART1_CR5_HDSEL; /**< UART1 Half Duplex Disable */
1223  0366 72175238      	bres	21048,#3
1224  036a               L563:
1225                     ; 270 }
1228  036a 84            	pop	a
1229  036b 81            	ret
1287                     ; 278 void UART1_IrDAConfig(UART1_IrDAMode_TypeDef UART1_IrDAMode)
1287                     ; 279 {
1288                     	switch	.text
1289  036c               _UART1_IrDAConfig:
1291  036c 88            	push	a
1292       00000000      OFST:	set	0
1295                     ; 280     assert_param(IS_UART1_IRDAMODE_OK(UART1_IrDAMode));
1297  036d a101          	cp	a,#1
1298  036f 2703          	jreq	L411
1299  0371 4d            	tnz	a
1300  0372 2603          	jrne	L211
1301  0374               L411:
1302  0374 4f            	clr	a
1303  0375 2010          	jra	L611
1304  0377               L211:
1305  0377 ae0118        	ldw	x,#280
1306  037a 89            	pushw	x
1307  037b ae0000        	ldw	x,#0
1308  037e 89            	pushw	x
1309  037f ae0008        	ldw	x,#L371
1310  0382 cd0000        	call	_assert_failed
1312  0385 5b04          	addw	sp,#4
1313  0387               L611:
1314                     ; 282     if (UART1_IrDAMode != UART1_IRDAMODE_NORMAL)
1316  0387 0d01          	tnz	(OFST+1,sp)
1317  0389 2706          	jreq	L514
1318                     ; 284         UART1->CR5 |= UART1_CR5_IRLP;
1320  038b 72145238      	bset	21048,#2
1322  038f 2004          	jra	L714
1323  0391               L514:
1324                     ; 288         UART1->CR5 &= ((uint8_t)~UART1_CR5_IRLP);
1326  0391 72155238      	bres	21048,#2
1327  0395               L714:
1328                     ; 290 }
1331  0395 84            	pop	a
1332  0396 81            	ret
1368                     ; 298 void UART1_IrDACmd(FunctionalState NewState)
1368                     ; 299 {
1369                     	switch	.text
1370  0397               _UART1_IrDACmd:
1372  0397 88            	push	a
1373       00000000      OFST:	set	0
1376                     ; 302     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1378  0398 4d            	tnz	a
1379  0399 2704          	jreq	L421
1380  039b a101          	cp	a,#1
1381  039d 2603          	jrne	L221
1382  039f               L421:
1383  039f 4f            	clr	a
1384  03a0 2010          	jra	L621
1385  03a2               L221:
1386  03a2 ae012e        	ldw	x,#302
1387  03a5 89            	pushw	x
1388  03a6 ae0000        	ldw	x,#0
1389  03a9 89            	pushw	x
1390  03aa ae0008        	ldw	x,#L371
1391  03ad cd0000        	call	_assert_failed
1393  03b0 5b04          	addw	sp,#4
1394  03b2               L621:
1395                     ; 304     if (NewState != DISABLE)
1397  03b2 0d01          	tnz	(OFST+1,sp)
1398  03b4 2706          	jreq	L734
1399                     ; 307         UART1->CR5 |= UART1_CR5_IREN;
1401  03b6 72125238      	bset	21048,#1
1403  03ba 2004          	jra	L144
1404  03bc               L734:
1405                     ; 312         UART1->CR5 &= ((uint8_t)~UART1_CR5_IREN);
1407  03bc 72135238      	bres	21048,#1
1408  03c0               L144:
1409                     ; 314 }
1412  03c0 84            	pop	a
1413  03c1 81            	ret
1473                     ; 323 void UART1_LINBreakDetectionConfig(UART1_LINBreakDetectionLength_TypeDef UART1_LINBreakDetectionLength)
1473                     ; 324 {
1474                     	switch	.text
1475  03c2               _UART1_LINBreakDetectionConfig:
1477  03c2 88            	push	a
1478       00000000      OFST:	set	0
1481                     ; 325     assert_param(IS_UART1_LINBREAKDETECTIONLENGTH_OK(UART1_LINBreakDetectionLength));
1483  03c3 4d            	tnz	a
1484  03c4 2704          	jreq	L431
1485  03c6 a101          	cp	a,#1
1486  03c8 2603          	jrne	L231
1487  03ca               L431:
1488  03ca 4f            	clr	a
1489  03cb 2010          	jra	L631
1490  03cd               L231:
1491  03cd ae0145        	ldw	x,#325
1492  03d0 89            	pushw	x
1493  03d1 ae0000        	ldw	x,#0
1494  03d4 89            	pushw	x
1495  03d5 ae0008        	ldw	x,#L371
1496  03d8 cd0000        	call	_assert_failed
1498  03db 5b04          	addw	sp,#4
1499  03dd               L631:
1500                     ; 327     if (UART1_LINBreakDetectionLength != UART1_LINBREAKDETECTIONLENGTH_10BITS)
1502  03dd 0d01          	tnz	(OFST+1,sp)
1503  03df 2706          	jreq	L174
1504                     ; 329         UART1->CR4 |= UART1_CR4_LBDL;
1506  03e1 721a5237      	bset	21047,#5
1508  03e5 2004          	jra	L374
1509  03e7               L174:
1510                     ; 333         UART1->CR4 &= ((uint8_t)~UART1_CR4_LBDL);
1512  03e7 721b5237      	bres	21047,#5
1513  03eb               L374:
1514                     ; 335 }
1517  03eb 84            	pop	a
1518  03ec 81            	ret
1554                     ; 343 void UART1_LINCmd(FunctionalState NewState)
1554                     ; 344 {
1555                     	switch	.text
1556  03ed               _UART1_LINCmd:
1558  03ed 88            	push	a
1559       00000000      OFST:	set	0
1562                     ; 345     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1564  03ee 4d            	tnz	a
1565  03ef 2704          	jreq	L441
1566  03f1 a101          	cp	a,#1
1567  03f3 2603          	jrne	L241
1568  03f5               L441:
1569  03f5 4f            	clr	a
1570  03f6 2010          	jra	L641
1571  03f8               L241:
1572  03f8 ae0159        	ldw	x,#345
1573  03fb 89            	pushw	x
1574  03fc ae0000        	ldw	x,#0
1575  03ff 89            	pushw	x
1576  0400 ae0008        	ldw	x,#L371
1577  0403 cd0000        	call	_assert_failed
1579  0406 5b04          	addw	sp,#4
1580  0408               L641:
1581                     ; 347     if (NewState != DISABLE)
1583  0408 0d01          	tnz	(OFST+1,sp)
1584  040a 2706          	jreq	L315
1585                     ; 350         UART1->CR3 |= UART1_CR3_LINEN;
1587  040c 721c5236      	bset	21046,#6
1589  0410 2004          	jra	L515
1590  0412               L315:
1591                     ; 355         UART1->CR3 &= ((uint8_t)~UART1_CR3_LINEN);
1593  0412 721d5236      	bres	21046,#6
1594  0416               L515:
1595                     ; 357 }
1598  0416 84            	pop	a
1599  0417 81            	ret
1635                     ; 364 void UART1_SmartCardCmd(FunctionalState NewState)
1635                     ; 365 {
1636                     	switch	.text
1637  0418               _UART1_SmartCardCmd:
1639  0418 88            	push	a
1640       00000000      OFST:	set	0
1643                     ; 366     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1645  0419 4d            	tnz	a
1646  041a 2704          	jreq	L451
1647  041c a101          	cp	a,#1
1648  041e 2603          	jrne	L251
1649  0420               L451:
1650  0420 4f            	clr	a
1651  0421 2010          	jra	L651
1652  0423               L251:
1653  0423 ae016e        	ldw	x,#366
1654  0426 89            	pushw	x
1655  0427 ae0000        	ldw	x,#0
1656  042a 89            	pushw	x
1657  042b ae0008        	ldw	x,#L371
1658  042e cd0000        	call	_assert_failed
1660  0431 5b04          	addw	sp,#4
1661  0433               L651:
1662                     ; 368     if (NewState != DISABLE)
1664  0433 0d01          	tnz	(OFST+1,sp)
1665  0435 2706          	jreq	L535
1666                     ; 371         UART1->CR5 |= UART1_CR5_SCEN;
1668  0437 721a5238      	bset	21048,#5
1670  043b 2004          	jra	L735
1671  043d               L535:
1672                     ; 376         UART1->CR5 &= ((uint8_t)(~UART1_CR5_SCEN));
1674  043d 721b5238      	bres	21048,#5
1675  0441               L735:
1676                     ; 378 }
1679  0441 84            	pop	a
1680  0442 81            	ret
1717                     ; 387 void UART1_SmartCardNACKCmd(FunctionalState NewState)
1717                     ; 388 {
1718                     	switch	.text
1719  0443               _UART1_SmartCardNACKCmd:
1721  0443 88            	push	a
1722       00000000      OFST:	set	0
1725                     ; 389     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1727  0444 4d            	tnz	a
1728  0445 2704          	jreq	L461
1729  0447 a101          	cp	a,#1
1730  0449 2603          	jrne	L261
1731  044b               L461:
1732  044b 4f            	clr	a
1733  044c 2010          	jra	L661
1734  044e               L261:
1735  044e ae0185        	ldw	x,#389
1736  0451 89            	pushw	x
1737  0452 ae0000        	ldw	x,#0
1738  0455 89            	pushw	x
1739  0456 ae0008        	ldw	x,#L371
1740  0459 cd0000        	call	_assert_failed
1742  045c 5b04          	addw	sp,#4
1743  045e               L661:
1744                     ; 391     if (NewState != DISABLE)
1746  045e 0d01          	tnz	(OFST+1,sp)
1747  0460 2706          	jreq	L755
1748                     ; 394         UART1->CR5 |= UART1_CR5_NACK;
1750  0462 72185238      	bset	21048,#4
1752  0466 2004          	jra	L165
1753  0468               L755:
1754                     ; 399         UART1->CR5 &= ((uint8_t)~(UART1_CR5_NACK));
1756  0468 72195238      	bres	21048,#4
1757  046c               L165:
1758                     ; 401 }
1761  046c 84            	pop	a
1762  046d 81            	ret
1820                     ; 409 void UART1_WakeUpConfig(UART1_WakeUp_TypeDef UART1_WakeUp)
1820                     ; 410 {
1821                     	switch	.text
1822  046e               _UART1_WakeUpConfig:
1824  046e 88            	push	a
1825       00000000      OFST:	set	0
1828                     ; 411     assert_param(IS_UART1_WAKEUP_OK(UART1_WakeUp));
1830  046f 4d            	tnz	a
1831  0470 2704          	jreq	L471
1832  0472 a108          	cp	a,#8
1833  0474 2603          	jrne	L271
1834  0476               L471:
1835  0476 4f            	clr	a
1836  0477 2010          	jra	L671
1837  0479               L271:
1838  0479 ae019b        	ldw	x,#411
1839  047c 89            	pushw	x
1840  047d ae0000        	ldw	x,#0
1841  0480 89            	pushw	x
1842  0481 ae0008        	ldw	x,#L371
1843  0484 cd0000        	call	_assert_failed
1845  0487 5b04          	addw	sp,#4
1846  0489               L671:
1847                     ; 413     UART1->CR1 &= ((uint8_t)~UART1_CR1_WAKE);
1849  0489 72175234      	bres	21044,#3
1850                     ; 414     UART1->CR1 |= (uint8_t)UART1_WakeUp;
1852  048d c65234        	ld	a,21044
1853  0490 1a01          	or	a,(OFST+1,sp)
1854  0492 c75234        	ld	21044,a
1855                     ; 415 }
1858  0495 84            	pop	a
1859  0496 81            	ret
1896                     ; 422 void UART1_ReceiverWakeUpCmd(FunctionalState NewState)
1896                     ; 423 {
1897                     	switch	.text
1898  0497               _UART1_ReceiverWakeUpCmd:
1900  0497 88            	push	a
1901       00000000      OFST:	set	0
1904                     ; 424     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1906  0498 4d            	tnz	a
1907  0499 2704          	jreq	L402
1908  049b a101          	cp	a,#1
1909  049d 2603          	jrne	L202
1910  049f               L402:
1911  049f 4f            	clr	a
1912  04a0 2010          	jra	L602
1913  04a2               L202:
1914  04a2 ae01a8        	ldw	x,#424
1915  04a5 89            	pushw	x
1916  04a6 ae0000        	ldw	x,#0
1917  04a9 89            	pushw	x
1918  04aa ae0008        	ldw	x,#L371
1919  04ad cd0000        	call	_assert_failed
1921  04b0 5b04          	addw	sp,#4
1922  04b2               L602:
1923                     ; 426     if (NewState != DISABLE)
1925  04b2 0d01          	tnz	(OFST+1,sp)
1926  04b4 2706          	jreq	L726
1927                     ; 429         UART1->CR2 |= UART1_CR2_RWU;
1929  04b6 72125235      	bset	21045,#1
1931  04ba 2004          	jra	L136
1932  04bc               L726:
1933                     ; 434         UART1->CR2 &= ((uint8_t)~UART1_CR2_RWU);
1935  04bc 72135235      	bres	21045,#1
1936  04c0               L136:
1937                     ; 436 }
1940  04c0 84            	pop	a
1941  04c1 81            	ret
1964                     ; 443 uint8_t UART1_ReceiveData8(void)
1964                     ; 444 {
1965                     	switch	.text
1966  04c2               _UART1_ReceiveData8:
1970                     ; 445     return ((uint8_t)UART1->DR);
1972  04c2 c65231        	ld	a,21041
1975  04c5 81            	ret
2009                     ; 453 uint16_t UART1_ReceiveData9(void)
2009                     ; 454 {
2010                     	switch	.text
2011  04c6               _UART1_ReceiveData9:
2013  04c6 89            	pushw	x
2014       00000002      OFST:	set	2
2017                     ; 455   uint16_t temp = 0;
2019                     ; 457   temp = (uint16_t)(((uint16_t)( (uint16_t)UART1->CR1 & (uint16_t)UART1_CR1_R8)) << 1);
2021  04c7 c65234        	ld	a,21044
2022  04ca 5f            	clrw	x
2023  04cb a480          	and	a,#128
2024  04cd 5f            	clrw	x
2025  04ce 02            	rlwa	x,a
2026  04cf 58            	sllw	x
2027  04d0 1f01          	ldw	(OFST-1,sp),x
2029                     ; 458   return (uint16_t)( (((uint16_t) UART1->DR) | temp ) & ((uint16_t)0x01FF));
2031  04d2 c65231        	ld	a,21041
2032  04d5 5f            	clrw	x
2033  04d6 97            	ld	xl,a
2034  04d7 01            	rrwa	x,a
2035  04d8 1a02          	or	a,(OFST+0,sp)
2036  04da 01            	rrwa	x,a
2037  04db 1a01          	or	a,(OFST-1,sp)
2038  04dd 01            	rrwa	x,a
2039  04de 01            	rrwa	x,a
2040  04df a4ff          	and	a,#255
2041  04e1 01            	rrwa	x,a
2042  04e2 a401          	and	a,#1
2043  04e4 01            	rrwa	x,a
2046  04e5 5b02          	addw	sp,#2
2047  04e7 81            	ret
2081                     ; 466 void UART1_SendData8(uint8_t Data)
2081                     ; 467 {
2082                     	switch	.text
2083  04e8               _UART1_SendData8:
2087                     ; 469     UART1->DR = Data;
2089  04e8 c75231        	ld	21041,a
2090                     ; 470 }
2093  04eb 81            	ret
2127                     ; 478 void UART1_SendData9(uint16_t Data)
2127                     ; 479 {
2128                     	switch	.text
2129  04ec               _UART1_SendData9:
2131  04ec 89            	pushw	x
2132       00000000      OFST:	set	0
2135                     ; 481     UART1->CR1 &= ((uint8_t)~UART1_CR1_T8);
2137  04ed 721d5234      	bres	21044,#6
2138                     ; 483     UART1->CR1 |= (uint8_t)(((uint8_t)(Data >> 2)) & UART1_CR1_T8);
2140  04f1 54            	srlw	x
2141  04f2 54            	srlw	x
2142  04f3 9f            	ld	a,xl
2143  04f4 a440          	and	a,#64
2144  04f6 ca5234        	or	a,21044
2145  04f9 c75234        	ld	21044,a
2146                     ; 485     UART1->DR   = (uint8_t)(Data);
2148  04fc 7b02          	ld	a,(OFST+2,sp)
2149  04fe c75231        	ld	21041,a
2150                     ; 486 }
2153  0501 85            	popw	x
2154  0502 81            	ret
2177                     ; 493 void UART1_SendBreak(void)
2177                     ; 494 {
2178                     	switch	.text
2179  0503               _UART1_SendBreak:
2183                     ; 495     UART1->CR2 |= UART1_CR2_SBK;
2185  0503 72105235      	bset	21045,#0
2186                     ; 496 }
2189  0507 81            	ret
2224                     ; 503 void UART1_SetAddress(uint8_t UART1_Address)
2224                     ; 504 {
2225                     	switch	.text
2226  0508               _UART1_SetAddress:
2228  0508 88            	push	a
2229       00000000      OFST:	set	0
2232                     ; 506     assert_param(IS_UART1_ADDRESS_OK(UART1_Address));
2234  0509 a110          	cp	a,#16
2235  050b 2403          	jruge	L422
2236  050d 4f            	clr	a
2237  050e 2010          	jra	L622
2238  0510               L422:
2239  0510 ae01fa        	ldw	x,#506
2240  0513 89            	pushw	x
2241  0514 ae0000        	ldw	x,#0
2242  0517 89            	pushw	x
2243  0518 ae0008        	ldw	x,#L371
2244  051b cd0000        	call	_assert_failed
2246  051e 5b04          	addw	sp,#4
2247  0520               L622:
2248                     ; 509     UART1->CR4 &= ((uint8_t)~UART1_CR4_ADD);
2250  0520 c65237        	ld	a,21047
2251  0523 a4f0          	and	a,#240
2252  0525 c75237        	ld	21047,a
2253                     ; 511     UART1->CR4 |= UART1_Address;
2255  0528 c65237        	ld	a,21047
2256  052b 1a01          	or	a,(OFST+1,sp)
2257  052d c75237        	ld	21047,a
2258                     ; 512 }
2261  0530 84            	pop	a
2262  0531 81            	ret
2296                     ; 520 void UART1_SetGuardTime(uint8_t UART1_GuardTime)
2296                     ; 521 {
2297                     	switch	.text
2298  0532               _UART1_SetGuardTime:
2302                     ; 523     UART1->GTR = UART1_GuardTime;
2304  0532 c75239        	ld	21049,a
2305                     ; 524 }
2308  0535 81            	ret
2342                     ; 548 void UART1_SetPrescaler(uint8_t UART1_Prescaler)
2342                     ; 549 {
2343                     	switch	.text
2344  0536               _UART1_SetPrescaler:
2348                     ; 551     UART1->PSCR = UART1_Prescaler;
2350  0536 c7523a        	ld	21050,a
2351                     ; 552 }
2354  0539 81            	ret
2498                     ; 560 FlagStatus UART1_GetFlagStatus(UART1_Flag_TypeDef UART1_FLAG)
2498                     ; 561 {
2499                     	switch	.text
2500  053a               _UART1_GetFlagStatus:
2502  053a 89            	pushw	x
2503  053b 88            	push	a
2504       00000001      OFST:	set	1
2507                     ; 562     FlagStatus status = RESET;
2509                     ; 565     assert_param(IS_UART1_FLAG_OK(UART1_FLAG));
2511  053c a30080        	cpw	x,#128
2512  053f 272d          	jreq	L042
2513  0541 a30040        	cpw	x,#64
2514  0544 2728          	jreq	L042
2515  0546 a30020        	cpw	x,#32
2516  0549 2723          	jreq	L042
2517  054b a30010        	cpw	x,#16
2518  054e 271e          	jreq	L042
2519  0550 a30008        	cpw	x,#8
2520  0553 2719          	jreq	L042
2521  0555 a30004        	cpw	x,#4
2522  0558 2714          	jreq	L042
2523  055a a30002        	cpw	x,#2
2524  055d 270f          	jreq	L042
2525  055f a30001        	cpw	x,#1
2526  0562 270a          	jreq	L042
2527  0564 a30101        	cpw	x,#257
2528  0567 2705          	jreq	L042
2529  0569 a30210        	cpw	x,#528
2530  056c 2603          	jrne	L632
2531  056e               L042:
2532  056e 4f            	clr	a
2533  056f 2010          	jra	L242
2534  0571               L632:
2535  0571 ae0235        	ldw	x,#565
2536  0574 89            	pushw	x
2537  0575 ae0000        	ldw	x,#0
2538  0578 89            	pushw	x
2539  0579 ae0008        	ldw	x,#L371
2540  057c cd0000        	call	_assert_failed
2542  057f 5b04          	addw	sp,#4
2543  0581               L242:
2544                     ; 569     if (UART1_FLAG == UART1_FLAG_LBDF)
2546  0581 1e02          	ldw	x,(OFST+1,sp)
2547  0583 a30210        	cpw	x,#528
2548  0586 2611          	jrne	L1601
2549                     ; 571         if ((UART1->CR4 & (uint8_t)UART1_FLAG) != (uint8_t)0x00)
2551  0588 c65237        	ld	a,21047
2552  058b 1503          	bcp	a,(OFST+2,sp)
2553  058d 2706          	jreq	L3601
2554                     ; 574             status = SET;
2556  058f a601          	ld	a,#1
2557  0591 6b01          	ld	(OFST+0,sp),a
2560  0593 202b          	jra	L7601
2561  0595               L3601:
2562                     ; 579             status = RESET;
2564  0595 0f01          	clr	(OFST+0,sp)
2566  0597 2027          	jra	L7601
2567  0599               L1601:
2568                     ; 582     else if (UART1_FLAG == UART1_FLAG_SBK)
2570  0599 1e02          	ldw	x,(OFST+1,sp)
2571  059b a30101        	cpw	x,#257
2572  059e 2611          	jrne	L1701
2573                     ; 584         if ((UART1->CR2 & (uint8_t)UART1_FLAG) != (uint8_t)0x00)
2575  05a0 c65235        	ld	a,21045
2576  05a3 1503          	bcp	a,(OFST+2,sp)
2577  05a5 2706          	jreq	L3701
2578                     ; 587             status = SET;
2580  05a7 a601          	ld	a,#1
2581  05a9 6b01          	ld	(OFST+0,sp),a
2584  05ab 2013          	jra	L7601
2585  05ad               L3701:
2586                     ; 592             status = RESET;
2588  05ad 0f01          	clr	(OFST+0,sp)
2590  05af 200f          	jra	L7601
2591  05b1               L1701:
2592                     ; 597         if ((UART1->SR & (uint8_t)UART1_FLAG) != (uint8_t)0x00)
2594  05b1 c65230        	ld	a,21040
2595  05b4 1503          	bcp	a,(OFST+2,sp)
2596  05b6 2706          	jreq	L1011
2597                     ; 600             status = SET;
2599  05b8 a601          	ld	a,#1
2600  05ba 6b01          	ld	(OFST+0,sp),a
2603  05bc 2002          	jra	L7601
2604  05be               L1011:
2605                     ; 605             status = RESET;
2607  05be 0f01          	clr	(OFST+0,sp)
2609  05c0               L7601:
2610                     ; 609     return status;
2612  05c0 7b01          	ld	a,(OFST+0,sp)
2615  05c2 5b03          	addw	sp,#3
2616  05c4 81            	ret
2652                     ; 639 void UART1_ClearFlag(UART1_Flag_TypeDef UART1_FLAG)
2652                     ; 640 {
2653                     	switch	.text
2654  05c5               _UART1_ClearFlag:
2656  05c5 89            	pushw	x
2657       00000000      OFST:	set	0
2660                     ; 641     assert_param(IS_UART1_CLEAR_FLAG_OK(UART1_FLAG));
2662  05c6 a30020        	cpw	x,#32
2663  05c9 2705          	jreq	L052
2664  05cb a30210        	cpw	x,#528
2665  05ce 2603          	jrne	L642
2666  05d0               L052:
2667  05d0 4f            	clr	a
2668  05d1 2010          	jra	L252
2669  05d3               L642:
2670  05d3 ae0281        	ldw	x,#641
2671  05d6 89            	pushw	x
2672  05d7 ae0000        	ldw	x,#0
2673  05da 89            	pushw	x
2674  05db ae0008        	ldw	x,#L371
2675  05de cd0000        	call	_assert_failed
2677  05e1 5b04          	addw	sp,#4
2678  05e3               L252:
2679                     ; 644     if (UART1_FLAG == UART1_FLAG_RXNE)
2681  05e3 1e01          	ldw	x,(OFST+1,sp)
2682  05e5 a30020        	cpw	x,#32
2683  05e8 2606          	jrne	L3211
2684                     ; 646         UART1->SR = (uint8_t)~(UART1_SR_RXNE);
2686  05ea 35df5230      	mov	21040,#223
2688  05ee 2004          	jra	L5211
2689  05f0               L3211:
2690                     ; 651         UART1->CR4 &= (uint8_t)~(UART1_CR4_LBDF);
2692  05f0 72195237      	bres	21047,#4
2693  05f4               L5211:
2694                     ; 653 }
2697  05f4 85            	popw	x
2698  05f5 81            	ret
2781                     ; 668 ITStatus UART1_GetITStatus(UART1_IT_TypeDef UART1_IT)
2781                     ; 669 {
2782                     	switch	.text
2783  05f6               _UART1_GetITStatus:
2785  05f6 89            	pushw	x
2786  05f7 89            	pushw	x
2787       00000002      OFST:	set	2
2790                     ; 670     ITStatus pendingbitstatus = RESET;
2792                     ; 671     uint8_t itpos = 0;
2794                     ; 672     uint8_t itmask1 = 0;
2796                     ; 673     uint8_t itmask2 = 0;
2798                     ; 674     uint8_t enablestatus = 0;
2800                     ; 677     assert_param(IS_UART1_GET_IT_OK(UART1_IT));
2802  05f8 a30277        	cpw	x,#631
2803  05fb 271e          	jreq	L062
2804  05fd a30266        	cpw	x,#614
2805  0600 2719          	jreq	L062
2806  0602 a30255        	cpw	x,#597
2807  0605 2714          	jreq	L062
2808  0607 a30244        	cpw	x,#580
2809  060a 270f          	jreq	L062
2810  060c a30235        	cpw	x,#565
2811  060f 270a          	jreq	L062
2812  0611 a30346        	cpw	x,#838
2813  0614 2705          	jreq	L062
2814  0616 a30100        	cpw	x,#256
2815  0619 2603          	jrne	L652
2816  061b               L062:
2817  061b 4f            	clr	a
2818  061c 2010          	jra	L262
2819  061e               L652:
2820  061e ae02a5        	ldw	x,#677
2821  0621 89            	pushw	x
2822  0622 ae0000        	ldw	x,#0
2823  0625 89            	pushw	x
2824  0626 ae0008        	ldw	x,#L371
2825  0629 cd0000        	call	_assert_failed
2827  062c 5b04          	addw	sp,#4
2828  062e               L262:
2829                     ; 680     itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)UART1_IT & (uint8_t)0x0F));
2831  062e 7b04          	ld	a,(OFST+2,sp)
2832  0630 a40f          	and	a,#15
2833  0632 5f            	clrw	x
2834  0633 97            	ld	xl,a
2835  0634 a601          	ld	a,#1
2836  0636 5d            	tnzw	x
2837  0637 2704          	jreq	L462
2838  0639               L662:
2839  0639 48            	sll	a
2840  063a 5a            	decw	x
2841  063b 26fc          	jrne	L662
2842  063d               L462:
2843  063d 6b01          	ld	(OFST-1,sp),a
2845                     ; 682     itmask1 = (uint8_t)((uint8_t)UART1_IT >> (uint8_t)4);
2847  063f 7b04          	ld	a,(OFST+2,sp)
2848  0641 4e            	swap	a
2849  0642 a40f          	and	a,#15
2850  0644 6b02          	ld	(OFST+0,sp),a
2852                     ; 684     itmask2 = (uint8_t)((uint8_t)1 << itmask1);
2854  0646 7b02          	ld	a,(OFST+0,sp)
2855  0648 5f            	clrw	x
2856  0649 97            	ld	xl,a
2857  064a a601          	ld	a,#1
2858  064c 5d            	tnzw	x
2859  064d 2704          	jreq	L072
2860  064f               L272:
2861  064f 48            	sll	a
2862  0650 5a            	decw	x
2863  0651 26fc          	jrne	L272
2864  0653               L072:
2865  0653 6b02          	ld	(OFST+0,sp),a
2867                     ; 688     if (UART1_IT == UART1_IT_PE)
2869  0655 1e03          	ldw	x,(OFST+1,sp)
2870  0657 a30100        	cpw	x,#256
2871  065a 261c          	jrne	L1711
2872                     ; 691         enablestatus = (uint8_t)((uint8_t)UART1->CR1 & itmask2);
2874  065c c65234        	ld	a,21044
2875  065f 1402          	and	a,(OFST+0,sp)
2876  0661 6b02          	ld	(OFST+0,sp),a
2878                     ; 694         if (((UART1->SR & itpos) != (uint8_t)0x00) && enablestatus)
2880  0663 c65230        	ld	a,21040
2881  0666 1501          	bcp	a,(OFST-1,sp)
2882  0668 270a          	jreq	L3711
2884  066a 0d02          	tnz	(OFST+0,sp)
2885  066c 2706          	jreq	L3711
2886                     ; 697             pendingbitstatus = SET;
2888  066e a601          	ld	a,#1
2889  0670 6b02          	ld	(OFST+0,sp),a
2892  0672 2041          	jra	L7711
2893  0674               L3711:
2894                     ; 702             pendingbitstatus = RESET;
2896  0674 0f02          	clr	(OFST+0,sp)
2898  0676 203d          	jra	L7711
2899  0678               L1711:
2900                     ; 706     else if (UART1_IT == UART1_IT_LBDF)
2902  0678 1e03          	ldw	x,(OFST+1,sp)
2903  067a a30346        	cpw	x,#838
2904  067d 261c          	jrne	L1021
2905                     ; 709         enablestatus = (uint8_t)((uint8_t)UART1->CR4 & itmask2);
2907  067f c65237        	ld	a,21047
2908  0682 1402          	and	a,(OFST+0,sp)
2909  0684 6b02          	ld	(OFST+0,sp),a
2911                     ; 711         if (((UART1->CR4 & itpos) != (uint8_t)0x00) && enablestatus)
2913  0686 c65237        	ld	a,21047
2914  0689 1501          	bcp	a,(OFST-1,sp)
2915  068b 270a          	jreq	L3021
2917  068d 0d02          	tnz	(OFST+0,sp)
2918  068f 2706          	jreq	L3021
2919                     ; 714             pendingbitstatus = SET;
2921  0691 a601          	ld	a,#1
2922  0693 6b02          	ld	(OFST+0,sp),a
2925  0695 201e          	jra	L7711
2926  0697               L3021:
2927                     ; 719             pendingbitstatus = RESET;
2929  0697 0f02          	clr	(OFST+0,sp)
2931  0699 201a          	jra	L7711
2932  069b               L1021:
2933                     ; 725         enablestatus = (uint8_t)((uint8_t)UART1->CR2 & itmask2);
2935  069b c65235        	ld	a,21045
2936  069e 1402          	and	a,(OFST+0,sp)
2937  06a0 6b02          	ld	(OFST+0,sp),a
2939                     ; 727         if (((UART1->SR & itpos) != (uint8_t)0x00) && enablestatus)
2941  06a2 c65230        	ld	a,21040
2942  06a5 1501          	bcp	a,(OFST-1,sp)
2943  06a7 270a          	jreq	L1121
2945  06a9 0d02          	tnz	(OFST+0,sp)
2946  06ab 2706          	jreq	L1121
2947                     ; 730             pendingbitstatus = SET;
2949  06ad a601          	ld	a,#1
2950  06af 6b02          	ld	(OFST+0,sp),a
2953  06b1 2002          	jra	L7711
2954  06b3               L1121:
2955                     ; 735             pendingbitstatus = RESET;
2957  06b3 0f02          	clr	(OFST+0,sp)
2959  06b5               L7711:
2960                     ; 740     return  pendingbitstatus;
2962  06b5 7b02          	ld	a,(OFST+0,sp)
2965  06b7 5b04          	addw	sp,#4
2966  06b9 81            	ret
3003                     ; 768 void UART1_ClearITPendingBit(UART1_IT_TypeDef UART1_IT)
3003                     ; 769 {
3004                     	switch	.text
3005  06ba               _UART1_ClearITPendingBit:
3007  06ba 89            	pushw	x
3008       00000000      OFST:	set	0
3011                     ; 770     assert_param(IS_UART1_CLEAR_IT_OK(UART1_IT));
3013  06bb a30255        	cpw	x,#597
3014  06be 2705          	jreq	L003
3015  06c0 a30346        	cpw	x,#838
3016  06c3 2603          	jrne	L672
3017  06c5               L003:
3018  06c5 4f            	clr	a
3019  06c6 2010          	jra	L203
3020  06c8               L672:
3021  06c8 ae0302        	ldw	x,#770
3022  06cb 89            	pushw	x
3023  06cc ae0000        	ldw	x,#0
3024  06cf 89            	pushw	x
3025  06d0 ae0008        	ldw	x,#L371
3026  06d3 cd0000        	call	_assert_failed
3028  06d6 5b04          	addw	sp,#4
3029  06d8               L203:
3030                     ; 773     if (UART1_IT == UART1_IT_RXNE)
3032  06d8 1e01          	ldw	x,(OFST+1,sp)
3033  06da a30255        	cpw	x,#597
3034  06dd 2606          	jrne	L3321
3035                     ; 775         UART1->SR = (uint8_t)~(UART1_SR_RXNE);
3037  06df 35df5230      	mov	21040,#223
3039  06e3 2004          	jra	L5321
3040  06e5               L3321:
3041                     ; 780         UART1->CR4 &= (uint8_t)~(UART1_CR4_LBDF);
3043  06e5 72195237      	bres	21047,#4
3044  06e9               L5321:
3045                     ; 782 }
3048  06e9 85            	popw	x
3049  06ea 81            	ret
3062                     	xdef	_UART1_ClearITPendingBit
3063                     	xdef	_UART1_GetITStatus
3064                     	xdef	_UART1_ClearFlag
3065                     	xdef	_UART1_GetFlagStatus
3066                     	xdef	_UART1_SetPrescaler
3067                     	xdef	_UART1_SetGuardTime
3068                     	xdef	_UART1_SetAddress
3069                     	xdef	_UART1_SendBreak
3070                     	xdef	_UART1_SendData9
3071                     	xdef	_UART1_SendData8
3072                     	xdef	_UART1_ReceiveData9
3073                     	xdef	_UART1_ReceiveData8
3074                     	xdef	_UART1_ReceiverWakeUpCmd
3075                     	xdef	_UART1_WakeUpConfig
3076                     	xdef	_UART1_SmartCardNACKCmd
3077                     	xdef	_UART1_SmartCardCmd
3078                     	xdef	_UART1_LINCmd
3079                     	xdef	_UART1_LINBreakDetectionConfig
3080                     	xdef	_UART1_IrDACmd
3081                     	xdef	_UART1_IrDAConfig
3082                     	xdef	_UART1_HalfDuplexCmd
3083                     	xdef	_UART1_ITConfig
3084                     	xdef	_UART1_Cmd
3085                     	xdef	_UART1_Init
3086                     	xdef	_UART1_DeInit
3087                     	xref	_assert_failed
3088                     	xref	_CLK_GetClockFreq
3089                     	switch	.const
3090  0008               L371:
3091  0008 73746d38735f  	dc.b	"stm8s_stdperiph_dr"
3092  001a 697665725c73  	dc.b	"iver\src\stm8s_uar"
3093  002c 74312e6300    	dc.b	"t1.c",0
3094                     	xref.b	c_lreg
3095                     	xref.b	c_x
3115                     	xref	c_lursh
3116                     	xref	c_lsub
3117                     	xref	c_smul
3118                     	xref	c_ludv
3119                     	xref	c_rtol
3120                     	xref	c_llsh
3121                     	xref	c_lcmp
3122                     	xref	c_ltor
3123                     	end
