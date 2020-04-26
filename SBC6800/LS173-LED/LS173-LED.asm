;
; 74LS173経由で接続されている LEDを点滅
; I/O : $8000
; データの$01〜$04の各ビット、1で点灯、0で消灯
;--------------------------------------------
; 本プログラムはUniversal Monitor for SBC6800用です

        CPU	6800

TARGET:	equ	"MC6800"
;
; LED CONTROL
;
LED_PORT  EQU  $8000
;
; Universal Moniter Entry
;
STR_PRINT  EQU  $FF90
;
; MAIN START
;
        ORG $0200
;
START:
        LDX  #START_MSG
        JSR  STR_PRINT
;
        LDAA #$00
        STAA CURRENT_LED
;
LED_LOOP:
        LDAA CURRENT_LED
        STAA LED_PORT
        JSR  WAIT
        LDAA CURRENT_LED
        INCA
        STAA CURRENT_LED
        CMPA #$10
        BNE LED_LOOP
;
        LDX  #END_MSG
        JSR  STR_PRINT
        SWI                     ; PROGRAM END
;
; WAIT
;
WAIT:
        LDAA    #$FF
WAIT_LOOP1:
        LDAB    #$FF
WAIT_LOOP2:
        NOP
        NOP
        DECB
        BNE     WAIT_LOOP2
        DECA
        BNE     WAIT_LOOP1
        RTS
;
; CINSTANT
;
START_MSG  DC  "74LS173 LED BLINK START",$0D,$0A,$00
END_MSG  DC  "74LS173 LED BLINK END",$0D,$0A,$00
;
; WORK AREA
;
CURRENT_LED     RMB  1
