;=======================================================
;==	CPE 233 - Hummel
;== Software Assigment 7
;== 	Problem 1
;== Engineers:	Albert Panuco
;==				Cate Thornbury
;==
;==== Notes on Functionality ===========================
; This program mainly utilizes a subroutine that divides 
; a value by 10, and then use that new subroutine to 
; take an 8 bit unsigned number and turn it to BCD, with 
; each decimal value that goes to the ones, tens, and 
; hundreds place getting its own output port. 

;-- PORT NAMES
.EQU IN_PORT = 0x9A ; In port for 8-bit unsigned
.EQU OUT_HUNDO = 0x41 ; out port for the hundreds
.EQU OUT_TENS = 0x42 ; Out port for tens place
.EQU OUT_ONES = 0x43 ; Out port for ones
;--------------------
;-- ALIASES
; REMAINDER = R0 ; Albeit confusing to call the original number remainder,
                    ; eventually, via subtraction, it becomes the remainder.
; DIVISOR  = 0X10
; QUOTIENT = R1


.CSEG
.ORG 0x01 ; Program counter begins here
		MOV R0, 0X00 ; initialize values
		MOV R1, 0X00 ; initialize values
        IN R0, IN_PORT ; get input value

MAIN:   CALL DIVIDE
        OUT R1, OUT_TENS ; "quotient" will be the tens
        OUT R0, OUT_ONES ; "remainder" will be the ones

		CMP R1, 0X0A ; if the tens are more than 10
		BRCC YES_HUNDO ; branch to yes hundreds
		MOV R1, 0X00 ; if not, clear r1 and send r1 out
		OUT R1, OUT_HUNDO	

YES_HUNDO:
		MOV R0, R1 ; copy contents of r1 into r0
		MOV R1, 0X00 ; clear r0
		CALL DIVIDE 
		OUT R1, OUT_HUNDO
		OUT R0, OUT_TENS
		
		



.ORG 0X99 ; subroutine starts at 0x99
DIVIDE:
        CMP R0, 0X0A ; Compares remainder to divisor 
        BRCS DONE   ; Return to main if Remainder < Divisor
	    SUB R0, 0X0A  ; if Remainder > Divisor, keep dividing
        ADD R1, 0x01 ; increment quotient by 1
        BRN DIVIDE
DONE: RET
                
