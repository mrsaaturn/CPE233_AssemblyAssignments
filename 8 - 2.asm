;- CPE 233 - Software Assignment 8 -- problem 2
;- Programmer:
;- Date: 03-02-18
;- Description:
;- 		Interrupt driven LED blinker. Alternatively turns on/off
;-		LEDs corresponding to the most recent value on the switches.
;------------------------------------------
;- Constants
.EQU SW_PORT 	= 0x9A	; port for switches   -- INPUT
.EQU LEDS 		= 0x42	; port for LEDS		  -- OUTPUT
.EQU BTN		= 0x9B  ; port for the button -- INPUT
;------------------------------------------
.CSEG
.ORG 0x10
init:		SEI

MAIN_LOOP:	IN R0, SW_PORT ; take in the switches
			CMP R3, 0x02
			BREQ PANIC
			BRN MAIN_LOOP

ISR:
			CMP R0, R1 ; if R0 = R1
			BREQ MAYBE_PANIC ; go to maybe panic, otherwise
							; go to business as usual
BUSINESS:
			MOV R1, R0 ; move R0 into R1
			OUT R1, LEDS ; out R1 to the LEDS
			
			RETIE ; return with interrupts enabled

MAYBE_PANIC:
			ADD R3, 0x01 ; increment the panic register
			BRN BUSINESS ; go back to business as usual

PANIC:
			IN R5, BTN
			OUT 0x00, LEDS
			CMP R5, 0x01
			BRNE PANIC
			MOV R3, 0x00 ; clear panic register
			BRN MAIN_LOOP ; go back to outputting since
						  ; button was pressed


.ORG 0x3FF
			BRN ISR
