    area     appcode, CODE, READONLY
	IMPORT printMsg 
	IMPORT	printNewLine
	EXPORT __exponential
__exponential function
	MOV R1,#1         ;i
	VLDR.F32 S0,=1.0  ;required value 
	VLDR.F32 S1,=1.0  ;temp
	;VLDR.F32 S2,=-7.0  ;x value
	VLDR.F32 S6,=1.0
	VLDR.F32 S4,=1.0
LOOP VMUL.F32 S1,S1,S2   ;intialising series
	VMOV.F32 S5,R1        ;moving i to S5 
	VCVT.F32.U32 S5, S5   ;convert the bit to unsigned
	VDIV.F32 S1,S1,S5     ;dividing by i and storing back
	VMOV.F32 S3,S0        ;moving S3 to S0
	VADD.F32 S0,S0,S1     ;adding current term to series
	ADD R1,R1,#1;         ;incrementing i
	VCMP.F32 S3,S0        ;comparing previous value of series with current value
	VMRS APSR_nzcv, FPSCR ;moving flags
	BNE LOOP              ;if it's not equal then loop
	BEQ LP
LP  VADD.F32 S6,S4,S0
	VDIV.F32 S6,S0,S6
	BX lr
	LTORG
    ENDFUNC
	
	EXPORT __myand
__myand function
   ; AND weights
   MOV r5,r14
   VLDR.F32 S11, =2.0
   VLDR.F32 S12, =2.0
   VLDR.F32 S13, =2.0
   VLDR.F32 S14, =-5.0

   VMUL.F32 S11,S11,S7 ; w1*x1
   VMUL.F32 S12,S12,S8 ; w2*x2
   VMUL.F32 S13,S13,S9 ; w3*x3
   VMUL.F32 S14,S14,S10 ; w4*bias
   VADD.F32 S15,S11,S12 ; adding the products
   VADD.F32 S15,S15,S13 
   VADD.F32 S15,S15,S14 
   VMOV.F32 S2,S15
   
   BL __exponential
   VCVTR.S32.F32 S25,S6
   VMOV.F32 R0,S25
   BL printMsg
   BL printNewLine
   MOV r14,r5
   BX lr
   ;LTORG
   ENDFUNC
   
   EXPORT __myor
__myor function
   ; OR weights
   MOV r5,r14
   VLDR.F32 S11, =2.0
   VLDR.F32 S12, =2.0
   VLDR.F32 S13, =2.0
   VLDR.F32 S14, =-1.0
   
   VMUL.F32 S11,S11,S7 ; w1*x1
   VMUL.F32 S12,S12,S8 ; w2*x2
   VMUL.F32 S13,S13,S9 ; w3*x3
   VMUL.F32 S14,S14,S10 ; w4*bias
   VADD.F32 S15,S11,S12 ; adding products
   VADD.F32 S15,S15,S13 
   VADD.F32 S15,S15,S14 
   VMOV.F32 S2,S15
   
   BL __exponential
   VCVTR.S32.F32 S26,S6
   VMOV.F32 R0,S26
   BL printMsg
   BL printNewLine
   MOV r14,r5
   BX lr
   LTORG
   ENDFUNC
   
   EXPORT __mynand
__mynand function
   ; NAND weights
   MOV r5,r14
   VLDR.F32 S11, =-2.0
   VLDR.F32 S12, =-2.0
   VLDR.F32 S13, =-2.0
   VLDR.F32 S14, =5.0
   
   VMUL.F32 S11,S11,S7 ; w1*x1
   VMUL.F32 S12,S12,S8 ; w2*x2
   VMUL.F32 S13,S13,S9 ; w3*x3
   VMUL.F32 S14,S14,S10 ; w4*bias
   VADD.F32 S15,S11,S12 ; adding products
   VADD.F32 S15,S15,S13 
   VADD.F32 S15,S15,S14 
   VMOV.F32 S2,S15
   
   BL __exponential
   VCVTR.S32.F32 S27,S6
   VMOV.F32 R0,S27
   BL printMsg
   BL printNewLine
   MOV r14,r5
   BX lr
   LTORG
   ENDFUNC
   
   EXPORT __mynor
__mynor function
   ; NOR weights
   MOV r5,r14
   VLDR.F32 S11, =-2.0
   VLDR.F32 S12, =-2.0
   VLDR.F32 S13, =-2.0
   VLDR.F32 S14, =1.0
   
   VMUL.F32 S11,S11,S7 ; w1*x1
   VMUL.F32 S12,S12,S8 ; w2*x2
   VMUL.F32 S13,S13,S9 ; w3*x3
   VMUL.F32 S14,S14,S10 ; w4*bias
   VADD.F32 S15,S11,S12 ; adding products
   VADD.F32 S15,S15,S13 
   VADD.F32 S15,S15,S14 
   VMOV.F32 S2,S15
   
   BL __exponential
   VCVTR.S32.F32 S28,S6
   VMOV.F32 R0,S28
   BL printMsg
   BL printNewLine
   MOV r14,r5
   BX lr
   LTORG
   ENDFUNC
   
   EXPORT __myxor
__myxor function
   ; XOR weights
   MOV r5,r14
   VLDR.F32 S11, =-2.0
   VLDR.F32 S12, =2.0
   VLDR.F32 S13, =-2.0
   VLDR.F32 S14, =-1.0
   
   VMUL.F32 S11,S11,S7 ; w1*x1
   VMUL.F32 S12,S12,S8 ; w2*x2
   VMUL.F32 S13,S13,S9 ; w3*x3
   VMUL.F32 S14,S14,S10 ; w4*bias
   VADD.F32 S15,S11,S12 ; adding products
   VADD.F32 S15,S15,S13 
   VADD.F32 S15,S15,S14 
   VMOV.F32 S2,S15
   
       BL __exponential ;Hidden Layer-1 X1
   VCVTR.S32.F32 S17,S6
   VCVT.F32.S32 S17,S17

   VLDR.F32 S11, =2.0
   VLDR.F32 S12, =-2.0
   VLDR.F32 S13, =-2.0
   VLDR.F32 S14, =-1.0
   
   VMUL.F32 S11,S11,S7 ; w1*x1
   VMUL.F32 S12,S12,S8 ; w2*x2
   VMUL.F32 S13,S13,S9 ; w3*x3
   VMUL.F32 S14,S14,S10 ; w4*bias
   VADD.F32 S15,S11,S12 ; adding products
   VADD.F32 S15,S15,S13 
   VADD.F32 S15,S15,S14 
   VMOV.F32 S2,S15
   
       BL __exponential ;Hidden Layer-1 X2
   VCVTR.S32.F32 S18,S6
   VCVT.F32.S32 S18,S18
   
   VLDR.F32 S11, =-2.0
   VLDR.F32 S12, =-2.0
   VLDR.F32 S13, =2.0
   VLDR.F32 S14, =-1.0
   
   VMUL.F32 S11,S11,S7 ; w1*x1
   VMUL.F32 S12,S12,S8 ; w2*x2
   VMUL.F32 S13,S13,S9 ; w3*x3
   VMUL.F32 S14,S14,S10 ; w4*bias
   VADD.F32 S15,S11,S12 ; adding products
   VADD.F32 S15,S15,S13 
   VADD.F32 S15,S15,S14 
   VMOV.F32 S2,S15
   
       BL __exponential ;Hidden Layer-1 X3
   VCVTR.S32.F32 S19,S6
   VCVT.F32.S32 S19,S19
   
   VLDR.F32 S11, =2.0
   VLDR.F32 S12, =2.0
   VLDR.F32 S13, =2.0
   VLDR.F32 S14, =-5.0
   VMUL.F32 S11,S11,S7 ; w1*x1
   VMUL.F32 S12,S12,S8 ; w2*x2
   VMUL.F32 S13,S13,S9 ; w3*x3
   VMUL.F32 S14,S14,S10 ; w4*bias
   VADD.F32 S15,S11,S12 ; adding products
   VADD.F32 S15,S15,S13 
   VADD.F32 S15,S15,S14 
   VMOV.F32 S2,S15
   
       BL __exponential ;Hidden Layer-1 X4
   VCVTR.S32.F32 S20,S6
   VCVT.F32.S32 S20,S20
   
   VLDR.F32 S11, =2.0
   VLDR.F32 S12, =2.0
   VLDR.F32 S13, =2.0
   VLDR.F32 S16, =2.0
   VLDR.F32 S14, =-1.0
   
   VMUL.F32 S11,S11,S17 ; w1*x1
   VMUL.F32 S12,S12,S18 ; w2*x2
   VMUL.F32 S13,S13,S19 ; w3*x3
   VMUL.F32 S16,S16,S20 ; w3*x3
   VMUL.F32 S14,S14,S10 ; w5*bias
   VADD.F32 S15,S11,S12 ; adding products
   VADD.F32 S15,S15,S13 
   VADD.F32 S15,S15,S16 
   VADD.F32 S15,S15,S14 
   VMOV.F32 S2,S15
   
       BL __exponential ;Hidden Layer-2 Y1 output
   VCVTR.S32.F32 S29,S6
   VMOV.F32 R0,S29
   BL printMsg
   BL printNewLine
   MOV r14,r5
   BX lr
   LTORG
   ENDFUNC
   
   EXPORT __myxnor
__myxnor function
   ; XNOR weights
   MOV r5,r14
   VLDR.F32 S11, =2.0
   VLDR.F32 S12, =-2.0
   VLDR.F32 S13, =2.0
   VLDR.F32 S14, =1.0
   
   VMUL.F32 S11,S11,S7 ; w1*x1
   VMUL.F32 S12,S12,S8 ; w2*x2
   VMUL.F32 S13,S13,S9 ; w3*x3
   VMUL.F32 S14,S14,S10 ; w4*bias
   VADD.F32 S15,S11,S12 ; adding products
   VADD.F32 S15,S15,S13 
   VADD.F32 S15,S15,S14 
   VMOV.F32 S2,S15
   
       BL __exponential ;Hidden Layer-1 X1
   VCVTR.S32.F32 S17,S6
   VCVT.F32.S32 S17,S17
   
   VLDR.F32 S11, =-2.0
   VLDR.F32 S12, =2.0
   VLDR.F32 S13, =2.0
   VLDR.F32 S14, =1.0
   
   VMUL.F32 S11,S11,S7 ; w1*x1
   VMUL.F32 S12,S12,S8 ; w2*x2
   VMUL.F32 S13,S13,S9 ; w3*x3
   VMUL.F32 S14,S14,S10 ; w4*bias
   
   VADD.F32 S15,S11,S12 ; adding products
   VADD.F32 S15,S15,S13 
   VADD.F32 S15,S15,S14 
   VMOV.F32 S2,S15
   
       BL __exponential ;Hidden Layer-1 X2
   VCVTR.S32.F32 S18,S6
   VCVT.F32.S32 S18,S18
   
   VLDR.F32 S11, =2.0
   VLDR.F32 S12, =2.0
   VLDR.F32 S13, =-2.0
   VLDR.F32 S14, =1.0
   
   VMUL.F32 S11,S11,S7 ; w1*x1
   VMUL.F32 S12,S12,S8 ; w2*x2
   VMUL.F32 S13,S13,S9 ; w3*x3
   VMUL.F32 S14,S14,S10 ; w4*bias
   
   VADD.F32 S15,S11,S12 ; adding products
   VADD.F32 S15,S15,S13 
   VADD.F32 S15,S15,S14 
   VMOV.F32 S2,S15
   
       BL __exponential ;Hidden Layer-1 X3
   VCVTR.S32.F32 S19,S6
   VCVT.F32.S32 S19,S19
   
   VLDR.F32 S11, =-2.0
   VLDR.F32 S12, =-2.0
   VLDR.F32 S13, =-2.0
   VLDR.F32 S14, =5.0
   
   VMUL.F32 S11,S11,S7 ; w1*x1
   VMUL.F32 S12,S12,S8 ; w2*x2
   VMUL.F32 S13,S13,S9 ; w3*x3
   VMUL.F32 S14,S14,S10 ; w4*bias
   
   VADD.F32 S15,S11,S12 ; adding products
   VADD.F32 S15,S15,S13 
   VADD.F32 S15,S15,S14 
   VMOV.F32 S2,S15
   
       BL __exponential ;Hidden Layer-1 X4
   VCVTR.S32.F32 S20,S6
   VCVT.F32.S32 S20,S20
   
   VLDR.F32 S11, =2.0
   VLDR.F32 S12, =2.0
   VLDR.F32 S13, =2.0
   VLDR.F32 S16, =2.0
   VLDR.F32 S14, =-7.0
   
   VMUL.F32 S11,S11,S17 ; w1*x1
   VMUL.F32 S12,S12,S18 ; w2*x2
   VMUL.F32 S13,S13,S19 ; w3*x3
   VMUL.F32 S16,S16,S20 ; w3*x3
   VMUL.F32 S14,S14,S10 ; w5*bias
   
   VLDR.F32 S15, =0.0
   VADD.F32 S15,S15,S14 ; adding products
   VADD.F32 S15,S15,S11 
   VADD.F32 S15,S15,S12 
   VADD.F32 S15,S15,S13 
   VADD.F32 S15,S15,S16 
   VMOV.F32 S2,S15
   
       BL __exponential ;Hidden Layer-2 Y1 output
   VCVTR.S32.F32 S30,S6
   VMOV.F32 R0,S30
   BL printMsg
   BL printNewLine
   MOV r14,r5
   BX lr
   ;LTORG
   ENDFUNC
   
   EXPORT __mynot
__mynot function
   ;NOT weight - S11,S14
   MOV r5,r14
   VLDR.F32 S11, =-2.0
   VLDR.F32 S14, =1.0
   
   VMUL.F32 S11,S11,S7 ; w1*x1
   VMUL.F32 S14,S14,S10 ; w4*bias
   VADD.F32 S15,S11,S14 ; adding products
   VMOV.F32 S2,S15
   
   BL __exponential 
   VCVTR.S32.F32 S31,S6
   VMOV.F32 R0,S31
   BL printMsg
   BL printNewLine
   MOV r14,r5
   BX lr
   LTORG
   ENDFUNC

	export __main 
	ENTRY 
__main  function  
   ; outputs S25-AND, S26-OR, S27-NAND, S28-NOR, S29-XOR, S30-XNOR, S31-NOT
   ; using S7,S8,S9 for inputs
   VLDR.F32 S7, =0.0 ; input1
   VCVTR.S32.F32 S22,S7
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S8, =0.0 ; input2
   VCVTR.S32.F32 S22,S8
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S9, =0.0 ; input3
   VCVTR.S32.F32 S22,S9
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S10, =1.0 ; bias
   BL __myand
   
   VLDR.F32 S7, =0.0 ; input1
   VCVTR.S32.F32 S22,S7
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S8, =0.0 ; input2
   VCVTR.S32.F32 S22,S8
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S9, =1.0 ; input3
   VCVTR.S32.F32 S22,S9
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S10, =1.0 ; bias
   BL __myand
   ;BL printNewLine
   
   VLDR.F32 S7, =0.0 ; input1
   VCVTR.S32.F32 S22,S7
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S8, =1.0 ; input2
   VCVTR.S32.F32 S22,S8
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S9, =0.0 ; input3
   VCVTR.S32.F32 S22,S9
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S10, =1.0 ; bias
   BL __myand
   ;BL printNewLine
   
   VLDR.F32 S7, =1.0 ; input1
   VCVTR.S32.F32 S22,S7
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S8, =0.0 ; input2
   VCVTR.S32.F32 S22,S8
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S9, =0.0 ; input3
   VCVTR.S32.F32 S22,S9
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S10, =1.0 ; bias
   BL __myand
   ;BL printNewLine
   
   VLDR.F32 S7, =0.0 ; input1
   VCVTR.S32.F32 S22,S7
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S8, =1.0 ; input2
   VCVTR.S32.F32 S22,S8
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S9, =1.0 ; input3
   VCVTR.S32.F32 S22,S9
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S10, =1.0 ; bias
   BL __myand
   
   VLDR.F32 S7, =1.0 ; input1
   VCVTR.S32.F32 S22,S7
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S8, =1.0 ; input2
   VCVTR.S32.F32 S22,S8
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S9, =0.0 ; input3
   VCVTR.S32.F32 S22,S9
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S10, =1.0 ; bias
   BL __myand
   
   VLDR.F32 S7, =1.0 ; input1
   VCVTR.S32.F32 S22,S7
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S8, =0.0 ; input2
   VCVTR.S32.F32 S22,S8
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S9, =1.0 ; input3
   VCVTR.S32.F32 S22,S9
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S10, =1.0 ; bias
   BL __myand
   
   VLDR.F32 S7, =1.0 ; input1
   VCVTR.S32.F32 S22,S7
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S8, =1.0 ; input2
   VCVTR.S32.F32 S22,S8
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S9, =1.0 ; input3
   VCVTR.S32.F32 S22,S9
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S10, =1.0 ; bias
   BL __myand
   BL printNewLine
   

   VLDR.F32 S7, =0.0 ; input1
   VCVTR.S32.F32 S22,S7
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S8, =0.0 ; input2
   VCVTR.S32.F32 S22,S8
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S9, =0.0 ; input3
   VCVTR.S32.F32 S22,S9
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S10, =1.0 ; bias
   BL __myor
   
   VLDR.F32 S7, =0.0 ; input1
   VCVTR.S32.F32 S22,S7
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S8, =0.0 ; input2
   VCVTR.S32.F32 S22,S8
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S9, =1.0 ; input3
   VCVTR.S32.F32 S22,S9
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S10, =1.0 ; bias
   BL __myor
   ;BL printNewLine
   
   VLDR.F32 S7, =0.0 ; input1
   VCVTR.S32.F32 S22,S7
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S8, =1.0 ; input2
   VCVTR.S32.F32 S22,S8
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S9, =0.0 ; input3
   VCVTR.S32.F32 S22,S9
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S10, =1.0 ; bias
   BL __myor
   ;BL printNewLine
   
   VLDR.F32 S7, =1.0 ; input1
   VCVTR.S32.F32 S22,S7
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S8, =0.0 ; input2
   VCVTR.S32.F32 S22,S8
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S9, =0.0 ; input3
   VCVTR.S32.F32 S22,S9
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S10, =1.0 ; bias
   BL __myor
   ;BL printNewLine
   
   VLDR.F32 S7, =0.0 ; input1
   VCVTR.S32.F32 S22,S7
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S8, =1.0 ; input2
   VCVTR.S32.F32 S22,S8
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S9, =1.0 ; input3
   VCVTR.S32.F32 S22,S9
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S10, =1.0 ; bias
   BL __myor
   
   VLDR.F32 S7, =1.0 ; input1
   VCVTR.S32.F32 S22,S7
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S8, =1.0 ; input2
   VCVTR.S32.F32 S22,S8
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S9, =0.0 ; input3
   VCVTR.S32.F32 S22,S9
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S10, =1.0 ; bias
   BL __myor
   
   VLDR.F32 S7, =1.0 ; input1
   VCVTR.S32.F32 S22,S7
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S8, =0.0 ; input2
   VCVTR.S32.F32 S22,S8
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S9, =1.0 ; input3
   VCVTR.S32.F32 S22,S9
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S10, =1.0 ; bias
   BL __myor
   
   VLDR.F32 S7, =1.0 ; input1
   VCVTR.S32.F32 S22,S7
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S8, =1.0 ; input2
   VCVTR.S32.F32 S22,S8
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S9, =1.0 ; input3
   VCVTR.S32.F32 S22,S9
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S10, =1.0 ; bias
   BL __myor
   BL printNewLine
   
   
   
   VLDR.F32 S7, =0.0 ; input1
   VCVTR.S32.F32 S22,S7
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S8, =0.0 ; input2
   VCVTR.S32.F32 S22,S8
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S9, =0.0 ; input3
   VCVTR.S32.F32 S22,S9
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S10, =1.0 ; bias
   BL __mynand
   
   VLDR.F32 S7, =0.0 ; input1
   VCVTR.S32.F32 S22,S7
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S8, =0.0 ; input2
   VCVTR.S32.F32 S22,S8
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S9, =1.0 ; input3
   VCVTR.S32.F32 S22,S9
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S10, =1.0 ; bias
   BL __mynand
   ;BL printNewLine
   
   VLDR.F32 S7, =0.0 ; input1
   VCVTR.S32.F32 S22,S7
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S8, =1.0 ; input2
   VCVTR.S32.F32 S22,S8
   VMOV.F32 R0,S22
   BL printMsg
   LTORG
   VLDR.F32 S9, =0.0 ; input3
   VCVTR.S32.F32 S22,S9
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S10, =1.0 ; bias
   BL __mynand
   ;BL printNewLine
   
   VLDR.F32 S7, =1.0 ; input1
   VCVTR.S32.F32 S22,S7
   VMOV.F32 R0,S22
   BL printMsg
   LTORG
   VLDR.F32 S8, =0.0 ; input2
   VCVTR.S32.F32 S22,S8
   VMOV.F32 R0,S22
   BL printMsg
   LTORG
   VLDR.F32 S9, =0.0 ; input3
   VCVTR.S32.F32 S22,S9
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S10, =1.0 ; bias
   BL __mynand
   LTORG
   ;BL printNewLine
   
   VLDR.F32 S7, =0.0 ; input1
   VCVTR.S32.F32 S22,S7
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S8, =1.0 ; input2
   VCVTR.S32.F32 S22,S8
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S9, =1.0 ; input3
   VCVTR.S32.F32 S22,S9
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S10, =1.0 ; bias
   BL __mynand
   
   VLDR.F32 S7, =1.0 ; input1
   VCVTR.S32.F32 S22,S7
   VMOV.F32 R0,S22
   BL printMsg
   LTORG
   VLDR.F32 S8, =1.0 ; input2
   VCVTR.S32.F32 S22,S8
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S9, =0.0 ; input3
   VCVTR.S32.F32 S22,S9
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S10, =1.0 ; bias
   BL __mynand
   LTORG
   
   VLDR.F32 S7, =1.0 ; input1
   VCVTR.S32.F32 S22,S7
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S8, =0.0 ; input2
   VCVTR.S32.F32 S22,S8
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S9, =1.0 ; input3
   VCVTR.S32.F32 S22,S9
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S10, =1.0 ; bias
   BL __mynand
   
   VLDR.F32 S7, =1.0 ; input1
   VCVTR.S32.F32 S22,S7
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S8, =1.0 ; input2
   VCVTR.S32.F32 S22,S8
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S9, =1.0 ; input3
   VCVTR.S32.F32 S22,S9
   VMOV.F32 R0,S22
   BL printMsg
   LTORG
   VLDR.F32 S10, =1.0 ; bias
   BL __mynand
   BL printNewLine
   LTORG
   
   
   
   VLDR.F32 S7, =0.0 ; input1
   VCVTR.S32.F32 S22,S7
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S8, =0.0 ; input2
   VCVTR.S32.F32 S22,S8
   VMOV.F32 R0,S22
   BL printMsg
   LTORG
   VLDR.F32 S9, =0.0 ; input3
   VCVTR.S32.F32 S22,S9
   VMOV.F32 R0,S22
   BL printMsg
   LTORG
   VLDR.F32 S10, =1.0 ; bias
   BL __mynor
   
   VLDR.F32 S7, =0.0 ; input1
   VCVTR.S32.F32 S22,S7
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S8, =0.0 ; input2
   VCVTR.S32.F32 S22,S8
   VMOV.F32 R0,S22
   BL printMsg
   LTORG
   VLDR.F32 S9, =1.0 ; input3
   VCVTR.S32.F32 S22,S9
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S10, =1.0 ; bias
   BL __mynor
   LTORG
   ;BL printNewLine
   
   VLDR.F32 S7, =0.0 ; input1
   VCVTR.S32.F32 S22,S7
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S8, =1.0 ; input2
   VCVTR.S32.F32 S22,S8
   VMOV.F32 R0,S22
   BL printMsg
   LTORG
   VLDR.F32 S9, =0.0 ; input3
   VCVTR.S32.F32 S22,S9
   VMOV.F32 R0,S22
   BL printMsg
   LTORG
   VLDR.F32 S10, =1.0 ; bias
   BL __mynor
   ;BL printNewLine
   
   VLDR.F32 S7, =1.0 ; input1
   VCVTR.S32.F32 S22,S7
   VMOV.F32 R0,S22
   BL printMsg
   LTORG
   VLDR.F32 S8, =0.0 ; input2
   VCVTR.S32.F32 S22,S8
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S9, =0.0 ; input3
   VCVTR.S32.F32 S22,S9
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S10, =1.0 ; bias
   BL __mynor
   ;BL printNewLine
   
   VLDR.F32 S7, =0.0 ; input1
   VCVTR.S32.F32 S22,S7
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S8, =1.0 ; input2
   VCVTR.S32.F32 S22,S8
   VMOV.F32 R0,S22
   BL printMsg
   LTORG
   VLDR.F32 S9, =1.0 ; input3
   VCVTR.S32.F32 S22,S9
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S10, =1.0 ; bias
   BL __mynor
   
   VLDR.F32 S7, =1.0 ; input1
   VCVTR.S32.F32 S22,S7
   VMOV.F32 R0,S22
   BL printMsg
   LTORG
   VLDR.F32 S8, =1.0 ; input2
   VCVTR.S32.F32 S22,S8
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S9, =0.0 ; input3
   VCVTR.S32.F32 S22,S9
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S10, =1.0 ; bias
   BL __mynor
   
   VLDR.F32 S7, =1.0 ; input1
   VCVTR.S32.F32 S22,S7
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S8, =0.0 ; input2
   VCVTR.S32.F32 S22,S8
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S9, =1.0 ; input3
   VCVTR.S32.F32 S22,S9
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S10, =1.0 ; bias
   BL __mynor
   
   VLDR.F32 S7, =1.0 ; input1
   VCVTR.S32.F32 S22,S7
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S8, =1.0 ; input2
   VCVTR.S32.F32 S22,S8
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S9, =1.0 ; input3
   VCVTR.S32.F32 S22,S9
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S10, =1.0 ; bias
   BL __mynor
   BL printNewLine
   
   
   
   VLDR.F32 S7, =0.0 ; input1
   VCVTR.S32.F32 S22,S7
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S8, =0.0 ; input2
   VCVTR.S32.F32 S22,S8
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S9, =0.0 ; input3
   VCVTR.S32.F32 S22,S9
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S10, =1.0 ; bias
   BL __myxor
   
   VLDR.F32 S7, =0.0 ; input1
   VCVTR.S32.F32 S22,S7
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S8, =0.0 ; input2
   VCVTR.S32.F32 S22,S8
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S9, =1.0 ; input3
   VCVTR.S32.F32 S22,S9
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S10, =1.0 ; bias
   BL __myxor
   ;BL printNewLine
   
   VLDR.F32 S7, =0.0 ; input1
   VCVTR.S32.F32 S22,S7
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S8, =1.0 ; input2
   VCVTR.S32.F32 S22,S8
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S9, =0.0 ; input3
   VCVTR.S32.F32 S22,S9
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S10, =1.0 ; bias
   BL __myxor
   ;BL printNewLine
   
   VLDR.F32 S7, =1.0 ; input1
   VCVTR.S32.F32 S22,S7
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S8, =0.0 ; input2
   VCVTR.S32.F32 S22,S8
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S9, =0.0 ; input3
   VCVTR.S32.F32 S22,S9
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S10, =1.0 ; bias
   BL __myxor
   ;BL printNewLine
   
   VLDR.F32 S7, =0.0 ; input1
   VCVTR.S32.F32 S22,S7
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S8, =1.0 ; input2
   VCVTR.S32.F32 S22,S8
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S9, =1.0 ; input3
   VCVTR.S32.F32 S22,S9
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S10, =1.0 ; bias
   BL __myxor
   
   VLDR.F32 S7, =1.0 ; input1
   VCVTR.S32.F32 S22,S7
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S8, =1.0 ; input2
   VCVTR.S32.F32 S22,S8
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S9, =0.0 ; input3
   VCVTR.S32.F32 S22,S9
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S10, =1.0 ; bias
   BL __myxor
   
   VLDR.F32 S7, =1.0 ; input1
   VCVTR.S32.F32 S22,S7
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S8, =0.0 ; input2
   VCVTR.S32.F32 S22,S8
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S9, =1.0 ; input3
   VCVTR.S32.F32 S22,S9
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S10, =1.0 ; bias
   BL __myxor
   
   VLDR.F32 S7, =1.0 ; input1
   VCVTR.S32.F32 S22,S7
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S8, =1.0 ; input2
   VCVTR.S32.F32 S22,S8
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S9, =1.0 ; input3
   VCVTR.S32.F32 S22,S9
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S10, =1.0 ; bias
   BL __myxor
   BL printNewLine
   
   
   
   VLDR.F32 S7, =0.0 ; input1
   VCVTR.S32.F32 S22,S7
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S8, =0.0 ; input2
   VCVTR.S32.F32 S22,S8
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S9, =0.0 ; input3
   VCVTR.S32.F32 S22,S9
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S10, =1.0 ; bias
   BL __myxnor
   
   VLDR.F32 S7, =0.0 ; input1
   VCVTR.S32.F32 S22,S7
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S8, =0.0 ; input2
   VCVTR.S32.F32 S22,S8
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S9, =1.0 ; input3
   VCVTR.S32.F32 S22,S9
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S10, =1.0 ; bias
   BL __myxnor
   ;BL printNewLine
   
   VLDR.F32 S7, =0.0 ; input1
   VCVTR.S32.F32 S22,S7
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S8, =1.0 ; input2
   VCVTR.S32.F32 S22,S8
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S9, =0.0 ; input3
   VCVTR.S32.F32 S22,S9
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S10, =1.0 ; bias
   BL __myxnor
   ;BL printNewLine
   
   VLDR.F32 S7, =1.0 ; input1
   VCVTR.S32.F32 S22,S7
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S8, =0.0 ; input2
   VCVTR.S32.F32 S22,S8
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S9, =0.0 ; input3
   VCVTR.S32.F32 S22,S9
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S10, =1.0 ; bias
   BL __myxnor
   ;BL printNewLine
   
   VLDR.F32 S7, =0.0 ; input1
   VCVTR.S32.F32 S22,S7
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S8, =1.0 ; input2
   VCVTR.S32.F32 S22,S8
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S9, =1.0 ; input3
   VCVTR.S32.F32 S22,S9
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S10, =1.0 ; bias
   BL __myxnor
   
   VLDR.F32 S7, =1.0 ; input1
   VCVTR.S32.F32 S22,S7
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S8, =1.0 ; input2
   VCVTR.S32.F32 S22,S8
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S9, =0.0 ; input3
   VCVTR.S32.F32 S22,S9
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S10, =1.0 ; bias
   BL __myxnor
   
   VLDR.F32 S7, =1.0 ; input1
   VCVTR.S32.F32 S22,S7
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S8, =0.0 ; input2
   VCVTR.S32.F32 S22,S8
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S9, =1.0 ; input3
   VCVTR.S32.F32 S22,S9
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S10, =1.0 ; bias
   BL __myxnor
   
   VLDR.F32 S7, =1.0 ; input1
   VCVTR.S32.F32 S22,S7
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S8, =1.0 ; input2
   VCVTR.S32.F32 S22,S8
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S9, =1.0 ; input3
   VCVTR.S32.F32 S22,S9
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S10, =1.0 ; bias
   BL __myxnor
   BL printNewLine
   
   
   
   VLDR.F32 S7, =0.0 ; input1
   VCVTR.S32.F32 S22,S7
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S10, =1.0 ; bias
   BL __mynot
   
   VLDR.F32 S7, =1.0 ; input1
   VCVTR.S32.F32 S22,S7
   VMOV.F32 R0,S22
   BL printMsg
   VLDR.F32 S10, =1.0 ; bias
   BL __mynot
   
   ;output format
   ;1st block of truth table- AND
   ;2nd block of truth table- OR
   ;3rd block of truth table- NAND
   ;4th block of truth table- NOR
   ;5th block of truth table- XOR
   ;6th block of truth table- XNOR
   ;7th block of truth table- NOT
   ;first three columns are inputs and fourth column is ouput for AND,OR,NAND,NOT,XOR,XNOR
   ;first column is input and second column is output for NOT
fullstop    B  fullstop ; stop program    
     endfunc
     end 