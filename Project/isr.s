
	GET reg_stm32f407xx.inc

	AREA	ISRCODE, CODE, READONLY
		
SysTick_Handler PROC
	EXPORT  SysTick_Handler
	
	mov r2, #0;
	STR r2, [r0];
	STR r2, [r0,#0x08];
	ldr r3, =0x200002f0;
	stm r3, {r4-r11};
	pop {r4-r11}; proc A's values
	ldr r3, =0x200000f0; //to temporarily store a's values
	stm r3, {r4-r11}; //storing
	
	ldr r3, =0x20000000; //to get b's values
	ldm r3, {r4-r11}; //getting them
	push {r4-r11}; //pushing onto stack.
	
	ldr r3, =0x20000030; //to get c's values
	ldm r3, {r4-r11}; //getting them
	ldr r3, =0x20000000;
	stm r3, {r4-r11};
	
	ldr r3, =0x20000060; //to get d's values
	ldm r3, {r4-r11}; //getting them
	ldr r3, =0x20000030;
	stm r3, {r4-r11};
	
	ldr r3, =0x200000f0; //to get a's values
	ldm r3, {r4-r11}; //getting them
	ldr r3, =0x20000060;
	stm r3, {r4-r11};
	
	;to handle registers r4-r11
	
	ldr r3, =0x20000200; //to get b reg values
	ldm r3, {r4-r11}; //getting them
	ldr r3, =0x200002d0; //storing them temporarily
	stm r3, {r4-r11};
	
	ldr r3, =0x20000230; //to get c's values
	ldm r3, {r4-r11}; //getting them
	ldr r3, =0x20000200;
	stm r3, {r4-r11};
	
	ldr r3, =0x20000260; //to get d's values
	ldm r3, {r4-r11}; //getting them
	ldr r3, =0x20000230;
	stm r3, {r4-r11};
	
	ldr r3, =0x200002f0; //to get a's values
	ldm r3, {r4-r11}; //getting them
	ldr r3, =0x20000260;
	stm r3, {r4-r11};
	
	ldr r3, =0x200002d0; //to get c's values
	ldm r3, {r4-r11}; 
	
	MOV r3, #7;
	STR r3, [r0]
	BX LR

	ENDP
		
	ALIGN 4
LEDs_ON		EQU	0x0000F000
LEDs_OFF	EQU	0xF0000000
	
	
	END
