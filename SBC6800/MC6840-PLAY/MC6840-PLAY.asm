;
; MC6840 PLAY
;  Universal Minitor for 6
;

	CPU	6800

TARGET:	EQU	"MC6800"

;
; Universal Minitor Utility Routine
;
STROUT  EQU        $FF98

;
; MAIN ROUTINE
;

        org $0200
MAIN:
        JSR     PRINT_START
;
        JSR     INIT_6840
        JSR     PLAY
;
        LDAA     #$00
        STAA     PTM_MSBT1
        STAA     PTM_T1LSB
        STAA     PTM_MSBT2
        STAA     PTM_T2LSB
        STAA     PTM_MSBT3
        STAA     PTM_T3LSB
;
        JSR     PRINT_END
        SWI
;
PLAY:
        LDX     #STR_DO
        STX     SOUND_STR_PTR
;
        LDAA    #$8
        STAA    PLAY_CNT
        LDX     #S_DO1
        STX     SOUND_PTR
;
PLAY_LOOP:
        JSR     PRINT_SND_STR
        JSR     SOUND_OUT
        DEC     PLAY_CNT
        BNE     PLAY_LOOP
;
        RTS
;
PRINT_SND_STR:
        LDX    SOUND_STR_PTR
        JSR     STROUT
        LDX    SOUND_STR_PTR
        INX
        INX
        INX
        INX
        INX
        STX    SOUND_STR_PTR
        RTS
;
SOUND_OUT:
        LDX     SOUND_PTR
        LDAA    0,X
        STAA    PTM_MSBT2
        LDAA    1,X
        STAA    PTM_T2LSB
        INX
        INX
        STX     SOUND_PTR
        JSR     WAIT
        RTS
;
INIT_6840:
        LDAA     #$01
        STAA     PTM_CR2
        STAA     PTM_CR13
;
        LDAA     #$FF
        STAA     PTM_MSBT1
        STAA     PTM_T1LSB
        STAA     PTM_MSBT2
        STAA     PTM_T2LSB
        STAA     PTM_MSBT3
        STAA     PTM_T3LSB
;
        LDAA     #$82
        STAA     PTM_CR2
        LDAA     PTM_CR13
        LDAA     #$93
        STAA     PTM_CR2
        LDAA     #$82
        STAA     PTM_CR13
;
        RTS
;
WAIT:
        LDAA     #$FF
        STAA     TIMER1
W_LOOP1:
        LDAA     #$FF
        STAA     TIMER2
W_LOOP2:
        NOP
        NOP
        DEC     TIMER2
        BNE     W_LOOP2
;
        DEC     TIMER1
        BNE     W_LOOP1
;
        RTS
;
PRINT_START:
        LDX	#START_MSG
        JSR     STROUT
        RTS
;
PRINT_END:
        LDX	#END_MSG
        JSR     STROUT
        RTS
;
; SOUND DEFINE
;
S_DO1   FDB  $0777
;S_DO1S  FDB  $070B
S_RE1   FDB  $06A6
;S_RE1S  FDB  $0647
S_MI1   FDB  $05EC
S_FA1   FDB  $0597
;S_FA1S  FDB  $0547
S_SO1   FDB  $04FB
;S_SO1S  FDB  $04B3
S_RA1   FDB  $0470
;S_RA1S  FDB  $0430
S_SI1   FDB  $03F4
S_DO2   FDB  $03BB
;S_DO2S  FDB  $0385
S_RE2   FDB  $0353
;S_RE2S  FDB  $0323
S_MI2   FDB  $02F6
S_FA2   FDB  $02CB
;S_FA2S  FDB  $02A3
S_SO2   FDB  $027D
;S_SO2S  FDB  $0259
S_RA2   FDB  $0238
;S_RA2S  FDB  $0218
S_SI2   FDB  $01FA
S_DO3   FDB  $01DD
;
STR_DO  DC "DO",$0D,$0A,$00
STR_RE  DC "RE",$0D,$0A,$00
STR_MI  DC "MI",$0D,$0A,$00
STR_FA  DC "FA",$0D,$0A,$00
STR_SO  DC "SO",$0D,$0A,$00
STR_RA  DC "RA",$0D,$0A,$00
STR_SI  DC "SI",$0D,$0A,$00
STR_DO1  DC "DO",$0D,$0A,$00
STR_RE1  DC "RE",$0D,$0A,$00
STR_MI2  DC "MI",$0D,$0A,$00
STR_FA1  DC "FA",$0D,$0A,$00
STR_SO1  DC "SO",$0D,$0A,$00
STR_RA1  DC "RA",$0D,$0A,$00
STR_SI1  DC "SI",$0D,$0A,$00

;
; MSG DEFINE
;
START_MSG DC "PLAY START",$0D,$0A,$00
END_MSG DC "PLAY END",$0D,$0A,$00
;
; WORK AREA
;
TIMER1  RMB 1
TIMER2  RMB 1
;
PLAY_CNT  RMB 1
SOUND_STR_PTR RMB 2
SOUND_PTR RMB 2
;
; MC6840 PTM Address
;
        ORG $8030
PTM_CR13  RMB 1
PTM_CR2   RMB 1
PTM_MSBT1 RMB 1
PTM_T1LSB RMB 1
PTM_MSBT2 RMB 1
PTM_T2LSB RMB 1
PTM_MSBT3 RMB 1
PTM_T3LSB RMB 1

        END
