.segment "CODE"

; ----------------------------------------------------------------------------
; READ A LINE, AND STRIP OFF SIGN BITS
; ----------------------------------------------------------------------------

INLIN:
        ldx     #$00
INLIN2:
        jsr     line_rdkey
        
        cmp     #KBD_BACK
        beq     INLINBS

        jsr     erase_cursor
        jsr     rdkey_out

        cmp     #CR
        beq     L2453
        sta     INPUTBUFFER,x
        inx
        bne     INLIN2
L2453:
        jsr     erase_cursor
        jmp     L29B9

;; Backspace processing 
INLINBS:
  txa
  beq INLIN2
  dex
  lda #KBD_BACK
  jsr putc
  jmp INLIN2


