;+----------------------------------------------------------------------
;| Title		: myAVR Grundgerüst für ATmega8
;+----------------------------------------------------------------------
;| Funktion		: ...
;| Schaltung	: ...
;+----------------------------------------------------------------------
;| Prozessor	: ATmega8
;| Takt		: 3,6864 MHz
;| Sprache       	: Assembler
;| Datum         	: ...
;| Version       	: ...
;| Autor         	: ...
;+----------------------------------------------------------------------
.include	"AVR.H"
;------------------------------------------------------------------------
;Reset and Interrupt vector             ;VNr.  Beschreibung
	rjmp	main	;1   POWER ON RESET
	reti		;2   Int0-Interrupt
	reti		;3   Int1-Interrupt
	reti		;4   TC2 Compare Match
	reti		;5   TC2 Overflow
	reti		;6   TC1 Capture
	reti		;7   TC1 Compare Match A
	reti		;8   TC1 Compare Match B
	reti		;9   TC1 Overflow
	reti		;10  TC0 Overflow
	reti		;11  SPI, STC Serial Transfer Complete
	reti		;12  UART Rx Complete
	reti		;13  UART Data Register Empty
	reti		;14  UART Tx Complete
	reti		;15  ADC Conversion Complete
	reti		;16  EEPROM Ready
	reti		;17  Analog Comparator
	reti		;18  TWI (I²C) Serial Interface
	reti		;19  Store Program Memory Ready
;------------------------------------------------------------------------
;Start, Power ON, Reset
main:	ldi	r16,lo8(RAMEND)
	out	ioSPL,r16
	ldi	r16,hi8(RAMEND)
	out	ioSPH,r16
	;Hier Init-Code eintragen.

	ldi	r16,23	;konstante 23 in R16 schreiben
	out	UBRRL,r16	; Wert aus 16 in ubrr schreiben

	sbi	UCSRB,3	;UART Senden Aktivieren bit 3 in UCSRB setzen
;------------------------------------------------------------------------
mainloop:	wdr
	;Hier den Quellcode eintragen.

	ldi	r16,'H'
	rcall	senden

ende:	rjmp	ende
;------------------------------------------------------------------------

senden:	sbis	UCSRA,5	;Überspringe nächtsten befehl
	rjmp	senden	;wenn bit 5 in ucsra wert '1' hat springe zum senden

	out	UDR,r16
	ret
