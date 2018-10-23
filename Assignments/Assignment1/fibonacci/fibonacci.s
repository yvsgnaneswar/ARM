	 THUMB
     AREA     fibonacci, CODE, READONLY
     EXPORT __main
     ENTRY 
__main  FUNCTION		 
    MOV R0,#0;Initial number 0 
    MOV R1,#1;Initial number 1 
    MOV R3,#4;Upto What Number you want the series(req) 
    MOV R4,#0;every element in series will be stored in r4 
    MOV R5,#0x20000000;The entire series is written from this memory location 
	MOV R6,#0;fibonacci counter
    ADD R4,R0,R1;val = t0+t1 
loop1 CMP R3, R6 ; comparing counter with input
    BGT LOOP;if input>counter goto loop 
    B stop;Else goto end  
LOOP STR R4,[R5],#1;Storing the series into memory 
    MOV R0,R1;t1=t0; 
    MOV R1,R4;t0=val 
    ADD R4,R0,R1;val = t0 + t1 
	ADD R6,R6,#1;incrementing counter
    B loop1;Loop untill val >= req 
stop    B stop 
     ENDFUNC
     END 