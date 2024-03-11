;----------------------------------------------------------------------
; Title       : Aufgabe 2: Timer 
;----------------------------------------------------------------------
; Schaltung   : PORTB.0=Summer, PORTB.1=LED-Rot
;----------------------------------------------------------------------
; Prozessor   : ATmega8
; Takt        : 3,6864 MHz
; Sprache     : Assembler
; Datum       : 04.03.2024
; Version     : 1.0
; Autor       : Vito Skolan
;----------------------------------------------------------------------
.equ  F_CPU,  3686400
.include  "avr.h"
;-----------------------------------------------------------------------
;Reset and Interruptvectoren   ;VNr.  Beschreibung
begin:
  rjmp         main	           ; 1    POWER ON RESET
  reti                         ; 2    Int0-Interrupt
  reti                         ; 3    Int1-Interrupt
  reti                         ; 4    TC2 Compare Match
  reti                         ; 5    TC2 Overflow
  reti                         ; 6    TC1 Capture
  reti                         ; 7    TC1 Compare Match A
  reti                         ; 8    TC1 Compare Match B
  reti                         ; 9    TC1 Overflow
  rjmp         onTC0           ;10    TC0 Overflow
  reti                         ;11    SPI, STC Serial Transfer Complete
  reti                         ;12    UART Rx Complete
  reti                         ;13    UART Data Register Empty
  reti                         ;14    UART Tx Complete
  reti                         ;15    ADC Conversion Complete
  reti                         ;16    EEPROM Ready
  reti                         ;17    Analog Comperator
  reti                         ;18    TWI (I²C) Serial Interface
  reti                         ;19    Strore Program Memory Ready
;------------------------------------------------------------------------
;Start, Power ON, Reset
main:
  ldi r16,lo8(RAMEND)
  out	ioSPL,r16	;Init
  ldi	r16,hi8(RAMEND)
  out	ioSPH,r16

  sbi	ioDDRB,0  ;OUT Summer
  sbi	ioDDRB,1  ;OUT LED

  ldi	r16,0b0000101
  out	ioTCCR0,r16	;Timer0 Vorteiler 1024
  ldi	r16,0b0000001
  out	ioTIMSK,r16	;Interrupt

  ldi	r17,190	;Timer0 Init
  out	ioTCNT0,r17	;ausgeben
  ldi	r16,0		;Ausgabewert LOW
  sei
;------------------------------------------------------------------------
mainloop:
  wdr
  rjmp	mainloop
;------------------------------------------------------------------------
onTC0:
  cli
  in	r16,ioPORTB	;PORTB einlesen
  com	r16		;Bitweise Negation
  out	ioPORTB,r16	;PORTB umschalten
  ldi	r17,190		
  out	ioTCNT0,r17	;Timer Reinit
  sei		;Interrupt freigeben
  reti		;Rücksprung
;------------------------------------------------------------------------




