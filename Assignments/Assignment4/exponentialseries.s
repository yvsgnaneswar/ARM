	 THUMB
     AREA     exponential, CODE, READONLY
     EXPORT __main
     ENTRY 
__main    FUNCTION 
        MOV R1,#1         ;i
        VLDR.F32 S0,=1.0  ;required value 
        VLDR.F32 S1,=1.0  ;temp
        VLDR.F32 S2,=2.0  ;x value
LOOP      VMUL.F32 S1,S1,S2   ;intialising series
        VMOV.F32 S5,R1        ;moving i to S5 
        VCVT.F32.U32 S5, S5   ;convert the bit to unsigned
        VDIV.F32 S1,S1,S5     ;dividing by i and storing back
		VMOV.F32 S6,S0        ;moving S6 to S0
        VADD.F32 S0,S0,S1     ;adding current term to series
		ADD R1,R1,#1;         ;incrementing i
		VCMP.F32 S6,S0        ;comparing previous value of series with current value
	    VMRS APSR_nzcv, FPSCR ;moving flags
	    BNE LOOP              ;if it's not equal then loop
stop B stop
     ENDFUNC
     END 