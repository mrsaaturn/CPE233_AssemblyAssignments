;=======================================================
;==	CPE 233 - Hummel
;== Software Assigment 6
;== 	Problem 2
;== Engineers:	Albert Panuco
;==				Cate Thornbury
;==
;==== Description ===========================
; this program stores values into the stack,
; and then outputs them to port 42 in the 
; order that they were input


;-- PORT NAMES
.EQU OUT_PORT = 0x42 ; Out port 
.EQU IN_PORT = 0X09 ; in port
;--------------------
;-- ALIASES
; R0 is the register to which values are saved
; R1 is the register that keeps the count of
	; the number of values input to the stack
; R3 is the register that determines what value
	;of the scratch memory is read in

.CSEG
.ORG 0X20 ; code starts here

INPUT: 
	IN R0, IN_PORT 
	PUSH R0 ; put the value of R0 to the memory
	ADD R1, 0X01 ; increment the count
	CMP R0, 0XFF ; compare the input val to 0XFF
	BRNE INPUT

MOV R3, 0XFF ; initialize R3 to 0XFF

OUTTIE:
	LD  R2,(R3) ; load the value that's in 0XFF into R2
	OUT R2, out_port ; output R2
	SUB R3, 0X01 ; decrement the value to be read in
	SUB R1, 0X01 ; decrement counter
	CMP R1, 0X00 ; make sure it doesn't have an underflow
	BRNE OUTTIE

	