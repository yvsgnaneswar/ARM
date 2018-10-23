	 THUMB
     AREA     gcd, CODE, READONLY
     EXPORT __main
     ENTRY 
__main  FUNCTION		 
    MOV R0,#12;input a
    MOV R1,#54;input b
loop CMP R0,R1;comparing two inputs
	SUBGT R0,R0,R1;if a>b then a=a-b
	SUBLT R1,R1,R0;if a<b then b=b-a
	BNE loop;if a!=b then loop
	B stop
stop B stop
     ENDFUNC
     END 