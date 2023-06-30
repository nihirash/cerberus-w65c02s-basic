.segment "CODE"

; ----------------------------------------------------------------------------
; "FRE" FUNCTION
;
; COLLECTS GARBAGE AND RETURNS # BYTES OF MEMORY LEFT
; ----------------------------------------------------------------------------
FRE:
        lda     VALTYP
        beq     L3188
        jsr     FREFAC
L3188:
        jsr     GARBAG
        sec
        lda     FRETOP
        sbc     STREND
        tay
        lda     FRETOP+1
        sbc     STREND+1
; FALL INTO GIVAYF TO FLOAT THE VALUE
; NOTE THAT VALUES OVER 32767 WILL RETURN AS NEGATIVE

; ----------------------------------------------------------------------------
; FLOAT THE SIGNED INTEGER IN A,Y
; ----------------------------------------------------------------------------
GIVAYF:
        ldx     #$00
        stx     VALTYP
        sta     FAC+1
        sty     FAC+2
        ldx     #$90
        jmp     FLOAT1
; ----------------------------------------------------------------------------
; FLOAT (Y) INTO FAC, GIVING VALUE 0-255
; ----------------------------------------------------------------------------
SNGFLT:
        lda     #$00
        beq     GIVAYF

; ----------------------------------------------------------------------------
; CHECK FOR DIRECT OR RUNNING MODE
; GIVING ERROR IF DIRECT MODE
; ----------------------------------------------------------------------------
ERRDIR:
        ldx     CURLIN+1
        inx
        bne     RTS9
        ldx     #ERR_ILLDIR
        .byte   $2C
LD288:
        ldx     #ERR_UNDEFFN
L31AF:
        jmp     ERROR
DEF:
        jsr     FNC
        jsr     ERRDIR
        jsr     CHKOPN
        lda     #$80
        sta     SUBFLG
        jsr     PTRGET
        jsr     CHKNUM
        jsr     CHKCLS
        lda     #TOKEN_EQUAL
        jsr     SYNCHR

        pha

        lda     VARPNT+1
        pha
        lda     VARPNT
        pha
        lda     TXTPTR+1
        pha
        lda     TXTPTR
        pha
        jsr     DATA
        jmp     L3250
FNC:
        lda     #TOKEN_FN
        jsr     SYNCHR
        ora     #$80
        sta     SUBFLG
        jsr     PTRGET3
        sta     FNCNAM
        sty     FNCNAM+1
        jmp     CHKNUM
L31F3:
        jsr     FNC
        lda     FNCNAM+1
        pha
        lda     FNCNAM
        pha
        jsr     PARCHK
        jsr     CHKNUM
        pla
        sta     FNCNAM
        pla
        sta     FNCNAM+1
        ldy     #$02

        lda     (FNCNAM),y

        sta     VARPNT
        tax
        iny
        lda     (FNCNAM),y

        beq     LD288

        sta     VARPNT+1

        iny

L3219:
        lda     (VARPNT),y
        pha
        dey
        bpl     L3219
        ldy     VARPNT+1
        jsr     STORE_FAC_AT_YX_ROUNDED
        lda     TXTPTR+1
        pha
        lda     TXTPTR
        pha
        lda     (FNCNAM),y
        sta     TXTPTR
        iny
        lda     (FNCNAM),y
        sta     TXTPTR+1
        lda     VARPNT+1
        pha
        lda     VARPNT
        pha
        jsr     FRMNUM
        pla
        sta     FNCNAM
        pla
        sta     FNCNAM+1
        jsr     CHRGOT
        beq     L324A
        jmp     SYNERR
L324A:
        pla
        sta     TXTPTR
        pla
        sta     TXTPTR+1
L3250:
        ldy     #$00
        pla
        sta     (FNCNAM),y
        pla
        iny
        sta     (FNCNAM),y
        pla
        iny
        sta     (FNCNAM),y
        pla
        iny
        sta     (FNCNAM),y

        pla
        iny
        sta     (FNCNAM),y
        
        rts
