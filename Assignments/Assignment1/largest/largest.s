	 THUMB
     AREA     largest, CODE, READONLY
     EXPORT __main
     ENTRY 
__main  FUNCTION		 
    MOV R0,#19;input 1
    MOV R1,#15;input 2
	MOV R2,#14;input 3
loop CMP R0,R1;comparing first two numbers
	 MOVGT R1,R0;if first>second copying first to R1
	 CMP R1,R2;comparing gratest of first two and third
	 MOVGT R2,R1;if that is > third copying that to R2
	 B stop     ;OUTPUT in R2
stop B stop
     ENDFUNC
     END  