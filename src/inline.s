.segment "CODE"


; ----------------------------------------------------------------------------
; READ A LINE, AND STRIP OFF SIGN BITS
; ----------------------------------------------------------------------------

INLIN:
        ldx     #$00
INLIN2:
        jsr     GETLN
        cmp     #KBD_BACK
        beq     INLINBS
        cmp     #CR
        beq     L2453
        sta     INPUTBUFFER,x
        inx
        bne     INLIN2
L2453:
        jmp     L29B9

;; Backspace processing 
INLINBS:
  txa
  beq INLIN2
  dex
  jmp INLIN2

GETLN:
        jsr     MONRDKEY
        cmp     #$0F
        bne     L2465
        pha
        lda     Z14
        eor     #$FF
        sta     Z14
        pla
L2465:
        rts

