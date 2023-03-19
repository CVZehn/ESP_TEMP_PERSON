   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.12 - 20 Jun 2018
   3                     ; Generator (Limited) V4.4.8 - 20 Jun 2018
  42                     ; 44 void SPI_DeInit(void)
  42                     ; 45 {
  44                     	switch	.text
  45  0000               _SPI_DeInit:
  49                     ; 46     SPI->CR1    = SPI_CR1_RESET_VALUE;
  51  0000 725f5200      	clr	20992
  52                     ; 47     SPI->CR2    = SPI_CR2_RESET_VALUE;
  54  0004 725f5201      	clr	20993
  55                     ; 48     SPI->ICR    = SPI_ICR_RESET_VALUE;
  57  0008 725f5202      	clr	20994
  58                     ; 49     SPI->SR     = SPI_SR_RESET_VALUE;
  60  000c 35025203      	mov	20995,#2
  61                     ; 50     SPI->CRCPR  = SPI_CRCPR_RESET_VALUE;
  63  0010 35075205      	mov	20997,#7
  64                     ; 51 }
  67  0014 81            	ret
 384                     ; 72 void SPI_Init(SPI_FirstBit_TypeDef FirstBit, SPI_BaudRatePrescaler_TypeDef BaudRatePrescaler, SPI_Mode_TypeDef Mode, SPI_ClockPolarity_TypeDef ClockPolarity, SPI_ClockPhase_TypeDef ClockPhase, SPI_DataDirection_TypeDef Data_Direction, SPI_NSS_TypeDef Slave_Management, uint8_t CRCPolynomial)
 384                     ; 73 {
 385                     	switch	.text
 386  0015               _SPI_Init:
 388  0015 89            	pushw	x
 389  0016 88            	push	a
 390       00000001      OFST:	set	1
 393                     ; 75     assert_param(IS_SPI_FIRSTBIT_OK(FirstBit));
 395  0017 9e            	ld	a,xh
 396  0018 4d            	tnz	a
 397  0019 2705          	jreq	L21
 398  001b 9e            	ld	a,xh
 399  001c a180          	cp	a,#128
 400  001e 2603          	jrne	L01
 401  0020               L21:
 402  0020 4f            	clr	a
 403  0021 2010          	jra	L41
 404  0023               L01:
 405  0023 ae004b        	ldw	x,#75
 406  0026 89            	pushw	x
 407  0027 ae0000        	ldw	x,#0
 408  002a 89            	pushw	x
 409  002b ae0000        	ldw	x,#L302
 410  002e cd0000        	call	_assert_failed
 412  0031 5b04          	addw	sp,#4
 413  0033               L41:
 414                     ; 76     assert_param(IS_SPI_BAUDRATE_PRESCALER_OK(BaudRatePrescaler));
 416  0033 0d03          	tnz	(OFST+2,sp)
 417  0035 272a          	jreq	L02
 418  0037 7b03          	ld	a,(OFST+2,sp)
 419  0039 a108          	cp	a,#8
 420  003b 2724          	jreq	L02
 421  003d 7b03          	ld	a,(OFST+2,sp)
 422  003f a110          	cp	a,#16
 423  0041 271e          	jreq	L02
 424  0043 7b03          	ld	a,(OFST+2,sp)
 425  0045 a118          	cp	a,#24
 426  0047 2718          	jreq	L02
 427  0049 7b03          	ld	a,(OFST+2,sp)
 428  004b a120          	cp	a,#32
 429  004d 2712          	jreq	L02
 430  004f 7b03          	ld	a,(OFST+2,sp)
 431  0051 a128          	cp	a,#40
 432  0053 270c          	jreq	L02
 433  0055 7b03          	ld	a,(OFST+2,sp)
 434  0057 a130          	cp	a,#48
 435  0059 2706          	jreq	L02
 436  005b 7b03          	ld	a,(OFST+2,sp)
 437  005d a138          	cp	a,#56
 438  005f 2603          	jrne	L61
 439  0061               L02:
 440  0061 4f            	clr	a
 441  0062 2010          	jra	L22
 442  0064               L61:
 443  0064 ae004c        	ldw	x,#76
 444  0067 89            	pushw	x
 445  0068 ae0000        	ldw	x,#0
 446  006b 89            	pushw	x
 447  006c ae0000        	ldw	x,#L302
 448  006f cd0000        	call	_assert_failed
 450  0072 5b04          	addw	sp,#4
 451  0074               L22:
 452                     ; 77     assert_param(IS_SPI_MODE_OK(Mode));
 454  0074 7b06          	ld	a,(OFST+5,sp)
 455  0076 a104          	cp	a,#4
 456  0078 2704          	jreq	L62
 457  007a 0d06          	tnz	(OFST+5,sp)
 458  007c 2603          	jrne	L42
 459  007e               L62:
 460  007e 4f            	clr	a
 461  007f 2010          	jra	L03
 462  0081               L42:
 463  0081 ae004d        	ldw	x,#77
 464  0084 89            	pushw	x
 465  0085 ae0000        	ldw	x,#0
 466  0088 89            	pushw	x
 467  0089 ae0000        	ldw	x,#L302
 468  008c cd0000        	call	_assert_failed
 470  008f 5b04          	addw	sp,#4
 471  0091               L03:
 472                     ; 78     assert_param(IS_SPI_POLARITY_OK(ClockPolarity));
 474  0091 0d07          	tnz	(OFST+6,sp)
 475  0093 2706          	jreq	L43
 476  0095 7b07          	ld	a,(OFST+6,sp)
 477  0097 a102          	cp	a,#2
 478  0099 2603          	jrne	L23
 479  009b               L43:
 480  009b 4f            	clr	a
 481  009c 2010          	jra	L63
 482  009e               L23:
 483  009e ae004e        	ldw	x,#78
 484  00a1 89            	pushw	x
 485  00a2 ae0000        	ldw	x,#0
 486  00a5 89            	pushw	x
 487  00a6 ae0000        	ldw	x,#L302
 488  00a9 cd0000        	call	_assert_failed
 490  00ac 5b04          	addw	sp,#4
 491  00ae               L63:
 492                     ; 79     assert_param(IS_SPI_PHASE_OK(ClockPhase));
 494  00ae 0d08          	tnz	(OFST+7,sp)
 495  00b0 2706          	jreq	L24
 496  00b2 7b08          	ld	a,(OFST+7,sp)
 497  00b4 a101          	cp	a,#1
 498  00b6 2603          	jrne	L04
 499  00b8               L24:
 500  00b8 4f            	clr	a
 501  00b9 2010          	jra	L44
 502  00bb               L04:
 503  00bb ae004f        	ldw	x,#79
 504  00be 89            	pushw	x
 505  00bf ae0000        	ldw	x,#0
 506  00c2 89            	pushw	x
 507  00c3 ae0000        	ldw	x,#L302
 508  00c6 cd0000        	call	_assert_failed
 510  00c9 5b04          	addw	sp,#4
 511  00cb               L44:
 512                     ; 80     assert_param(IS_SPI_DATA_DIRECTION_OK(Data_Direction));
 514  00cb 0d09          	tnz	(OFST+8,sp)
 515  00cd 2712          	jreq	L05
 516  00cf 7b09          	ld	a,(OFST+8,sp)
 517  00d1 a104          	cp	a,#4
 518  00d3 270c          	jreq	L05
 519  00d5 7b09          	ld	a,(OFST+8,sp)
 520  00d7 a180          	cp	a,#128
 521  00d9 2706          	jreq	L05
 522  00db 7b09          	ld	a,(OFST+8,sp)
 523  00dd a1c0          	cp	a,#192
 524  00df 2603          	jrne	L64
 525  00e1               L05:
 526  00e1 4f            	clr	a
 527  00e2 2010          	jra	L25
 528  00e4               L64:
 529  00e4 ae0050        	ldw	x,#80
 530  00e7 89            	pushw	x
 531  00e8 ae0000        	ldw	x,#0
 532  00eb 89            	pushw	x
 533  00ec ae0000        	ldw	x,#L302
 534  00ef cd0000        	call	_assert_failed
 536  00f2 5b04          	addw	sp,#4
 537  00f4               L25:
 538                     ; 81     assert_param(IS_SPI_SLAVEMANAGEMENT_OK(Slave_Management));
 540  00f4 7b0a          	ld	a,(OFST+9,sp)
 541  00f6 a102          	cp	a,#2
 542  00f8 2704          	jreq	L65
 543  00fa 0d0a          	tnz	(OFST+9,sp)
 544  00fc 2603          	jrne	L45
 545  00fe               L65:
 546  00fe 4f            	clr	a
 547  00ff 2010          	jra	L06
 548  0101               L45:
 549  0101 ae0051        	ldw	x,#81
 550  0104 89            	pushw	x
 551  0105 ae0000        	ldw	x,#0
 552  0108 89            	pushw	x
 553  0109 ae0000        	ldw	x,#L302
 554  010c cd0000        	call	_assert_failed
 556  010f 5b04          	addw	sp,#4
 557  0111               L06:
 558                     ; 82     assert_param(IS_SPI_CRC_POLYNOMIAL_OK(CRCPolynomial));
 560  0111 0d0b          	tnz	(OFST+10,sp)
 561  0113 2703          	jreq	L26
 562  0115 4f            	clr	a
 563  0116 2010          	jra	L46
 564  0118               L26:
 565  0118 ae0052        	ldw	x,#82
 566  011b 89            	pushw	x
 567  011c ae0000        	ldw	x,#0
 568  011f 89            	pushw	x
 569  0120 ae0000        	ldw	x,#L302
 570  0123 cd0000        	call	_assert_failed
 572  0126 5b04          	addw	sp,#4
 573  0128               L46:
 574                     ; 85     SPI->CR1 = (uint8_t)((uint8_t)((uint8_t)FirstBit | BaudRatePrescaler) |
 574                     ; 86                     (uint8_t)((uint8_t)ClockPolarity | ClockPhase));
 576  0128 7b07          	ld	a,(OFST+6,sp)
 577  012a 1a08          	or	a,(OFST+7,sp)
 578  012c 6b01          	ld	(OFST+0,sp),a
 580  012e 7b02          	ld	a,(OFST+1,sp)
 581  0130 1a03          	or	a,(OFST+2,sp)
 582  0132 1a01          	or	a,(OFST+0,sp)
 583  0134 c75200        	ld	20992,a
 584                     ; 89     SPI->CR2 = (uint8_t)((uint8_t)(Data_Direction) | (uint8_t)(Slave_Management));
 586  0137 7b09          	ld	a,(OFST+8,sp)
 587  0139 1a0a          	or	a,(OFST+9,sp)
 588  013b c75201        	ld	20993,a
 589                     ; 91     if (Mode == SPI_MODE_MASTER)
 591  013e 7b06          	ld	a,(OFST+5,sp)
 592  0140 a104          	cp	a,#4
 593  0142 2606          	jrne	L502
 594                     ; 93         SPI->CR2 |= (uint8_t)SPI_CR2_SSI;
 596  0144 72105201      	bset	20993,#0
 598  0148 2004          	jra	L702
 599  014a               L502:
 600                     ; 97         SPI->CR2 &= (uint8_t)~(SPI_CR2_SSI);
 602  014a 72115201      	bres	20993,#0
 603  014e               L702:
 604                     ; 101     SPI->CR1 |= (uint8_t)(Mode);
 606  014e c65200        	ld	a,20992
 607  0151 1a06          	or	a,(OFST+5,sp)
 608  0153 c75200        	ld	20992,a
 609                     ; 104     SPI->CRCPR = (uint8_t)CRCPolynomial;
 611  0156 7b0b          	ld	a,(OFST+10,sp)
 612  0158 c75205        	ld	20997,a
 613                     ; 105 }
 616  015b 5b03          	addw	sp,#3
 617  015d 81            	ret
 673                     ; 113 void SPI_Cmd(FunctionalState NewState)
 673                     ; 114 {
 674                     	switch	.text
 675  015e               _SPI_Cmd:
 677  015e 88            	push	a
 678       00000000      OFST:	set	0
 681                     ; 116     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 683  015f 4d            	tnz	a
 684  0160 2704          	jreq	L27
 685  0162 a101          	cp	a,#1
 686  0164 2603          	jrne	L07
 687  0166               L27:
 688  0166 4f            	clr	a
 689  0167 2010          	jra	L47
 690  0169               L07:
 691  0169 ae0074        	ldw	x,#116
 692  016c 89            	pushw	x
 693  016d ae0000        	ldw	x,#0
 694  0170 89            	pushw	x
 695  0171 ae0000        	ldw	x,#L302
 696  0174 cd0000        	call	_assert_failed
 698  0177 5b04          	addw	sp,#4
 699  0179               L47:
 700                     ; 118     if (NewState != DISABLE)
 702  0179 0d01          	tnz	(OFST+1,sp)
 703  017b 2706          	jreq	L732
 704                     ; 120         SPI->CR1 |= SPI_CR1_SPE; /* Enable the SPI peripheral*/
 706  017d 721c5200      	bset	20992,#6
 708  0181 2004          	jra	L142
 709  0183               L732:
 710                     ; 124         SPI->CR1 &= (uint8_t)(~SPI_CR1_SPE); /* Disable the SPI peripheral*/
 712  0183 721d5200      	bres	20992,#6
 713  0187               L142:
 714                     ; 126 }
 717  0187 84            	pop	a
 718  0188 81            	ret
 828                     ; 135 void SPI_ITConfig(SPI_IT_TypeDef SPI_IT, FunctionalState NewState)
 828                     ; 136 {
 829                     	switch	.text
 830  0189               _SPI_ITConfig:
 832  0189 89            	pushw	x
 833  018a 88            	push	a
 834       00000001      OFST:	set	1
 837                     ; 137     uint8_t itpos = 0;
 839                     ; 139     assert_param(IS_SPI_CONFIG_IT_OK(SPI_IT));
 841  018b 9e            	ld	a,xh
 842  018c a117          	cp	a,#23
 843  018e 270f          	jreq	L201
 844  0190 9e            	ld	a,xh
 845  0191 a106          	cp	a,#6
 846  0193 270a          	jreq	L201
 847  0195 9e            	ld	a,xh
 848  0196 a105          	cp	a,#5
 849  0198 2705          	jreq	L201
 850  019a 9e            	ld	a,xh
 851  019b a134          	cp	a,#52
 852  019d 2603          	jrne	L001
 853  019f               L201:
 854  019f 4f            	clr	a
 855  01a0 2010          	jra	L401
 856  01a2               L001:
 857  01a2 ae008b        	ldw	x,#139
 858  01a5 89            	pushw	x
 859  01a6 ae0000        	ldw	x,#0
 860  01a9 89            	pushw	x
 861  01aa ae0000        	ldw	x,#L302
 862  01ad cd0000        	call	_assert_failed
 864  01b0 5b04          	addw	sp,#4
 865  01b2               L401:
 866                     ; 140     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 868  01b2 0d03          	tnz	(OFST+2,sp)
 869  01b4 2706          	jreq	L011
 870  01b6 7b03          	ld	a,(OFST+2,sp)
 871  01b8 a101          	cp	a,#1
 872  01ba 2603          	jrne	L601
 873  01bc               L011:
 874  01bc 4f            	clr	a
 875  01bd 2010          	jra	L211
 876  01bf               L601:
 877  01bf ae008c        	ldw	x,#140
 878  01c2 89            	pushw	x
 879  01c3 ae0000        	ldw	x,#0
 880  01c6 89            	pushw	x
 881  01c7 ae0000        	ldw	x,#L302
 882  01ca cd0000        	call	_assert_failed
 884  01cd 5b04          	addw	sp,#4
 885  01cf               L211:
 886                     ; 143     itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)SPI_IT & (uint8_t)0x0F));
 888  01cf 7b02          	ld	a,(OFST+1,sp)
 889  01d1 a40f          	and	a,#15
 890  01d3 5f            	clrw	x
 891  01d4 97            	ld	xl,a
 892  01d5 a601          	ld	a,#1
 893  01d7 5d            	tnzw	x
 894  01d8 2704          	jreq	L411
 895  01da               L611:
 896  01da 48            	sll	a
 897  01db 5a            	decw	x
 898  01dc 26fc          	jrne	L611
 899  01de               L411:
 900  01de 6b01          	ld	(OFST+0,sp),a
 902                     ; 145     if (NewState != DISABLE)
 904  01e0 0d03          	tnz	(OFST+2,sp)
 905  01e2 270a          	jreq	L313
 906                     ; 147         SPI->ICR |= itpos; /* Enable interrupt*/
 908  01e4 c65202        	ld	a,20994
 909  01e7 1a01          	or	a,(OFST+0,sp)
 910  01e9 c75202        	ld	20994,a
 912  01ec 2009          	jra	L513
 913  01ee               L313:
 914                     ; 151         SPI->ICR &= (uint8_t)(~itpos); /* Disable interrupt*/
 916  01ee 7b01          	ld	a,(OFST+0,sp)
 917  01f0 43            	cpl	a
 918  01f1 c45202        	and	a,20994
 919  01f4 c75202        	ld	20994,a
 920  01f7               L513:
 921                     ; 153 }
 924  01f7 5b03          	addw	sp,#3
 925  01f9 81            	ret
 959                     ; 159 void SPI_SendData(uint8_t Data)
 959                     ; 160 {
 960                     	switch	.text
 961  01fa               _SPI_SendData:
 965                     ; 161     SPI->DR = Data; /* Write in the DR register the data to be sent*/
 967  01fa c75204        	ld	20996,a
 968                     ; 162 }
 971  01fd 81            	ret
 994                     ; 169 uint8_t SPI_ReceiveData(void)
 994                     ; 170 {
 995                     	switch	.text
 996  01fe               _SPI_ReceiveData:
1000                     ; 171     return ((uint8_t)SPI->DR); /* Return the data in the DR register*/
1002  01fe c65204        	ld	a,20996
1005  0201 81            	ret
1042                     ; 180 void SPI_NSSInternalSoftwareCmd(FunctionalState NewState)
1042                     ; 181 {
1043                     	switch	.text
1044  0202               _SPI_NSSInternalSoftwareCmd:
1046  0202 88            	push	a
1047       00000000      OFST:	set	0
1050                     ; 183     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1052  0203 4d            	tnz	a
1053  0204 2704          	jreq	L031
1054  0206 a101          	cp	a,#1
1055  0208 2603          	jrne	L621
1056  020a               L031:
1057  020a 4f            	clr	a
1058  020b 2010          	jra	L231
1059  020d               L621:
1060  020d ae00b7        	ldw	x,#183
1061  0210 89            	pushw	x
1062  0211 ae0000        	ldw	x,#0
1063  0214 89            	pushw	x
1064  0215 ae0000        	ldw	x,#L302
1065  0218 cd0000        	call	_assert_failed
1067  021b 5b04          	addw	sp,#4
1068  021d               L231:
1069                     ; 185     if (NewState != DISABLE)
1071  021d 0d01          	tnz	(OFST+1,sp)
1072  021f 2706          	jreq	L363
1073                     ; 187         SPI->CR2 |= SPI_CR2_SSI; /* Set NSS pin internally by software*/
1075  0221 72105201      	bset	20993,#0
1077  0225 2004          	jra	L563
1078  0227               L363:
1079                     ; 191         SPI->CR2 &= (uint8_t)(~SPI_CR2_SSI); /* Reset NSS pin internally by software*/
1081  0227 72115201      	bres	20993,#0
1082  022b               L563:
1083                     ; 193 }
1086  022b 84            	pop	a
1087  022c 81            	ret
1110                     ; 200 void SPI_TransmitCRC(void)
1110                     ; 201 {
1111                     	switch	.text
1112  022d               _SPI_TransmitCRC:
1116                     ; 202     SPI->CR2 |= SPI_CR2_CRCNEXT; /* Enable the CRC transmission*/
1118  022d 72185201      	bset	20993,#4
1119                     ; 203 }
1122  0231 81            	ret
1159                     ; 211 void SPI_CalculateCRCCmd(FunctionalState NewState)
1159                     ; 212 {
1160                     	switch	.text
1161  0232               _SPI_CalculateCRCCmd:
1163  0232 88            	push	a
1164       00000000      OFST:	set	0
1167                     ; 214     assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1169  0233 4d            	tnz	a
1170  0234 2704          	jreq	L241
1171  0236 a101          	cp	a,#1
1172  0238 2603          	jrne	L041
1173  023a               L241:
1174  023a 4f            	clr	a
1175  023b 2010          	jra	L441
1176  023d               L041:
1177  023d ae00d6        	ldw	x,#214
1178  0240 89            	pushw	x
1179  0241 ae0000        	ldw	x,#0
1180  0244 89            	pushw	x
1181  0245 ae0000        	ldw	x,#L302
1182  0248 cd0000        	call	_assert_failed
1184  024b 5b04          	addw	sp,#4
1185  024d               L441:
1186                     ; 216     if (NewState != DISABLE)
1188  024d 0d01          	tnz	(OFST+1,sp)
1189  024f 2706          	jreq	L514
1190                     ; 218         SPI->CR2 |= SPI_CR2_CRCEN; /* Enable the CRC calculation*/
1192  0251 721a5201      	bset	20993,#5
1194  0255 2004          	jra	L714
1195  0257               L514:
1196                     ; 222         SPI->CR2 &= (uint8_t)(~SPI_CR2_CRCEN); /* Disable the CRC calculation*/
1198  0257 721b5201      	bres	20993,#5
1199  025b               L714:
1200                     ; 224 }
1203  025b 84            	pop	a
1204  025c 81            	ret
1269                     ; 231 uint8_t SPI_GetCRC(SPI_CRC_TypeDef SPI_CRC)
1269                     ; 232 {
1270                     	switch	.text
1271  025d               _SPI_GetCRC:
1273  025d 88            	push	a
1274  025e 88            	push	a
1275       00000001      OFST:	set	1
1278                     ; 233     uint8_t crcreg = 0;
1280                     ; 236     assert_param(IS_SPI_CRC_OK(SPI_CRC));
1282  025f a101          	cp	a,#1
1283  0261 2703          	jreq	L251
1284  0263 4d            	tnz	a
1285  0264 2603          	jrne	L051
1286  0266               L251:
1287  0266 4f            	clr	a
1288  0267 2010          	jra	L451
1289  0269               L051:
1290  0269 ae00ec        	ldw	x,#236
1291  026c 89            	pushw	x
1292  026d ae0000        	ldw	x,#0
1293  0270 89            	pushw	x
1294  0271 ae0000        	ldw	x,#L302
1295  0274 cd0000        	call	_assert_failed
1297  0277 5b04          	addw	sp,#4
1298  0279               L451:
1299                     ; 238     if (SPI_CRC != SPI_CRC_RX)
1301  0279 0d02          	tnz	(OFST+1,sp)
1302  027b 2707          	jreq	L354
1303                     ; 240         crcreg = SPI->TXCRCR;  /* Get the Tx CRC register*/
1305  027d c65207        	ld	a,20999
1306  0280 6b01          	ld	(OFST+0,sp),a
1309  0282 2005          	jra	L554
1310  0284               L354:
1311                     ; 244         crcreg = SPI->RXCRCR; /* Get the Rx CRC register*/
1313  0284 c65206        	ld	a,20998
1314  0287 6b01          	ld	(OFST+0,sp),a
1316  0289               L554:
1317                     ; 248     return crcreg;
1319  0289 7b01          	ld	a,(OFST+0,sp)
1322  028b 85            	popw	x
1323  028c 81            	ret
1348                     ; 256 void SPI_ResetCRC(void)
1348                     ; 257 {
1349                     	switch	.text
1350  028d               _SPI_ResetCRC:
1354                     ; 260     SPI_CalculateCRCCmd(ENABLE);
1356  028d a601          	ld	a,#1
1357  028f ada1          	call	_SPI_CalculateCRCCmd
1359                     ; 263     SPI_Cmd(ENABLE);
1361  0291 a601          	ld	a,#1
1362  0293 cd015e        	call	_SPI_Cmd
1364                     ; 264 }
1367  0296 81            	ret
1391                     ; 271 uint8_t SPI_GetCRCPolynomial(void)
1391                     ; 272 {
1392                     	switch	.text
1393  0297               _SPI_GetCRCPolynomial:
1397                     ; 273     return SPI->CRCPR; /* Return the CRC polynomial register */
1399  0297 c65205        	ld	a,20997
1402  029a 81            	ret
1459                     ; 281 void SPI_BiDirectionalLineConfig(SPI_Direction_TypeDef SPI_Direction)
1459                     ; 282 {
1460                     	switch	.text
1461  029b               _SPI_BiDirectionalLineConfig:
1463  029b 88            	push	a
1464       00000000      OFST:	set	0
1467                     ; 284     assert_param(IS_SPI_DIRECTION_OK(SPI_Direction));
1469  029c 4d            	tnz	a
1470  029d 2704          	jreq	L661
1471  029f a101          	cp	a,#1
1472  02a1 2603          	jrne	L461
1473  02a3               L661:
1474  02a3 4f            	clr	a
1475  02a4 2010          	jra	L071
1476  02a6               L461:
1477  02a6 ae011c        	ldw	x,#284
1478  02a9 89            	pushw	x
1479  02aa ae0000        	ldw	x,#0
1480  02ad 89            	pushw	x
1481  02ae ae0000        	ldw	x,#L302
1482  02b1 cd0000        	call	_assert_failed
1484  02b4 5b04          	addw	sp,#4
1485  02b6               L071:
1486                     ; 286     if (SPI_Direction != SPI_DIRECTION_RX)
1488  02b6 0d01          	tnz	(OFST+1,sp)
1489  02b8 2706          	jreq	L525
1490                     ; 288         SPI->CR2 |= SPI_CR2_BDOE; /* Set the Tx only mode*/
1492  02ba 721c5201      	bset	20993,#6
1494  02be 2004          	jra	L725
1495  02c0               L525:
1496                     ; 292         SPI->CR2 &= (uint8_t)(~SPI_CR2_BDOE); /* Set the Rx only mode*/
1498  02c0 721d5201      	bres	20993,#6
1499  02c4               L725:
1500                     ; 294 }
1503  02c4 84            	pop	a
1504  02c5 81            	ret
1626                     ; 304 FlagStatus SPI_GetFlagStatus(SPI_Flag_TypeDef SPI_FLAG)
1626                     ; 305 {
1627                     	switch	.text
1628  02c6               _SPI_GetFlagStatus:
1630  02c6 88            	push	a
1631  02c7 88            	push	a
1632       00000001      OFST:	set	1
1635                     ; 306     FlagStatus status = RESET;
1637                     ; 308     assert_param(IS_SPI_FLAGS_OK(SPI_FLAG));
1639  02c8 a140          	cp	a,#64
1640  02ca 2718          	jreq	L671
1641  02cc a120          	cp	a,#32
1642  02ce 2714          	jreq	L671
1643  02d0 a110          	cp	a,#16
1644  02d2 2710          	jreq	L671
1645  02d4 a108          	cp	a,#8
1646  02d6 270c          	jreq	L671
1647  02d8 a102          	cp	a,#2
1648  02da 2708          	jreq	L671
1649  02dc a101          	cp	a,#1
1650  02de 2704          	jreq	L671
1651  02e0 a180          	cp	a,#128
1652  02e2 2603          	jrne	L471
1653  02e4               L671:
1654  02e4 4f            	clr	a
1655  02e5 2010          	jra	L002
1656  02e7               L471:
1657  02e7 ae0134        	ldw	x,#308
1658  02ea 89            	pushw	x
1659  02eb ae0000        	ldw	x,#0
1660  02ee 89            	pushw	x
1661  02ef ae0000        	ldw	x,#L302
1662  02f2 cd0000        	call	_assert_failed
1664  02f5 5b04          	addw	sp,#4
1665  02f7               L002:
1666                     ; 311     if ((SPI->SR & (uint8_t)SPI_FLAG) != (uint8_t)RESET)
1668  02f7 c65203        	ld	a,20995
1669  02fa 1502          	bcp	a,(OFST+1,sp)
1670  02fc 2706          	jreq	L506
1671                     ; 313         status = SET; /* SPI_FLAG is set */
1673  02fe a601          	ld	a,#1
1674  0300 6b01          	ld	(OFST+0,sp),a
1677  0302 2002          	jra	L706
1678  0304               L506:
1679                     ; 317         status = RESET; /* SPI_FLAG is reset*/
1681  0304 0f01          	clr	(OFST+0,sp)
1683  0306               L706:
1684                     ; 321     return status;
1686  0306 7b01          	ld	a,(OFST+0,sp)
1689  0308 85            	popw	x
1690  0309 81            	ret
1726                     ; 339 void SPI_ClearFlag(SPI_Flag_TypeDef SPI_FLAG)
1726                     ; 340 {
1727                     	switch	.text
1728  030a               _SPI_ClearFlag:
1730  030a 88            	push	a
1731       00000000      OFST:	set	0
1734                     ; 341     assert_param(IS_SPI_CLEAR_FLAGS_OK(SPI_FLAG));
1736  030b a110          	cp	a,#16
1737  030d 2704          	jreq	L602
1738  030f a108          	cp	a,#8
1739  0311 2603          	jrne	L402
1740  0313               L602:
1741  0313 4f            	clr	a
1742  0314 2010          	jra	L012
1743  0316               L402:
1744  0316 ae0155        	ldw	x,#341
1745  0319 89            	pushw	x
1746  031a ae0000        	ldw	x,#0
1747  031d 89            	pushw	x
1748  031e ae0000        	ldw	x,#L302
1749  0321 cd0000        	call	_assert_failed
1751  0324 5b04          	addw	sp,#4
1752  0326               L012:
1753                     ; 343     SPI->SR = (uint8_t)(~SPI_FLAG);
1755  0326 7b01          	ld	a,(OFST+1,sp)
1756  0328 43            	cpl	a
1757  0329 c75203        	ld	20995,a
1758                     ; 344 }
1761  032c 84            	pop	a
1762  032d 81            	ret
1845                     ; 359 ITStatus SPI_GetITStatus(SPI_IT_TypeDef SPI_IT)
1845                     ; 360 {
1846                     	switch	.text
1847  032e               _SPI_GetITStatus:
1849  032e 88            	push	a
1850  032f 89            	pushw	x
1851       00000002      OFST:	set	2
1854                     ; 361     ITStatus pendingbitstatus = RESET;
1856                     ; 362     uint8_t itpos = 0;
1858                     ; 363     uint8_t itmask1 = 0;
1860                     ; 364     uint8_t itmask2 = 0;
1862                     ; 365     uint8_t enablestatus = 0;
1864                     ; 366     assert_param(IS_SPI_GET_IT_OK(SPI_IT));
1866  0330 a165          	cp	a,#101
1867  0332 2714          	jreq	L612
1868  0334 a155          	cp	a,#85
1869  0336 2710          	jreq	L612
1870  0338 a145          	cp	a,#69
1871  033a 270c          	jreq	L612
1872  033c a134          	cp	a,#52
1873  033e 2708          	jreq	L612
1874  0340 a117          	cp	a,#23
1875  0342 2704          	jreq	L612
1876  0344 a106          	cp	a,#6
1877  0346 2603          	jrne	L412
1878  0348               L612:
1879  0348 4f            	clr	a
1880  0349 2010          	jra	L022
1881  034b               L412:
1882  034b ae016e        	ldw	x,#366
1883  034e 89            	pushw	x
1884  034f ae0000        	ldw	x,#0
1885  0352 89            	pushw	x
1886  0353 ae0000        	ldw	x,#L302
1887  0356 cd0000        	call	_assert_failed
1889  0359 5b04          	addw	sp,#4
1890  035b               L022:
1891                     ; 368     itpos = (uint8_t)((uint8_t)1 << ((uint8_t)SPI_IT & (uint8_t)0x0F));
1893  035b 7b03          	ld	a,(OFST+1,sp)
1894  035d a40f          	and	a,#15
1895  035f 5f            	clrw	x
1896  0360 97            	ld	xl,a
1897  0361 a601          	ld	a,#1
1898  0363 5d            	tnzw	x
1899  0364 2704          	jreq	L222
1900  0366               L422:
1901  0366 48            	sll	a
1902  0367 5a            	decw	x
1903  0368 26fc          	jrne	L422
1904  036a               L222:
1905  036a 6b01          	ld	(OFST-1,sp),a
1907                     ; 371     itmask1 = (uint8_t)((uint8_t)SPI_IT >> (uint8_t)4);
1909  036c 7b03          	ld	a,(OFST+1,sp)
1910  036e 4e            	swap	a
1911  036f a40f          	and	a,#15
1912  0371 6b02          	ld	(OFST+0,sp),a
1914                     ; 373     itmask2 = (uint8_t)((uint8_t)1 << itmask1);
1916  0373 7b02          	ld	a,(OFST+0,sp)
1917  0375 5f            	clrw	x
1918  0376 97            	ld	xl,a
1919  0377 a601          	ld	a,#1
1920  0379 5d            	tnzw	x
1921  037a 2704          	jreq	L622
1922  037c               L032:
1923  037c 48            	sll	a
1924  037d 5a            	decw	x
1925  037e 26fc          	jrne	L032
1926  0380               L622:
1927  0380 6b02          	ld	(OFST+0,sp),a
1929                     ; 375     enablestatus = (uint8_t)((uint8_t)SPI->SR & itmask2);
1931  0382 c65203        	ld	a,20995
1932  0385 1402          	and	a,(OFST+0,sp)
1933  0387 6b02          	ld	(OFST+0,sp),a
1935                     ; 377     if (((SPI->ICR & itpos) != RESET) && enablestatus)
1937  0389 c65202        	ld	a,20994
1938  038c 1501          	bcp	a,(OFST-1,sp)
1939  038e 270a          	jreq	L176
1941  0390 0d02          	tnz	(OFST+0,sp)
1942  0392 2706          	jreq	L176
1943                     ; 380         pendingbitstatus = SET;
1945  0394 a601          	ld	a,#1
1946  0396 6b02          	ld	(OFST+0,sp),a
1949  0398 2002          	jra	L376
1950  039a               L176:
1951                     ; 385         pendingbitstatus = RESET;
1953  039a 0f02          	clr	(OFST+0,sp)
1955  039c               L376:
1956                     ; 388     return  pendingbitstatus;
1958  039c 7b02          	ld	a,(OFST+0,sp)
1961  039e 5b03          	addw	sp,#3
1962  03a0 81            	ret
2008                     ; 404 void SPI_ClearITPendingBit(SPI_IT_TypeDef SPI_IT)
2008                     ; 405 {
2009                     	switch	.text
2010  03a1               _SPI_ClearITPendingBit:
2012  03a1 88            	push	a
2013  03a2 88            	push	a
2014       00000001      OFST:	set	1
2017                     ; 406     uint8_t itpos = 0;
2019                     ; 407     assert_param(IS_SPI_CLEAR_IT_OK(SPI_IT));
2021  03a3 a145          	cp	a,#69
2022  03a5 2704          	jreq	L632
2023  03a7 a134          	cp	a,#52
2024  03a9 2603          	jrne	L432
2025  03ab               L632:
2026  03ab 4f            	clr	a
2027  03ac 2010          	jra	L042
2028  03ae               L432:
2029  03ae ae0197        	ldw	x,#407
2030  03b1 89            	pushw	x
2031  03b2 ae0000        	ldw	x,#0
2032  03b5 89            	pushw	x
2033  03b6 ae0000        	ldw	x,#L302
2034  03b9 cd0000        	call	_assert_failed
2036  03bc 5b04          	addw	sp,#4
2037  03be               L042:
2038                     ; 412     itpos = (uint8_t)((uint8_t)1 << (uint8_t)((uint8_t)(SPI_IT & (uint8_t)0xF0) >> 4));
2040  03be 7b02          	ld	a,(OFST+1,sp)
2041  03c0 a4f0          	and	a,#240
2042  03c2 4e            	swap	a
2043  03c3 a40f          	and	a,#15
2044  03c5 5f            	clrw	x
2045  03c6 97            	ld	xl,a
2046  03c7 a601          	ld	a,#1
2047  03c9 5d            	tnzw	x
2048  03ca 2704          	jreq	L242
2049  03cc               L442:
2050  03cc 48            	sll	a
2051  03cd 5a            	decw	x
2052  03ce 26fc          	jrne	L442
2053  03d0               L242:
2054  03d0 6b01          	ld	(OFST+0,sp),a
2056                     ; 414     SPI->SR = (uint8_t)(~itpos);
2058  03d2 7b01          	ld	a,(OFST+0,sp)
2059  03d4 43            	cpl	a
2060  03d5 c75203        	ld	20995,a
2061                     ; 416 }
2064  03d8 85            	popw	x
2065  03d9 81            	ret
2078                     	xdef	_SPI_ClearITPendingBit
2079                     	xdef	_SPI_GetITStatus
2080                     	xdef	_SPI_ClearFlag
2081                     	xdef	_SPI_GetFlagStatus
2082                     	xdef	_SPI_BiDirectionalLineConfig
2083                     	xdef	_SPI_GetCRCPolynomial
2084                     	xdef	_SPI_ResetCRC
2085                     	xdef	_SPI_GetCRC
2086                     	xdef	_SPI_CalculateCRCCmd
2087                     	xdef	_SPI_TransmitCRC
2088                     	xdef	_SPI_NSSInternalSoftwareCmd
2089                     	xdef	_SPI_ReceiveData
2090                     	xdef	_SPI_SendData
2091                     	xdef	_SPI_ITConfig
2092                     	xdef	_SPI_Cmd
2093                     	xdef	_SPI_Init
2094                     	xdef	_SPI_DeInit
2095                     	xref	_assert_failed
2096                     .const:	section	.text
2097  0000               L302:
2098  0000 73746d38735f  	dc.b	"stm8s_stdperiph_dr"
2099  0012 697665725c73  	dc.b	"iver\src\stm8s_spi"
2100  0024 2e6300        	dc.b	".c",0
2120                     	end
