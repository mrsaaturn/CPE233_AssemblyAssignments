;=======================================================
;==	CPE 233 - Hummel
;== Software Assigment 6
;== 	Problem 1
;== Engineers:	Albert Panuco
;==				Cate Thornbury
;==
;==== Description ===========================
; This program reads in an input sequence from port 0X9A, 
; and then inputs them into the stack until the input read
; is 0XFF, all while incrementing a counter. Then, it reads 
; off the top entry of the stack to the output port 0X42. 


;-- PORT NAMES
.EQU OUT_PORT = 0x42 ; Out port 
.EQU IN_PORT = 0X09 ; in port
;--------------------
;-- ALIASES
; R0 is the register that the input values are placed in
; R1 is the counter for the number if inputs in the stack
; R5 is the register that takes the value that was popped
		; off the stack

.CSEG
.ORG 0X20 ; code starts here

INPUT: 
; Loop inputs values into stack until 0xFF is input
	IN R0, IN_PORT 
	PUSH R0			
	ADD R1, 0X01 	; Stores num of inputs in stack
	CMP R0, 0XFF 	; Check if input is 0xFF
	BRNE INPUT

POPPIN:
; Loop outputs values in stack in reverse order 
	POP R5
	OUT R5, 0X42	
	ADD R2, 0X01 	; used as incremental counter
	CMP R1, R2	 	;
	BRNE POPPIN
