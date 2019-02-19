;- CPE 233 - Software Assignment 8 -- problem 1
;- Programmer:
;- Date: 03-02-18
;- Description:
;- 		Interrupt driven LED blinker. Alternatively turns on/off
;-		LEDs corresponding to the most recent value on the switches.
;------------------------------------------
;- Constants
.EQU SW_PORT 	= 0x9A	; port for switches -- INPUT
.EQU LEDS 		= 0x42	; port for LEDS		-- OUTPUT
;------------------------------------------
.CSEG
.ORG 0x10
init:		SEI

MAIN_LOOP:	IN R0, SW_PORT ; take in the switches
			BRN MAIN_LOOP

ISR:		
			EXOR R0,R1 ; Toggle leds based on the most recent
					   ; value on the switches
			MOV R1, R0 ; move R0 into R1
			OUT R1, LEDS ; out R1 to the LEDS
			RETIE ; return with interrupts enabled
.ORG 0x3FF
			BRN ISR
