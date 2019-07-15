	GET reg_stm32f407xx.inc

; Export functions so they can be called from other file

	EXPORT SystemInit
	EXPORT __main

	AREA	MYCODE, CODE, READONLY
		
SystemInit FUNCTION

	; Enable GPIO clock
	LDR		R1, =RCC_AHB1ENR	;Pseudo-load address in R1
	LDR		R0, [R1]			;Copy contents at address in R1 to R0
	ORR.W 	R0, #0x08			;Bitwise OR entire word in R0, result in R0
	STR		R0, [R1]			;Store R0 contents to address in R1

	; Set mode as output
	LDR		R1, =GPIOD_MODER	;Two bits per pin so bits 24 to 31 control pins 12 to 15
	LDR		R0, [R1]			
	ORR.W 	R0, #0x55000000		;Mode bits set to '01' makes the pin mode as output
	AND.W	R0, #0x55FFFFFF		;OR and AND both operations reqd for 2 bits
	STR		R0, [R1]

	; Set type as push-pull	(Default)
	LDR		R1, =GPIOD_OTYPER	;Type bit '0' configures pin for push-pull
	LDR		R0, [R1]
	AND.W 	R0, #0xFFFF0FFF	
	STR		R0, [R1]
	
	; Set Speed slow
	LDR		R1, =GPIOD_OSPEEDR	;Two bits per pin so bits 24 to 31 control pins 12 to 15
	LDR		R0, [R1]
	AND.W 	R0, #0x00FFFFFF		;Speed bits set to '00' configures pin for slow speed
	STR		R0, [R1]	
	
	; Set pull-up
	LDR		R1, =GPIOD_PUPDR	;Two bits per pin so bits 24 to 31 control pins 12 to 15
	LDR		R0, [R1]
	AND.W	R0, #0x00FFFFFF		;Clear bits to disable pullup/pulldown
	STR		R0, [R1]

	LDR		R1, =SYSTICK_RELOADR
	LDR		R2,	=SYST_RELOAD_500MS
	STR		R2, [R1]

	MOV	R7, #0x00
	
	LDR		R1, =SYSTICK_CONTROLR
	LDR 	R0, [R1]
	ORR.W	R0, #ENABLE_SYSTICK
	STR		R0, [R1]

	BX		LR					;Return from function
	
	ENDFUNC
	
task2 function
	mov r5,#1;
loop B loop
	bx lr
	endfunc
	
task1 function
	mov r6,#2;
loop2 B loop2
	BX lr;
	endfunc
	
task3 function
	mov r7,#3;
loop3 B loop3
	BX lr;
	endfunc
	
task4 function
	mov r8,#4;
loop4 B loop4
	BX lr;
	endfunc
	
	EXPORT __main
    ENTRY
__main FUNCTION
	
	LDR R0, =0xE000E010
	LDR R1, =0x0000001f
	LDR R2, =0x00000000
	LDR R3, =0x00000007
	LDR R7, =0x00000007
	LDR R5, =0x0F01A045
	
	ldr r11, =task2; process b's address
	LDR r10, =0x20000000;
	mov r14, r11;
	mov r12, r14;
	stm r10, {r0-r3,r11,r12,r14};
	
	ldr r11, =task3; process b's address
	LDR r10, =0x20000030;
	mov r14, r11;
	mov r12, r14;
	stm r10, {r0-r3,r11,r12,r14};
	
	ldr r11, =task4; process b's address
	LDR r10, =0x20000060;
	mov r14, r11;
	mov r12, r14;
	stm r10, {r0-r3,r11,r12,r14};
	
	STR R1, [R0,#0x04] ;reload RVR with 5
	STR R2, [R0,#0x08] ;clear CVR with 0
	STR R3, [R0,#0x00] ;CSR setting with enable ON
	B task1
;loop3 LSL r5,#1
;	 B loop3
	ENDFUNC
	
	ALIGN 4
SYST_RELOAD_500MS	EQU 0x007A1200
ENABLE_SYSTICK		EQU	0x07		
	
	END
