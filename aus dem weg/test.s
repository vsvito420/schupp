;----------------------------------------------------------------------
; Titel		: Led leuchten lassen
;----------------------------------------------------------------------
; Belegung		: PORTD.2=Taster1, PORTB.0=LED-Rot
;----------------------------------------------------------------------
; Prozessor		: ATmega8
; Takt		: 3,6864 MHz
; Sprache		: Assembler
; Datum		: 04.03.2024
; Version		: 1.0
; Autor		: Vito SKolan
;----------------------------------------------------------------------
.equ	F_CPU,	3686400
.include	"AVR.H"
;------------------------------------------------------------------------
;Reset and Interruptvectoren	;VNr.	Beschreibung
begin:
	rjmp	main	; 1    POWER ON RESET
	reti		; 2    Int0-Interrupt
	reti		; 3    Int1-Interrupt
	reti		; 4    TC2 Compare Match
	reti		; 5    TC2 Overflow
	reti		; 6    TC1 Capture
	reti		; 7    TC1 Compare Match A
	reti		; 8    TC1 Compare Match B
	reti		; 9    TC1 Overflow
	reti		;10    TC0 Overflow
	reti		;11    SPI, STC Serial Transfer Complete
	reti		;12    UART Rx Complete
	reti		;13    UART Data Register Empty
	reti		;14    UART Tx Complete
	reti		;15    ADC Conversion Complete
	reti		;16    EEPROM Ready
	reti		;17    Analog Comperator
	reti		;18    TWI (I²C) Serial Interface
	reti		;19    Strore Program Memory Ready
;------------------------------------------------------------------------
; Eine LED ueber externe interrupts ein und ausgeschaltet werden.

; [ ] Verbinden sie einen 2. Taster mit dem Eingang fuer den externen interrupt 1
; [ ] Verbinden Sie eine LED mit PORTB,0

;Funktion des Programmes:
; [ ] Wenn der 1. Taster gedrueckt wird, soll die LED eingeschaltet werden ( Permanent leuchten)
; [ ] Wenn der 2. Taster gedrueckt wird, soll die LED ausgeschaltet werden ( permanent aus sein)

; [x] Schreiben Sie den Pullup - Wiederstand fuer die Taster
; [ ] Schreiben Sie zwei interrupt Service Routinen
; [ ] INT0 PortD,2 INT1 PortD,3
;------------------------------------------------------------------------
;Start, Power ON, Reset
main:
	ldi	r16,hi8(RAMEND)
	out	ioSPH,r16
	ldi	r16,lo8(RAMEND)	
	out	ioSPL,r16	

	cbi	ioDDRD,2	;PORTD2 auf Eingang
	sbi	ioPORTD,2	;PORTD2 Pullup;aktiviert die Pullup-Widerstände für die Taster an PORTD,2
	sbi	ioPORTD,3	;PORTD3 Pullup;aktiviert die Pullup-Widerstände für die Taster an PORTD,3
	sbi	ioDDRB,0	;Dieser Code setzt PORTB,0 als Ausgang für die LED,
;------------------------------------------------------------------------
mainloop:
	cbi	ioPORTB,0	;Wert bei Taste nicht gedrückt
	sbis	ioPIND,2	;Taste auswerten
	sbi	ioPORTB,0	;Wert bei Taste gedrückt
	rjmp	mainloop
;-----------------------------------------------------------------------



 

;und aktiviert die externen Interrupts INT0 und INT1. Wenn der Taster, der mit INT0 verbunden ist, gedrückt wird, wird die LED eingeschaltet. 
;Wenn der Taster, der mit INT1 verbunden ist, gedrückt wird, wird die LED ausgeschaltet