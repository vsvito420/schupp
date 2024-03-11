;----------------------------------------------------------------------
; Titel		: myAVR Beispiel "IN/OUT" für den ATmega8
;----------------------------------------------------------------------
; Funktion 		: Solange Taster 1 gedrückt ist, wird eine LED
;				: eingeschaltet
; Schaltung		: PORTD.2=Taster1, PORTB.0=LED-Rot
;----------------------------------------------------------------------
; Prozessor		: ATmega8
; Takt		: 3,6864 MHz
; Sprache		: Assembler
; Datum		: 09.11.2007
; Version		: 1.0
; Autor		: Renaldo Badke
; Programmer	:
; Port		:
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
;Start, Power ON, Reset
main:
	ldi	r16,hi8(RAMEND)
	out	ioSPH,r16
	ldi	r16,lo8(RAMEND)	;Stack Initialisierung
	out	ioSPL,r16	;Init Stackpointer

	cbi	ioDDRD,2	;PORTD2 auf Eingang
	sbi	ioPORTD,2	;PORTD2 Pullup
	sbi	ioDDRB,0	;PORTB0 auf Ausgang
;------------------------------------------------------------------------
mainloop:
	cbi	ioPORTB,0	;Wert bei Taste nicht gedrückt
	sbis	ioPIND,2	;Taste auswerten
	sbi	ioPORTB,0	;Wert bei Taste gedrückt
	rjmp	mainloop
;-----------------------------------------------------------------------

