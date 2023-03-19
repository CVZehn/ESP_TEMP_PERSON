   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.12 - 20 Jun 2018
   3                     ; Generator (Limited) V4.4.8 - 20 Jun 2018
  42                     ; 3 void CLK_init(void)//主时钟，内部时钟，外设时钟 各对应分频器
  42                     ; 4 {
  44                     	switch	.text
  45  0000               _CLK_init:
  49                     ; 5 	CLK->ECKR = 0X01;//打开外部时钟
  51  0000 350150c1      	mov	20673,#1
  53  0004               L52:
  54                     ; 6 	while((CLK->ECKR&0x02)==0x00);//外部时钟工作稳定
  56  0004 c650c1        	ld	a,20673
  57  0007 a502          	bcp	a,#2
  58  0009 27f9          	jreq	L52
  59                     ; 8 	CLK->SWCR = CLK->SWCR|0x02;//允许时钟切换
  61  000b 721250c5      	bset	20677,#1
  62                     ; 9 	CLK->SWR = 0xb4;//外部时钟
  64  000f 35b450c4      	mov	20676,#180
  66  0013               L53:
  67                     ; 10 	while((CLK->SWCR&0x08)==0);//等待切换完成
  69  0013 c650c5        	ld	a,20677
  70  0016 a508          	bcp	a,#8
  71  0018 27f9          	jreq	L53
  72                     ; 11 	CLK->SWCR = CLK->SWCR&0xFD;//清除标志
  74  001a 721350c5      	bres	20677,#1
  75                     ; 12 	CLK->ICKR = 0x0;//关闭内部时钟	
  77  001e 725f50c0      	clr	20672
  78                     ; 13 	CLK->CKDIVR = 0x01;//8-->4M 
  80  0022 350150c6      	mov	20678,#1
  81                     ; 14 }
  84  0026 81            	ret
 107                     ; 15 void CLKInner_Init(void)
 107                     ; 16 {
 108                     	switch	.text
 109  0027               _CLKInner_Init:
 113                     ; 17 	CLK->PCKENR1 = 0xb0;//timer1  timer2 timer4 
 115  0027 35b050c7      	mov	20679,#176
 116                     ; 18 	CLK->PCKENR2 = 0x08;//ADC外设时钟
 118  002b 350850ca      	mov	20682,#8
 119                     ; 19 	CLK->CKDIVR = 0x9;//CLK_init();Fmaster = 8MHz FCPU = 4MHz
 121  002f 350950c6      	mov	20678,#9
 122                     ; 20 }
 125  0033 81            	ret
 138                     	xdef	_CLK_init
 139                     	xdef	_CLKInner_Init
 158                     	end
