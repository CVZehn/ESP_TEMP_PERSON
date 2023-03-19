   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.12 - 20 Jun 2018
   3                     ; Generator (Limited) V4.4.8 - 20 Jun 2018
  75                     ; 81 void FLASH_Unlock(FLASH_MemType_TypeDef FLASH_MemType)
  75                     ; 82 {
  77                     	switch	.text
  78  0000               _FLASH_Unlock:
  80  0000 88            	push	a
  81       00000000      OFST:	set	0
  84                     ; 84     assert_param(IS_MEMORY_TYPE_OK(FLASH_MemType));
  86  0001 a1fd          	cp	a,#253
  87  0003 2704          	jreq	L01
  88  0005 a1f7          	cp	a,#247
  89  0007 2603          	jrne	L6
  90  0009               L01:
  91  0009 4f            	clr	a
  92  000a 2010          	jra	L21
  93  000c               L6:
  94  000c ae0054        	ldw	x,#84
  95  000f 89            	pushw	x
  96  0010 ae0000        	ldw	x,#0
  97  0013 89            	pushw	x
  98  0014 ae0010        	ldw	x,#L73
  99  0017 cd0000        	call	_assert_failed
 101  001a 5b04          	addw	sp,#4
 102  001c               L21:
 103                     ; 87     if (FLASH_MemType == FLASH_MEMTYPE_PROG)
 105  001c 7b01          	ld	a,(OFST+1,sp)
 106  001e a1fd          	cp	a,#253
 107  0020 260a          	jrne	L14
 108                     ; 89         FLASH->PUKR = FLASH_RASS_KEY1;
 110  0022 35565062      	mov	20578,#86
 111                     ; 90         FLASH->PUKR = FLASH_RASS_KEY2;
 113  0026 35ae5062      	mov	20578,#174
 115  002a 2008          	jra	L34
 116  002c               L14:
 117                     ; 95         FLASH->DUKR = FLASH_RASS_KEY2; /* Warning: keys are reversed on data memory !!! */
 119  002c 35ae5064      	mov	20580,#174
 120                     ; 96         FLASH->DUKR = FLASH_RASS_KEY1;
 122  0030 35565064      	mov	20580,#86
 123  0034               L34:
 124                     ; 98 }
 127  0034 84            	pop	a
 128  0035 81            	ret
 164                     ; 106 void FLASH_Lock(FLASH_MemType_TypeDef FLASH_MemType)
 164                     ; 107 {
 165                     	switch	.text
 166  0036               _FLASH_Lock:
 168  0036 88            	push	a
 169       00000000      OFST:	set	0
 172                     ; 109     assert_param(IS_MEMORY_TYPE_OK(FLASH_MemType));
 174  0037 a1fd          	cp	a,#253
 175  0039 2704          	jreq	L02
 176  003b a1f7          	cp	a,#247
 177  003d 2603          	jrne	L61
 178  003f               L02:
 179  003f 4f            	clr	a
 180  0040 2010          	jra	L22
 181  0042               L61:
 182  0042 ae006d        	ldw	x,#109
 183  0045 89            	pushw	x
 184  0046 ae0000        	ldw	x,#0
 185  0049 89            	pushw	x
 186  004a ae0010        	ldw	x,#L73
 187  004d cd0000        	call	_assert_failed
 189  0050 5b04          	addw	sp,#4
 190  0052               L22:
 191                     ; 112   FLASH->IAPSR &= (uint8_t)FLASH_MemType;
 193  0052 c6505f        	ld	a,20575
 194  0055 1401          	and	a,(OFST+1,sp)
 195  0057 c7505f        	ld	20575,a
 196                     ; 113 }
 199  005a 84            	pop	a
 200  005b 81            	ret
 223                     ; 120 void FLASH_DeInit(void)
 223                     ; 121 {
 224                     	switch	.text
 225  005c               _FLASH_DeInit:
 229                     ; 122     FLASH->CR1 = FLASH_CR1_RESET_VALUE;
 231  005c 725f505a      	clr	20570
 232                     ; 123     FLASH->CR2 = FLASH_CR2_RESET_VALUE;
 234  0060 725f505b      	clr	20571
 235                     ; 124     FLASH->NCR2 = FLASH_NCR2_RESET_VALUE;
 237  0064 35ff505c      	mov	20572,#255
 238                     ; 125     FLASH->IAPSR &= (uint8_t)(~FLASH_IAPSR_DUL);
 240  0068 7217505f      	bres	20575,#3
 241                     ; 126     FLASH->IAPSR &= (uint8_t)(~FLASH_IAPSR_PUL);
 243  006c 7213505f      	bres	20575,#1
 244                     ; 127     (void) FLASH->IAPSR; /* Reading of this register causes the clearing of status flags */
 246  0070 c6505f        	ld	a,20575
 247                     ; 128 }
 250  0073 81            	ret
 306                     ; 136 void FLASH_ITConfig(FunctionalState NewState)
 306                     ; 137 {
 307                     	switch	.text
 308  0074               _FLASH_ITConfig:
 310  0074 88            	push	a
 311       00000000      OFST:	set	0
 314                     ; 139   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 316  0075 4d            	tnz	a
 317  0076 2704          	jreq	L23
 318  0078 a101          	cp	a,#1
 319  007a 2603          	jrne	L03
 320  007c               L23:
 321  007c 4f            	clr	a
 322  007d 2010          	jra	L43
 323  007f               L03:
 324  007f ae008b        	ldw	x,#139
 325  0082 89            	pushw	x
 326  0083 ae0000        	ldw	x,#0
 327  0086 89            	pushw	x
 328  0087 ae0010        	ldw	x,#L73
 329  008a cd0000        	call	_assert_failed
 331  008d 5b04          	addw	sp,#4
 332  008f               L43:
 333                     ; 141     if (NewState != DISABLE)
 335  008f 0d01          	tnz	(OFST+1,sp)
 336  0091 2706          	jreq	L121
 337                     ; 143         FLASH->CR1 |= FLASH_CR1_IE; /* Enables the interrupt sources */
 339  0093 7212505a      	bset	20570,#1
 341  0097 2004          	jra	L321
 342  0099               L121:
 343                     ; 147         FLASH->CR1 &= (uint8_t)(~FLASH_CR1_IE); /* Disables the interrupt sources */
 345  0099 7213505a      	bres	20570,#1
 346  009d               L321:
 347                     ; 149 }
 350  009d 84            	pop	a
 351  009e 81            	ret
 386                     .const:	section	.text
 387  0000               L64:
 388  0000 00008000      	dc.l	32768
 389  0004               L05:
 390  0004 0000a000      	dc.l	40960
 391  0008               L25:
 392  0008 00004000      	dc.l	16384
 393  000c               L45:
 394  000c 00004280      	dc.l	17024
 395                     ; 158 void FLASH_EraseByte(uint32_t Address)
 395                     ; 159 {
 396                     	switch	.text
 397  009f               _FLASH_EraseByte:
 399       00000000      OFST:	set	0
 402                     ; 161     assert_param(IS_FLASH_ADDRESS_OK(Address));
 404  009f 96            	ldw	x,sp
 405  00a0 1c0003        	addw	x,#OFST+3
 406  00a3 cd0000        	call	c_ltor
 408  00a6 ae0000        	ldw	x,#L64
 409  00a9 cd0000        	call	c_lcmp
 411  00ac 250f          	jrult	L44
 412  00ae 96            	ldw	x,sp
 413  00af 1c0003        	addw	x,#OFST+3
 414  00b2 cd0000        	call	c_ltor
 416  00b5 ae0004        	ldw	x,#L05
 417  00b8 cd0000        	call	c_lcmp
 419  00bb 251e          	jrult	L24
 420  00bd               L44:
 421  00bd 96            	ldw	x,sp
 422  00be 1c0003        	addw	x,#OFST+3
 423  00c1 cd0000        	call	c_ltor
 425  00c4 ae0008        	ldw	x,#L25
 426  00c7 cd0000        	call	c_lcmp
 428  00ca 2512          	jrult	L04
 429  00cc 96            	ldw	x,sp
 430  00cd 1c0003        	addw	x,#OFST+3
 431  00d0 cd0000        	call	c_ltor
 433  00d3 ae000c        	ldw	x,#L45
 434  00d6 cd0000        	call	c_lcmp
 436  00d9 2403          	jruge	L04
 437  00db               L24:
 438  00db 4f            	clr	a
 439  00dc 2010          	jra	L65
 440  00de               L04:
 441  00de ae00a1        	ldw	x,#161
 442  00e1 89            	pushw	x
 443  00e2 ae0000        	ldw	x,#0
 444  00e5 89            	pushw	x
 445  00e6 ae0010        	ldw	x,#L73
 446  00e9 cd0000        	call	_assert_failed
 448  00ec 5b04          	addw	sp,#4
 449  00ee               L65:
 450                     ; 164    *(PointerAttr uint8_t*) (uint16_t)Address = FLASH_CLEAR_BYTE; 
 452  00ee 1e05          	ldw	x,(OFST+5,sp)
 453  00f0 7f            	clr	(x)
 454                     ; 166 }
 457  00f1 81            	ret
 501                     ; 176 void FLASH_ProgramByte(uint32_t Address, uint8_t Data)
 501                     ; 177 {
 502                     	switch	.text
 503  00f2               _FLASH_ProgramByte:
 505       00000000      OFST:	set	0
 508                     ; 179     assert_param(IS_FLASH_ADDRESS_OK(Address));
 510  00f2 96            	ldw	x,sp
 511  00f3 1c0003        	addw	x,#OFST+3
 512  00f6 cd0000        	call	c_ltor
 514  00f9 ae0000        	ldw	x,#L64
 515  00fc cd0000        	call	c_lcmp
 517  00ff 250f          	jrult	L66
 518  0101 96            	ldw	x,sp
 519  0102 1c0003        	addw	x,#OFST+3
 520  0105 cd0000        	call	c_ltor
 522  0108 ae0004        	ldw	x,#L05
 523  010b cd0000        	call	c_lcmp
 525  010e 251e          	jrult	L46
 526  0110               L66:
 527  0110 96            	ldw	x,sp
 528  0111 1c0003        	addw	x,#OFST+3
 529  0114 cd0000        	call	c_ltor
 531  0117 ae0008        	ldw	x,#L25
 532  011a cd0000        	call	c_lcmp
 534  011d 2512          	jrult	L26
 535  011f 96            	ldw	x,sp
 536  0120 1c0003        	addw	x,#OFST+3
 537  0123 cd0000        	call	c_ltor
 539  0126 ae000c        	ldw	x,#L45
 540  0129 cd0000        	call	c_lcmp
 542  012c 2403          	jruge	L26
 543  012e               L46:
 544  012e 4f            	clr	a
 545  012f 2010          	jra	L07
 546  0131               L26:
 547  0131 ae00b3        	ldw	x,#179
 548  0134 89            	pushw	x
 549  0135 ae0000        	ldw	x,#0
 550  0138 89            	pushw	x
 551  0139 ae0010        	ldw	x,#L73
 552  013c cd0000        	call	_assert_failed
 554  013f 5b04          	addw	sp,#4
 555  0141               L07:
 556                     ; 180     *(PointerAttr uint8_t*) (uint16_t)Address = Data;
 558  0141 7b07          	ld	a,(OFST+7,sp)
 559  0143 1e05          	ldw	x,(OFST+5,sp)
 560  0145 f7            	ld	(x),a
 561                     ; 181 }
 564  0146 81            	ret
 599                     ; 190 uint8_t FLASH_ReadByte(uint32_t Address)
 599                     ; 191 {
 600                     	switch	.text
 601  0147               _FLASH_ReadByte:
 603       00000000      OFST:	set	0
 606                     ; 193     assert_param(IS_FLASH_ADDRESS_OK(Address));
 608  0147 96            	ldw	x,sp
 609  0148 1c0003        	addw	x,#OFST+3
 610  014b cd0000        	call	c_ltor
 612  014e ae0000        	ldw	x,#L64
 613  0151 cd0000        	call	c_lcmp
 615  0154 250f          	jrult	L001
 616  0156 96            	ldw	x,sp
 617  0157 1c0003        	addw	x,#OFST+3
 618  015a cd0000        	call	c_ltor
 620  015d ae0004        	ldw	x,#L05
 621  0160 cd0000        	call	c_lcmp
 623  0163 251e          	jrult	L67
 624  0165               L001:
 625  0165 96            	ldw	x,sp
 626  0166 1c0003        	addw	x,#OFST+3
 627  0169 cd0000        	call	c_ltor
 629  016c ae0008        	ldw	x,#L25
 630  016f cd0000        	call	c_lcmp
 632  0172 2512          	jrult	L47
 633  0174 96            	ldw	x,sp
 634  0175 1c0003        	addw	x,#OFST+3
 635  0178 cd0000        	call	c_ltor
 637  017b ae000c        	ldw	x,#L45
 638  017e cd0000        	call	c_lcmp
 640  0181 2403          	jruge	L47
 641  0183               L67:
 642  0183 4f            	clr	a
 643  0184 2010          	jra	L201
 644  0186               L47:
 645  0186 ae00c1        	ldw	x,#193
 646  0189 89            	pushw	x
 647  018a ae0000        	ldw	x,#0
 648  018d 89            	pushw	x
 649  018e ae0010        	ldw	x,#L73
 650  0191 cd0000        	call	_assert_failed
 652  0194 5b04          	addw	sp,#4
 653  0196               L201:
 654                     ; 196     return(*(PointerAttr uint8_t *) (uint16_t)Address); 
 656  0196 1e05          	ldw	x,(OFST+5,sp)
 657  0198 f6            	ld	a,(x)
 660  0199 81            	ret
 704                     ; 207 void FLASH_ProgramWord(uint32_t Address, uint32_t Data)
 704                     ; 208 {
 705                     	switch	.text
 706  019a               _FLASH_ProgramWord:
 708       00000000      OFST:	set	0
 711                     ; 210     assert_param(IS_FLASH_ADDRESS_OK(Address));
 713  019a 96            	ldw	x,sp
 714  019b 1c0003        	addw	x,#OFST+3
 715  019e cd0000        	call	c_ltor
 717  01a1 ae0000        	ldw	x,#L64
 718  01a4 cd0000        	call	c_lcmp
 720  01a7 250f          	jrult	L211
 721  01a9 96            	ldw	x,sp
 722  01aa 1c0003        	addw	x,#OFST+3
 723  01ad cd0000        	call	c_ltor
 725  01b0 ae0004        	ldw	x,#L05
 726  01b3 cd0000        	call	c_lcmp
 728  01b6 251e          	jrult	L011
 729  01b8               L211:
 730  01b8 96            	ldw	x,sp
 731  01b9 1c0003        	addw	x,#OFST+3
 732  01bc cd0000        	call	c_ltor
 734  01bf ae0008        	ldw	x,#L25
 735  01c2 cd0000        	call	c_lcmp
 737  01c5 2512          	jrult	L601
 738  01c7 96            	ldw	x,sp
 739  01c8 1c0003        	addw	x,#OFST+3
 740  01cb cd0000        	call	c_ltor
 742  01ce ae000c        	ldw	x,#L45
 743  01d1 cd0000        	call	c_lcmp
 745  01d4 2403          	jruge	L601
 746  01d6               L011:
 747  01d6 4f            	clr	a
 748  01d7 2010          	jra	L411
 749  01d9               L601:
 750  01d9 ae00d2        	ldw	x,#210
 751  01dc 89            	pushw	x
 752  01dd ae0000        	ldw	x,#0
 753  01e0 89            	pushw	x
 754  01e1 ae0010        	ldw	x,#L73
 755  01e4 cd0000        	call	_assert_failed
 757  01e7 5b04          	addw	sp,#4
 758  01e9               L411:
 759                     ; 213     FLASH->CR2 |= FLASH_CR2_WPRG;
 761  01e9 721c505b      	bset	20571,#6
 762                     ; 214     FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NWPRG);
 764  01ed 721d505c      	bres	20572,#6
 765                     ; 217     *((PointerAttr uint8_t*)(uint16_t)Address)       = *((uint8_t*)(&Data));
 767  01f1 7b07          	ld	a,(OFST+7,sp)
 768  01f3 1e05          	ldw	x,(OFST+5,sp)
 769  01f5 f7            	ld	(x),a
 770                     ; 219     *(((PointerAttr uint8_t*)(uint16_t)Address) + 1) = *((uint8_t*)(&Data)+1); 
 772  01f6 7b08          	ld	a,(OFST+8,sp)
 773  01f8 1e05          	ldw	x,(OFST+5,sp)
 774  01fa e701          	ld	(1,x),a
 775                     ; 221     *(((PointerAttr uint8_t*)(uint16_t)Address) + 2) = *((uint8_t*)(&Data)+2); 
 777  01fc 7b09          	ld	a,(OFST+9,sp)
 778  01fe 1e05          	ldw	x,(OFST+5,sp)
 779  0200 e702          	ld	(2,x),a
 780                     ; 223     *(((PointerAttr uint8_t*)(uint16_t)Address) + 3) = *((uint8_t*)(&Data)+3); 
 782  0202 7b0a          	ld	a,(OFST+10,sp)
 783  0204 1e05          	ldw	x,(OFST+5,sp)
 784  0206 e703          	ld	(3,x),a
 785                     ; 224 }
 788  0208 81            	ret
 834                     ; 232 void FLASH_ProgramOptionByte(uint16_t Address, uint8_t Data)
 834                     ; 233 {
 835                     	switch	.text
 836  0209               _FLASH_ProgramOptionByte:
 838  0209 89            	pushw	x
 839       00000000      OFST:	set	0
 842                     ; 235     assert_param(IS_OPTION_BYTE_ADDRESS_OK(Address));
 844  020a a34800        	cpw	x,#18432
 845  020d 2508          	jrult	L021
 846  020f a34880        	cpw	x,#18560
 847  0212 2403          	jruge	L021
 848  0214 4f            	clr	a
 849  0215 2010          	jra	L221
 850  0217               L021:
 851  0217 ae00eb        	ldw	x,#235
 852  021a 89            	pushw	x
 853  021b ae0000        	ldw	x,#0
 854  021e 89            	pushw	x
 855  021f ae0010        	ldw	x,#L73
 856  0222 cd0000        	call	_assert_failed
 858  0225 5b04          	addw	sp,#4
 859  0227               L221:
 860                     ; 238     FLASH->CR2 |= FLASH_CR2_OPT;
 862  0227 721e505b      	bset	20571,#7
 863                     ; 239     FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NOPT);
 865  022b 721f505c      	bres	20572,#7
 866                     ; 242     if (Address == 0x4800)
 868  022f 1e01          	ldw	x,(OFST+1,sp)
 869  0231 a34800        	cpw	x,#18432
 870  0234 2607          	jrne	L742
 871                     ; 245        *((NEAR uint8_t*)Address) = Data;
 873  0236 7b05          	ld	a,(OFST+5,sp)
 874  0238 1e01          	ldw	x,(OFST+1,sp)
 875  023a f7            	ld	(x),a
 877  023b 200c          	jra	L152
 878  023d               L742:
 879                     ; 250        *((NEAR uint8_t*)Address) = Data;
 881  023d 7b05          	ld	a,(OFST+5,sp)
 882  023f 1e01          	ldw	x,(OFST+1,sp)
 883  0241 f7            	ld	(x),a
 884                     ; 251        *((NEAR uint8_t*)((uint16_t)(Address + 1))) = (uint8_t)(~Data);
 886  0242 7b05          	ld	a,(OFST+5,sp)
 887  0244 43            	cpl	a
 888  0245 1e01          	ldw	x,(OFST+1,sp)
 889  0247 e701          	ld	(1,x),a
 890  0249               L152:
 891                     ; 253     FLASH_WaitForLastOperation(FLASH_MEMTYPE_PROG);
 893  0249 a6fd          	ld	a,#253
 894  024b cd03dd        	call	_FLASH_WaitForLastOperation
 896                     ; 256     FLASH->CR2 &= (uint8_t)(~FLASH_CR2_OPT);
 898  024e 721f505b      	bres	20571,#7
 899                     ; 257     FLASH->NCR2 |= FLASH_NCR2_NOPT;
 901  0252 721e505c      	bset	20572,#7
 902                     ; 258 }
 905  0256 85            	popw	x
 906  0257 81            	ret
 943                     ; 265 void FLASH_EraseOptionByte(uint16_t Address)
 943                     ; 266 {
 944                     	switch	.text
 945  0258               _FLASH_EraseOptionByte:
 947  0258 89            	pushw	x
 948       00000000      OFST:	set	0
 951                     ; 268     assert_param(IS_OPTION_BYTE_ADDRESS_OK(Address));
 953  0259 a34800        	cpw	x,#18432
 954  025c 2508          	jrult	L621
 955  025e a34880        	cpw	x,#18560
 956  0261 2403          	jruge	L621
 957  0263 4f            	clr	a
 958  0264 2010          	jra	L031
 959  0266               L621:
 960  0266 ae010c        	ldw	x,#268
 961  0269 89            	pushw	x
 962  026a ae0000        	ldw	x,#0
 963  026d 89            	pushw	x
 964  026e ae0010        	ldw	x,#L73
 965  0271 cd0000        	call	_assert_failed
 967  0274 5b04          	addw	sp,#4
 968  0276               L031:
 969                     ; 271     FLASH->CR2 |= FLASH_CR2_OPT;
 971  0276 721e505b      	bset	20571,#7
 972                     ; 272     FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NOPT);
 974  027a 721f505c      	bres	20572,#7
 975                     ; 275      if (Address == 0x4800)
 977  027e 1e01          	ldw	x,(OFST+1,sp)
 978  0280 a34800        	cpw	x,#18432
 979  0283 2605          	jrne	L172
 980                     ; 278        *((NEAR uint8_t*)Address) = FLASH_CLEAR_BYTE;
 982  0285 1e01          	ldw	x,(OFST+1,sp)
 983  0287 7f            	clr	(x)
 985  0288 2009          	jra	L372
 986  028a               L172:
 987                     ; 283        *((NEAR uint8_t*)Address) = FLASH_CLEAR_BYTE;
 989  028a 1e01          	ldw	x,(OFST+1,sp)
 990  028c 7f            	clr	(x)
 991                     ; 284        *((NEAR uint8_t*)((uint16_t)(Address + (uint16_t)1 ))) = FLASH_SET_BYTE;
 993  028d 1e01          	ldw	x,(OFST+1,sp)
 994  028f a6ff          	ld	a,#255
 995  0291 e701          	ld	(1,x),a
 996  0293               L372:
 997                     ; 286     FLASH_WaitForLastOperation(FLASH_MEMTYPE_PROG);
 999  0293 a6fd          	ld	a,#253
1000  0295 cd03dd        	call	_FLASH_WaitForLastOperation
1002                     ; 289     FLASH->CR2 &= (uint8_t)(~FLASH_CR2_OPT);
1004  0298 721f505b      	bres	20571,#7
1005                     ; 290     FLASH->NCR2 |= FLASH_NCR2_NOPT;
1007  029c 721e505c      	bset	20572,#7
1008                     ; 291 }
1011  02a0 85            	popw	x
1012  02a1 81            	ret
1076                     ; 297 uint16_t FLASH_ReadOptionByte(uint16_t Address)
1076                     ; 298 {
1077                     	switch	.text
1078  02a2               _FLASH_ReadOptionByte:
1080  02a2 89            	pushw	x
1081  02a3 5204          	subw	sp,#4
1082       00000004      OFST:	set	4
1085                     ; 299     uint8_t value_optbyte, value_optbyte_complement = 0;
1087                     ; 300     uint16_t res_value = 0;
1089                     ; 303     assert_param(IS_OPTION_BYTE_ADDRESS_OK(Address));
1091  02a5 a34800        	cpw	x,#18432
1092  02a8 2508          	jrult	L431
1093  02aa a34880        	cpw	x,#18560
1094  02ad 2403          	jruge	L431
1095  02af 4f            	clr	a
1096  02b0 2010          	jra	L631
1097  02b2               L431:
1098  02b2 ae012f        	ldw	x,#303
1099  02b5 89            	pushw	x
1100  02b6 ae0000        	ldw	x,#0
1101  02b9 89            	pushw	x
1102  02ba ae0010        	ldw	x,#L73
1103  02bd cd0000        	call	_assert_failed
1105  02c0 5b04          	addw	sp,#4
1106  02c2               L631:
1107                     ; 306     value_optbyte = *((NEAR uint8_t*)Address); /* Read option byte */
1109  02c2 1e05          	ldw	x,(OFST+1,sp)
1110  02c4 f6            	ld	a,(x)
1111  02c5 6b01          	ld	(OFST-3,sp),a
1113                     ; 307     value_optbyte_complement = *(((NEAR uint8_t*)Address) + 1); /* Read option byte complement */
1115  02c7 1e05          	ldw	x,(OFST+1,sp)
1116  02c9 e601          	ld	a,(1,x)
1117  02cb 6b02          	ld	(OFST-2,sp),a
1119                     ; 310     if (Address == 0x4800)	 
1121  02cd 1e05          	ldw	x,(OFST+1,sp)
1122  02cf a34800        	cpw	x,#18432
1123  02d2 2608          	jrne	L723
1124                     ; 312         res_value =	 value_optbyte;
1126  02d4 7b01          	ld	a,(OFST-3,sp)
1127  02d6 5f            	clrw	x
1128  02d7 97            	ld	xl,a
1129  02d8 1f03          	ldw	(OFST-1,sp),x
1132  02da 2023          	jra	L133
1133  02dc               L723:
1134                     ; 316         if (value_optbyte == (uint8_t)(~value_optbyte_complement))
1136  02dc 7b02          	ld	a,(OFST-2,sp)
1137  02de 43            	cpl	a
1138  02df 1101          	cp	a,(OFST-3,sp)
1139  02e1 2617          	jrne	L333
1140                     ; 318             res_value = (uint16_t)((uint16_t)value_optbyte << 8);
1142  02e3 7b01          	ld	a,(OFST-3,sp)
1143  02e5 5f            	clrw	x
1144  02e6 97            	ld	xl,a
1145  02e7 4f            	clr	a
1146  02e8 02            	rlwa	x,a
1147  02e9 1f03          	ldw	(OFST-1,sp),x
1149                     ; 319             res_value = res_value | (uint16_t)value_optbyte_complement;
1151  02eb 7b02          	ld	a,(OFST-2,sp)
1152  02ed 5f            	clrw	x
1153  02ee 97            	ld	xl,a
1154  02ef 01            	rrwa	x,a
1155  02f0 1a04          	or	a,(OFST+0,sp)
1156  02f2 01            	rrwa	x,a
1157  02f3 1a03          	or	a,(OFST-1,sp)
1158  02f5 01            	rrwa	x,a
1159  02f6 1f03          	ldw	(OFST-1,sp),x
1162  02f8 2005          	jra	L133
1163  02fa               L333:
1164                     ; 323             res_value = FLASH_OPTIONBYTE_ERROR;
1166  02fa ae5555        	ldw	x,#21845
1167  02fd 1f03          	ldw	(OFST-1,sp),x
1169  02ff               L133:
1170                     ; 326     return(res_value);
1172  02ff 1e03          	ldw	x,(OFST-1,sp)
1175  0301 5b06          	addw	sp,#6
1176  0303 81            	ret
1251                     ; 335 void FLASH_SetLowPowerMode(FLASH_LPMode_TypeDef FLASH_LPMode)
1251                     ; 336 {
1252                     	switch	.text
1253  0304               _FLASH_SetLowPowerMode:
1255  0304 88            	push	a
1256       00000000      OFST:	set	0
1259                     ; 338     assert_param(IS_FLASH_LOW_POWER_MODE_OK(FLASH_LPMode));
1261  0305 a104          	cp	a,#4
1262  0307 270b          	jreq	L441
1263  0309 a108          	cp	a,#8
1264  030b 2707          	jreq	L441
1265  030d 4d            	tnz	a
1266  030e 2704          	jreq	L441
1267  0310 a10c          	cp	a,#12
1268  0312 2603          	jrne	L241
1269  0314               L441:
1270  0314 4f            	clr	a
1271  0315 2010          	jra	L641
1272  0317               L241:
1273  0317 ae0152        	ldw	x,#338
1274  031a 89            	pushw	x
1275  031b ae0000        	ldw	x,#0
1276  031e 89            	pushw	x
1277  031f ae0010        	ldw	x,#L73
1278  0322 cd0000        	call	_assert_failed
1280  0325 5b04          	addw	sp,#4
1281  0327               L641:
1282                     ; 341     FLASH->CR1 &= (uint8_t)(~(FLASH_CR1_HALT | FLASH_CR1_AHALT)); 
1284  0327 c6505a        	ld	a,20570
1285  032a a4f3          	and	a,#243
1286  032c c7505a        	ld	20570,a
1287                     ; 344     FLASH->CR1 |= (uint8_t)FLASH_LPMode; 
1289  032f c6505a        	ld	a,20570
1290  0332 1a01          	or	a,(OFST+1,sp)
1291  0334 c7505a        	ld	20570,a
1292                     ; 345 }
1295  0337 84            	pop	a
1296  0338 81            	ret
1355                     ; 353 void FLASH_SetProgrammingTime(FLASH_ProgramTime_TypeDef FLASH_ProgTime)
1355                     ; 354 {
1356                     	switch	.text
1357  0339               _FLASH_SetProgrammingTime:
1359  0339 88            	push	a
1360       00000000      OFST:	set	0
1363                     ; 356     assert_param(IS_FLASH_PROGRAM_TIME_OK(FLASH_ProgTime));
1365  033a 4d            	tnz	a
1366  033b 2704          	jreq	L451
1367  033d a101          	cp	a,#1
1368  033f 2603          	jrne	L251
1369  0341               L451:
1370  0341 4f            	clr	a
1371  0342 2010          	jra	L651
1372  0344               L251:
1373  0344 ae0164        	ldw	x,#356
1374  0347 89            	pushw	x
1375  0348 ae0000        	ldw	x,#0
1376  034b 89            	pushw	x
1377  034c ae0010        	ldw	x,#L73
1378  034f cd0000        	call	_assert_failed
1380  0352 5b04          	addw	sp,#4
1381  0354               L651:
1382                     ; 358     FLASH->CR1 &= (uint8_t)(~FLASH_CR1_FIX);
1384  0354 7211505a      	bres	20570,#0
1385                     ; 359     FLASH->CR1 |= (uint8_t)FLASH_ProgTime;
1387  0358 c6505a        	ld	a,20570
1388  035b 1a01          	or	a,(OFST+1,sp)
1389  035d c7505a        	ld	20570,a
1390                     ; 360 }
1393  0360 84            	pop	a
1394  0361 81            	ret
1419                     ; 367 FLASH_LPMode_TypeDef FLASH_GetLowPowerMode(void)
1419                     ; 368 {
1420                     	switch	.text
1421  0362               _FLASH_GetLowPowerMode:
1425                     ; 369     return((FLASH_LPMode_TypeDef)(FLASH->CR1 & (uint8_t)(FLASH_CR1_HALT | FLASH_CR1_AHALT)));
1427  0362 c6505a        	ld	a,20570
1428  0365 a40c          	and	a,#12
1431  0367 81            	ret
1456                     ; 377 FLASH_ProgramTime_TypeDef FLASH_GetProgrammingTime(void)
1456                     ; 378 {
1457                     	switch	.text
1458  0368               _FLASH_GetProgrammingTime:
1462                     ; 379     return((FLASH_ProgramTime_TypeDef)(FLASH->CR1 & FLASH_CR1_FIX));
1464  0368 c6505a        	ld	a,20570
1465  036b a401          	and	a,#1
1468  036d 81            	ret
1502                     ; 387 uint32_t FLASH_GetBootSize(void)
1502                     ; 388 {
1503                     	switch	.text
1504  036e               _FLASH_GetBootSize:
1506  036e 5204          	subw	sp,#4
1507       00000004      OFST:	set	4
1510                     ; 389     uint32_t temp = 0;
1512                     ; 392     temp = (uint32_t)((uint32_t)FLASH->FPR * (uint32_t)512);
1514  0370 c6505d        	ld	a,20573
1515  0373 5f            	clrw	x
1516  0374 97            	ld	xl,a
1517  0375 90ae0200      	ldw	y,#512
1518  0379 cd0000        	call	c_umul
1520  037c 96            	ldw	x,sp
1521  037d 1c0001        	addw	x,#OFST-3
1522  0380 cd0000        	call	c_rtol
1525                     ; 395     if (FLASH->FPR == 0xFF)
1527  0383 c6505d        	ld	a,20573
1528  0386 a1ff          	cp	a,#255
1529  0388 2611          	jrne	L554
1530                     ; 397         temp += 512;
1532  038a ae0200        	ldw	x,#512
1533  038d bf02          	ldw	c_lreg+2,x
1534  038f ae0000        	ldw	x,#0
1535  0392 bf00          	ldw	c_lreg,x
1536  0394 96            	ldw	x,sp
1537  0395 1c0001        	addw	x,#OFST-3
1538  0398 cd0000        	call	c_lgadd
1541  039b               L554:
1542                     ; 401     return(temp);
1544  039b 96            	ldw	x,sp
1545  039c 1c0001        	addw	x,#OFST-3
1546  039f cd0000        	call	c_ltor
1550  03a2 5b04          	addw	sp,#4
1551  03a4 81            	ret
1654                     ; 412 FlagStatus FLASH_GetFlagStatus(FLASH_Flag_TypeDef FLASH_FLAG)
1654                     ; 413 {
1655                     	switch	.text
1656  03a5               _FLASH_GetFlagStatus:
1658  03a5 88            	push	a
1659  03a6 88            	push	a
1660       00000001      OFST:	set	1
1663                     ; 414     FlagStatus status = RESET;
1665                     ; 416     assert_param(IS_FLASH_FLAGS_OK(FLASH_FLAG));
1667  03a7 a108          	cp	a,#8
1668  03a9 270c          	jreq	L271
1669  03ab a104          	cp	a,#4
1670  03ad 2708          	jreq	L271
1671  03af a102          	cp	a,#2
1672  03b1 2704          	jreq	L271
1673  03b3 a101          	cp	a,#1
1674  03b5 2603          	jrne	L071
1675  03b7               L271:
1676  03b7 4f            	clr	a
1677  03b8 2010          	jra	L471
1678  03ba               L071:
1679  03ba ae01a0        	ldw	x,#416
1680  03bd 89            	pushw	x
1681  03be ae0000        	ldw	x,#0
1682  03c1 89            	pushw	x
1683  03c2 ae0010        	ldw	x,#L73
1684  03c5 cd0000        	call	_assert_failed
1686  03c8 5b04          	addw	sp,#4
1687  03ca               L471:
1688                     ; 419     if ((FLASH->IAPSR & (uint8_t)FLASH_FLAG) != (uint8_t)RESET)
1690  03ca c6505f        	ld	a,20575
1691  03cd 1502          	bcp	a,(OFST+1,sp)
1692  03cf 2706          	jreq	L525
1693                     ; 421         status = SET; /* FLASH_FLAG is set */
1695  03d1 a601          	ld	a,#1
1696  03d3 6b01          	ld	(OFST+0,sp),a
1699  03d5 2002          	jra	L725
1700  03d7               L525:
1701                     ; 425         status = RESET; /* FLASH_FLAG is reset*/
1703  03d7 0f01          	clr	(OFST+0,sp)
1705  03d9               L725:
1706                     ; 429     return status;
1708  03d9 7b01          	ld	a,(OFST+0,sp)
1711  03db 85            	popw	x
1712  03dc 81            	ret
1797                     ; 531 IN_RAM(FLASH_Status_TypeDef FLASH_WaitForLastOperation(FLASH_MemType_TypeDef FLASH_MemType)) 
1797                     ; 532 {
1798                     	switch	.text
1799  03dd               _FLASH_WaitForLastOperation:
1801  03dd 5205          	subw	sp,#5
1802       00000005      OFST:	set	5
1805                     ; 533     uint8_t flagstatus = 0x00;
1807  03df 0f05          	clr	(OFST+0,sp)
1809                     ; 534     uint32_t timeout = OPERATION_TIMEOUT;
1811  03e1 aeffff        	ldw	x,#65535
1812  03e4 1f03          	ldw	(OFST-2,sp),x
1813  03e6 ae000f        	ldw	x,#15
1814  03e9 1f01          	ldw	(OFST-4,sp),x
1817  03eb 2010          	jra	L575
1818  03ed               L175:
1819                     ; 560         flagstatus = (uint8_t)(FLASH->IAPSR & (FLASH_IAPSR_EOP | FLASH_IAPSR_WR_PG_DIS));
1821  03ed c6505f        	ld	a,20575
1822  03f0 a405          	and	a,#5
1823  03f2 6b05          	ld	(OFST+0,sp),a
1825                     ; 561         timeout--;
1827  03f4 96            	ldw	x,sp
1828  03f5 1c0001        	addw	x,#OFST-4
1829  03f8 a601          	ld	a,#1
1830  03fa cd0000        	call	c_lgsbc
1833  03fd               L575:
1834                     ; 558     while ((flagstatus == 0x00) && (timeout != 0x00))
1836  03fd 0d05          	tnz	(OFST+0,sp)
1837  03ff 2609          	jrne	L106
1839  0401 96            	ldw	x,sp
1840  0402 1c0001        	addw	x,#OFST-4
1841  0405 cd0000        	call	c_lzmp
1843  0408 26e3          	jrne	L175
1844  040a               L106:
1845                     ; 566     if (timeout == 0x00 )
1847  040a 96            	ldw	x,sp
1848  040b 1c0001        	addw	x,#OFST-4
1849  040e cd0000        	call	c_lzmp
1851  0411 2604          	jrne	L306
1852                     ; 568         flagstatus = FLASH_STATUS_TIMEOUT;
1854  0413 a602          	ld	a,#2
1855  0415 6b05          	ld	(OFST+0,sp),a
1857  0417               L306:
1858                     ; 571     return((FLASH_Status_TypeDef)flagstatus);
1860  0417 7b05          	ld	a,(OFST+0,sp)
1863  0419 5b05          	addw	sp,#5
1864  041b 81            	ret
1928                     ; 581 IN_RAM(void FLASH_EraseBlock(uint16_t BlockNum, FLASH_MemType_TypeDef FLASH_MemType))
1928                     ; 582 {
1929                     	switch	.text
1930  041c               _FLASH_EraseBlock:
1932  041c 89            	pushw	x
1933  041d 5206          	subw	sp,#6
1934       00000006      OFST:	set	6
1937                     ; 583   uint32_t startaddress = 0;
1939                     ; 593   assert_param(IS_MEMORY_TYPE_OK(FLASH_MemType));
1941  041f 7b0b          	ld	a,(OFST+5,sp)
1942  0421 a1fd          	cp	a,#253
1943  0423 2706          	jreq	L402
1944  0425 7b0b          	ld	a,(OFST+5,sp)
1945  0427 a1f7          	cp	a,#247
1946  0429 2603          	jrne	L202
1947  042b               L402:
1948  042b 4f            	clr	a
1949  042c 2010          	jra	L602
1950  042e               L202:
1951  042e ae0251        	ldw	x,#593
1952  0431 89            	pushw	x
1953  0432 ae0000        	ldw	x,#0
1954  0435 89            	pushw	x
1955  0436 ae0010        	ldw	x,#L73
1956  0439 cd0000        	call	_assert_failed
1958  043c 5b04          	addw	sp,#4
1959  043e               L602:
1960                     ; 594   if (FLASH_MemType == FLASH_MEMTYPE_PROG)
1962  043e 7b0b          	ld	a,(OFST+5,sp)
1963  0440 a1fd          	cp	a,#253
1964  0442 2626          	jrne	L736
1965                     ; 596       assert_param(IS_FLASH_PROG_BLOCK_NUMBER_OK(BlockNum));
1967  0444 1e07          	ldw	x,(OFST+1,sp)
1968  0446 a30080        	cpw	x,#128
1969  0449 2403          	jruge	L012
1970  044b 4f            	clr	a
1971  044c 2010          	jra	L212
1972  044e               L012:
1973  044e ae0254        	ldw	x,#596
1974  0451 89            	pushw	x
1975  0452 ae0000        	ldw	x,#0
1976  0455 89            	pushw	x
1977  0456 ae0010        	ldw	x,#L73
1978  0459 cd0000        	call	_assert_failed
1980  045c 5b04          	addw	sp,#4
1981  045e               L212:
1982                     ; 597       startaddress = FLASH_PROG_START_PHYSICAL_ADDRESS;
1984  045e ae8000        	ldw	x,#32768
1985  0461 1f05          	ldw	(OFST-1,sp),x
1986  0463 ae0000        	ldw	x,#0
1987  0466 1f03          	ldw	(OFST-3,sp),x
1990  0468 2024          	jra	L146
1991  046a               L736:
1992                     ; 601       assert_param(IS_FLASH_DATA_BLOCK_NUMBER_OK(BlockNum));
1994  046a 1e07          	ldw	x,(OFST+1,sp)
1995  046c a3000a        	cpw	x,#10
1996  046f 2403          	jruge	L412
1997  0471 4f            	clr	a
1998  0472 2010          	jra	L612
1999  0474               L412:
2000  0474 ae0259        	ldw	x,#601
2001  0477 89            	pushw	x
2002  0478 ae0000        	ldw	x,#0
2003  047b 89            	pushw	x
2004  047c ae0010        	ldw	x,#L73
2005  047f cd0000        	call	_assert_failed
2007  0482 5b04          	addw	sp,#4
2008  0484               L612:
2009                     ; 602       startaddress = FLASH_DATA_START_PHYSICAL_ADDRESS;
2011  0484 ae4000        	ldw	x,#16384
2012  0487 1f05          	ldw	(OFST-1,sp),x
2013  0489 ae0000        	ldw	x,#0
2014  048c 1f03          	ldw	(OFST-3,sp),x
2016  048e               L146:
2017                     ; 610     pwFlash = (PointerAttr uint32_t *)(uint16_t)(startaddress + ((uint32_t)BlockNum * FLASH_BLOCK_SIZE));
2019  048e 1e07          	ldw	x,(OFST+1,sp)
2020  0490 a640          	ld	a,#64
2021  0492 cd0000        	call	c_cmulx
2023  0495 96            	ldw	x,sp
2024  0496 1c0003        	addw	x,#OFST-3
2025  0499 cd0000        	call	c_ladd
2027  049c be02          	ldw	x,c_lreg+2
2028  049e 1f01          	ldw	(OFST-5,sp),x
2030                     ; 614     FLASH->CR2 |= FLASH_CR2_ERASE;
2032  04a0 721a505b      	bset	20571,#5
2033                     ; 615     FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NERASE);
2035  04a4 721b505c      	bres	20572,#5
2036                     ; 619     *pwFlash = (uint32_t)0;
2038  04a8 1e01          	ldw	x,(OFST-5,sp)
2039  04aa a600          	ld	a,#0
2040  04ac e703          	ld	(3,x),a
2041  04ae a600          	ld	a,#0
2042  04b0 e702          	ld	(2,x),a
2043  04b2 a600          	ld	a,#0
2044  04b4 e701          	ld	(1,x),a
2045  04b6 a600          	ld	a,#0
2046  04b8 f7            	ld	(x),a
2047                     ; 627 }
2050  04b9 5b08          	addw	sp,#8
2051  04bb 81            	ret
2156                     ; 638 IN_RAM(void FLASH_ProgramBlock(uint16_t BlockNum, FLASH_MemType_TypeDef FLASH_MemType, 
2156                     ; 639                         FLASH_ProgramMode_TypeDef FLASH_ProgMode, uint8_t *Buffer))
2156                     ; 640 {
2157                     	switch	.text
2158  04bc               _FLASH_ProgramBlock:
2160  04bc 89            	pushw	x
2161  04bd 5206          	subw	sp,#6
2162       00000006      OFST:	set	6
2165                     ; 641     uint16_t Count = 0;
2167                     ; 642     uint32_t startaddress = 0;
2169                     ; 645     assert_param(IS_MEMORY_TYPE_OK(FLASH_MemType));
2171  04bf 7b0b          	ld	a,(OFST+5,sp)
2172  04c1 a1fd          	cp	a,#253
2173  04c3 2706          	jreq	L422
2174  04c5 7b0b          	ld	a,(OFST+5,sp)
2175  04c7 a1f7          	cp	a,#247
2176  04c9 2603          	jrne	L222
2177  04cb               L422:
2178  04cb 4f            	clr	a
2179  04cc 2010          	jra	L622
2180  04ce               L222:
2181  04ce ae0285        	ldw	x,#645
2182  04d1 89            	pushw	x
2183  04d2 ae0000        	ldw	x,#0
2184  04d5 89            	pushw	x
2185  04d6 ae0010        	ldw	x,#L73
2186  04d9 cd0000        	call	_assert_failed
2188  04dc 5b04          	addw	sp,#4
2189  04de               L622:
2190                     ; 646     assert_param(IS_FLASH_PROGRAM_MODE_OK(FLASH_ProgMode));
2192  04de 0d0c          	tnz	(OFST+6,sp)
2193  04e0 2706          	jreq	L232
2194  04e2 7b0c          	ld	a,(OFST+6,sp)
2195  04e4 a110          	cp	a,#16
2196  04e6 2603          	jrne	L032
2197  04e8               L232:
2198  04e8 4f            	clr	a
2199  04e9 2010          	jra	L432
2200  04eb               L032:
2201  04eb ae0286        	ldw	x,#646
2202  04ee 89            	pushw	x
2203  04ef ae0000        	ldw	x,#0
2204  04f2 89            	pushw	x
2205  04f3 ae0010        	ldw	x,#L73
2206  04f6 cd0000        	call	_assert_failed
2208  04f9 5b04          	addw	sp,#4
2209  04fb               L432:
2210                     ; 647     if (FLASH_MemType == FLASH_MEMTYPE_PROG)
2212  04fb 7b0b          	ld	a,(OFST+5,sp)
2213  04fd a1fd          	cp	a,#253
2214  04ff 2626          	jrne	L517
2215                     ; 649         assert_param(IS_FLASH_PROG_BLOCK_NUMBER_OK(BlockNum));
2217  0501 1e07          	ldw	x,(OFST+1,sp)
2218  0503 a30080        	cpw	x,#128
2219  0506 2403          	jruge	L632
2220  0508 4f            	clr	a
2221  0509 2010          	jra	L042
2222  050b               L632:
2223  050b ae0289        	ldw	x,#649
2224  050e 89            	pushw	x
2225  050f ae0000        	ldw	x,#0
2226  0512 89            	pushw	x
2227  0513 ae0010        	ldw	x,#L73
2228  0516 cd0000        	call	_assert_failed
2230  0519 5b04          	addw	sp,#4
2231  051b               L042:
2232                     ; 650         startaddress = FLASH_PROG_START_PHYSICAL_ADDRESS;
2234  051b ae8000        	ldw	x,#32768
2235  051e 1f03          	ldw	(OFST-3,sp),x
2236  0520 ae0000        	ldw	x,#0
2237  0523 1f01          	ldw	(OFST-5,sp),x
2240  0525 2024          	jra	L717
2241  0527               L517:
2242                     ; 654         assert_param(IS_FLASH_DATA_BLOCK_NUMBER_OK(BlockNum));
2244  0527 1e07          	ldw	x,(OFST+1,sp)
2245  0529 a3000a        	cpw	x,#10
2246  052c 2403          	jruge	L242
2247  052e 4f            	clr	a
2248  052f 2010          	jra	L442
2249  0531               L242:
2250  0531 ae028e        	ldw	x,#654
2251  0534 89            	pushw	x
2252  0535 ae0000        	ldw	x,#0
2253  0538 89            	pushw	x
2254  0539 ae0010        	ldw	x,#L73
2255  053c cd0000        	call	_assert_failed
2257  053f 5b04          	addw	sp,#4
2258  0541               L442:
2259                     ; 655         startaddress = FLASH_DATA_START_PHYSICAL_ADDRESS;
2261  0541 ae4000        	ldw	x,#16384
2262  0544 1f03          	ldw	(OFST-3,sp),x
2263  0546 ae0000        	ldw	x,#0
2264  0549 1f01          	ldw	(OFST-5,sp),x
2266  054b               L717:
2267                     ; 659     startaddress = startaddress + ((uint32_t)BlockNum * FLASH_BLOCK_SIZE);
2269  054b 1e07          	ldw	x,(OFST+1,sp)
2270  054d a640          	ld	a,#64
2271  054f cd0000        	call	c_cmulx
2273  0552 96            	ldw	x,sp
2274  0553 1c0001        	addw	x,#OFST-5
2275  0556 cd0000        	call	c_lgadd
2278                     ; 662     if (FLASH_ProgMode == FLASH_PROGRAMMODE_STANDARD)
2280  0559 0d0c          	tnz	(OFST+6,sp)
2281  055b 260a          	jrne	L127
2282                     ; 665         FLASH->CR2 |= FLASH_CR2_PRG;
2284  055d 7210505b      	bset	20571,#0
2285                     ; 666         FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NPRG);
2287  0561 7211505c      	bres	20572,#0
2289  0565 2008          	jra	L327
2290  0567               L127:
2291                     ; 671         FLASH->CR2 |= FLASH_CR2_FPRG;
2293  0567 7218505b      	bset	20571,#4
2294                     ; 672         FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NFPRG);
2296  056b 7219505c      	bres	20572,#4
2297  056f               L327:
2298                     ; 676     for (Count = 0; Count < FLASH_BLOCK_SIZE; Count++)
2300  056f 5f            	clrw	x
2301  0570 1f05          	ldw	(OFST-1,sp),x
2303  0572               L527:
2304                     ; 682   *((PointerAttr uint8_t*) (uint16_t)startaddress + Count) = ((uint8_t)(Buffer[Count]));
2306  0572 1e0d          	ldw	x,(OFST+7,sp)
2307  0574 72fb05        	addw	x,(OFST-1,sp)
2308  0577 f6            	ld	a,(x)
2309  0578 1e03          	ldw	x,(OFST-3,sp)
2310  057a 72fb05        	addw	x,(OFST-1,sp)
2311  057d f7            	ld	(x),a
2312                     ; 676     for (Count = 0; Count < FLASH_BLOCK_SIZE; Count++)
2314  057e 1e05          	ldw	x,(OFST-1,sp)
2315  0580 1c0001        	addw	x,#1
2316  0583 1f05          	ldw	(OFST-1,sp),x
2320  0585 1e05          	ldw	x,(OFST-1,sp)
2321  0587 a30040        	cpw	x,#64
2322  058a 25e6          	jrult	L527
2323                     ; 685 }
2326  058c 5b08          	addw	sp,#8
2327  058e 81            	ret
2340                     	xdef	_FLASH_WaitForLastOperation
2341                     	xdef	_FLASH_ProgramBlock
2342                     	xdef	_FLASH_EraseBlock
2343                     	xdef	_FLASH_GetFlagStatus
2344                     	xdef	_FLASH_GetBootSize
2345                     	xdef	_FLASH_GetProgrammingTime
2346                     	xdef	_FLASH_GetLowPowerMode
2347                     	xdef	_FLASH_SetProgrammingTime
2348                     	xdef	_FLASH_SetLowPowerMode
2349                     	xdef	_FLASH_EraseOptionByte
2350                     	xdef	_FLASH_ProgramOptionByte
2351                     	xdef	_FLASH_ReadOptionByte
2352                     	xdef	_FLASH_ProgramWord
2353                     	xdef	_FLASH_ReadByte
2354                     	xdef	_FLASH_ProgramByte
2355                     	xdef	_FLASH_EraseByte
2356                     	xdef	_FLASH_ITConfig
2357                     	xdef	_FLASH_DeInit
2358                     	xdef	_FLASH_Lock
2359                     	xdef	_FLASH_Unlock
2360                     	xref	_assert_failed
2361                     	switch	.const
2362  0010               L73:
2363  0010 73746d38735f  	dc.b	"stm8s_stdperiph_dr"
2364  0022 697665725c73  	dc.b	"iver\src\stm8s_fla"
2365  0034 73682e6300    	dc.b	"sh.c",0
2366                     	xref.b	c_lreg
2367                     	xref.b	c_x
2368                     	xref.b	c_y
2388                     	xref	c_ladd
2389                     	xref	c_cmulx
2390                     	xref	c_lzmp
2391                     	xref	c_lgsbc
2392                     	xref	c_lgadd
2393                     	xref	c_rtol
2394                     	xref	c_umul
2395                     	xref	c_lcmp
2396                     	xref	c_ltor
2397                     	end
