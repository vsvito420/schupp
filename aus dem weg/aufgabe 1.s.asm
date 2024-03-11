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
	rjmp	interrupt1	;2   Int0-Interrupt
	rjmp	interrupt2	;3   Int1-Interrupt
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
main:
    ldi r16, lo8(RAMEND)
    out SPL, r16
    ldi r16, hi8(RAMEND)
    out SPH, r16

    ; PORTB,0 als Ausgang für die LED setzen
    sbi DDRB, 0

    ; Pullup-Widerstände für die Taster aktivieren
    sbi PORTD, 2
    sbi PORTD, 3

    ; Externe Interrupts aktivieren
    ldi r16, (1<<ISC01) ; Trigger INT0 on falling edge
    out MCUCR, r16
    ldi r16, (1<<INT0) ; Enable INT0
    out GICR, r16

    ldi r16, (1<<ISC11) ; Trigger INT1 on falling edge
    out MCUCR, r16
    ldi r16, (1<<INT1) ; Enable INT1
    out GICR, r16

    ; Globale Interrupts aktivieren
    sei

mainloop:
    ; Hauptprogrammschleife
    rjmp mainloop

; Interrupt-Service-Routinen
interrupt1: ; INT0
    ; LED einschalten
    sbi PORTB, 0
    reti

interrupt2: ; INT1
    ; LED ausschalten
    cbi PORTB, 0
    reti
;------------------------------------------------------------------------
; Eine LED ueber externe interrupts ein und ausgeschaltet werden.
; Verbinden Sie einen 1. Taster mit dem eingang fuer den externen interrupt 0
; Verbinden sie einen 2. Taster mit dem Eingang fuer den externen interrupt 1
; Verbinden Sie eine LED mit PORTB,0

;Funktion des Programmes:
; Wenn der 1. Taster gedrueckt wird, soll die LED eingeschaltet werden ( Permanent leuchten)
; Wenn der 2. Taster gedrueckt wird, soll die LED ausgeschaltet werden ( permanent aus sein)
; Tipp Aktivieren Sie die Interrupts
; Beachten Sie den Pullup Wiederstand fuer die Taster
; Schreiben Sie den Pullup - Wiederstand fuer die Taster
; Schreiben Sie zwei interrupt Service Routinen
; INT0 PortD,2 INT1 PortD,3

;Dieser Code setzt PORTB,0 als Ausgang für die LED, 
;aktiviert die Pullup-Widerstände für die Taster an PORTD,2 und PORTD,3, 
;und aktiviert die externen Interrupts INT0 und INT1. Wenn der Taster, der mit INT0 verbunden ist, gedrückt wird, wird die LED eingeschaltet. 
;Wenn der Taster, der mit INT1 verbunden ist, gedrückt wird, wird die LED ausgeschaltet