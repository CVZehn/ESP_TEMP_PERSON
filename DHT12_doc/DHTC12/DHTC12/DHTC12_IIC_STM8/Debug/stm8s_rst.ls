   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.12 - 20 Jun 2018
   3                     ; Generator (Limited) V4.4.8 - 20 Jun 2018
 117                     ; 48 FlagStatus RST_GetFlagStatus(RST_Flag_TypeDef RST_Flag)
 117                     ; 49 {
 119                     	switch	.text
 120  0000               _RST_GetFlagStatus:
 122  0000 88            	push	a
 123       00000000      OFST:	set	0
 126                     ; 51     assert_param(IS_RST_FLAG_OK(RST_Flag));
 128  0001 a110          	cp	a,#16
 129  0003 2710          	jreq	L01
 130  0005 a108          	cp	a,#8
 131  0007 270c          	jreq	L01
 132  0009 a104          	cp	a,#4
 133  000b 2708          	jreq	L01
 134  000d a102          	cp	a,#2
 135  000f 2704          	jreq	L01
 136  0011 a101          	cp	a,#1
 137  0013 2603          	jrne	L6
 138  0015               L01:
 139  0015 4f            	clr	a
 140  0016 2010          	jra	L21
 141  0018               L6:
 142  0018 ae0033        	ldw	x,#51
 143  001b 89            	pushw	x
 144  001c ae0000        	ldw	x,#0
 145  001f 89            	pushw	x
 146  0020 ae0000        	ldw	x,#L55
 147  0023 cd0000        	call	_assert_failed
 149  0026 5b04          	addw	sp,#4
 150  0028               L21:
 151                     ; 55     return ((FlagStatus)((uint8_t)RST->SR & (uint8_t)RST_Flag));
 153  0028 c650b3        	ld	a,20659
 154  002b 1401          	and	a,(OFST+1,sp)
 157  002d 5b01          	addw	sp,#1
 158  002f 81            	ret
 194                     ; 64 void RST_ClearFlag(RST_Flag_TypeDef RST_Flag)
 194                     ; 65 {
 195                     	switch	.text
 196  0030               _RST_ClearFlag:
 198  0030 88            	push	a
 199       00000000      OFST:	set	0
 202                     ; 67     assert_param(IS_RST_FLAG_OK(RST_Flag));
 204  0031 a110          	cp	a,#16
 205  0033 2710          	jreq	L02
 206  0035 a108          	cp	a,#8
 207  0037 270c          	jreq	L02
 208  0039 a104          	cp	a,#4
 209  003b 2708          	jreq	L02
 210  003d a102          	cp	a,#2
 211  003f 2704          	jreq	L02
 212  0041 a101          	cp	a,#1
 213  0043 2603          	jrne	L61
 214  0045               L02:
 215  0045 4f            	clr	a
 216  0046 2010          	jra	L22
 217  0048               L61:
 218  0048 ae0043        	ldw	x,#67
 219  004b 89            	pushw	x
 220  004c ae0000        	ldw	x,#0
 221  004f 89            	pushw	x
 222  0050 ae0000        	ldw	x,#L55
 223  0053 cd0000        	call	_assert_failed
 225  0056 5b04          	addw	sp,#4
 226  0058               L22:
 227                     ; 69     RST->SR = (uint8_t)RST_Flag;
 229  0058 7b01          	ld	a,(OFST+1,sp)
 230  005a c750b3        	ld	20659,a
 231                     ; 70 }
 234  005d 84            	pop	a
 235  005e 81            	ret
 248                     	xdef	_RST_ClearFlag
 249                     	xdef	_RST_GetFlagStatus
 250                     	xref	_assert_failed
 251                     .const:	section	.text
 252  0000               L55:
 253  0000 73746d38735f  	dc.b	"stm8s_stdperiph_dr"
 254  0012 697665725c73  	dc.b	"iver\src\stm8s_rst"
 255  0024 2e6300        	dc.b	".c",0
 275                     	end
