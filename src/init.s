.segment "INIT"


; ----------------------------------------------------------------------------

COLD_START:
      ldx     #$FE
      txs
      lda     #$4C
      sta     JMPADRS
      sta     GORESTART

      lda     #<IQERR
      ldy     #>IQERR

      sta     USR+1
      sty     USR+2

      lda     #WIDTH
      sta     Z17
      lda     #WIDTH2
      sta     Z18

; All non-CONFIG_SMALL versions of BASIC have
; the same bug here: While the number of bytes
; to be copied is correct for CONFIG_SMALL,
; it is one byte short on non-CONFIG_SMALL:
; It seems the "ldx" value below has been
; hardcoded. So on these configurations,
; the last byte of GENERIC_RNDSEED, which
; is 5 bytes instead of 4, does not get copied -
; which is nothing major, because it is just
; the least significant 8 bits of the mantissa
; of the random number seed.
; KBD added three bytes to CHRGET and removed
; the random number seed, but only adjusted
; the number of bytes by adding 3 - this
; copies four bytes too many, which is no
; problem.

        ldx     #GENERIC_CHRGET_END-GENERIC_CHRGET-1 ; XXX
L4098:
        lda     GENERIC_CHRGET-1,x
        sta     CHRGET-1,x
        dex
        bne     L4098
.ifdef CONFIG_2
        lda     #$03
        sta     DSCLEN
.endif
.ifndef KBD
        txa
        sta     SHIFTSIGNEXT
  .ifdef CONFIG_CBM_ALL
        sta     CURDVC
  .endif
        sta     LASTPT+1
  .ifndef AIM65
  .if .defined(CONFIG_NULL) || .defined(CONFIG_PRINTNULLS)
        sta     Z15
  .endif
  .endif
  .ifndef CONFIG_11
        sta     POSX
  .endif
        pha
        sta     Z14
  .ifndef CBM2
   .ifndef AIM65
   .ifndef SYM1
    .ifndef MICROTAN
        lda     #$03
        sta     DSCLEN
    .endif
   .endif
   .endif
    .ifndef CONFIG_11
        lda     #$2C
        sta     LINNUM+1
    .endif
        jsr     CRDO
  .endif
  .ifdef CBM2
        inx
        stx     INPUTBUFFER-3
        stx     INPUTBUFFER-4
  .endif

        ldx     #TEMPST
        stx     TEMPPT

        lda     #<RAMSTART2
        ldy     #>RAMSTART2

        sta     TXTTAB
        sty     TXTTAB+1

        sta     LINNUM
        sty     LINNUM+1

        tay

L40D7:
        inc     LINNUM
        bne     L40DD
        inc     LINNUM+1

        lda     LINNUM+1
        cmp     #>RAMEND ;; Hard limit to prevet use screen as ram 
        beq     L40FA

L40DD:

        lda     #$55 ; 01010101 / 10101010

        sta     (LINNUM),y
        cmp     (LINNUM),y
        bne     L40FA
        asl     a
        sta     (LINNUM),y
        cmp     (LINNUM),y

        beq     L40D7

L40FA:
        lda     LINNUM
        ldy     LINNUM+1
        sta     MEMSIZ
        sty     MEMSIZ+1
.if !(.def(MICROTAN) || .def(AIM65) || .def(SYM1))
        sta     FRETOP
        sty     FRETOP+1
.endif
L4106:
.ifndef CONFIG_CBM_ALL
  .ifdef APPLE
        lda     #$FF
        jmp     L2829
        .word	STROUT ; PATCH!
        jsr     NXIN
  .else
        lda     #<QT_TERMINAL_WIDTH
        ldy     #>QT_TERMINAL_WIDTH
        jsr     STROUT
        jsr     NXIN
  .endif
        stx     TXTPTR
        sty     TXTPTR+1
        jsr     CHRGET
        tay
        beq     L4136
        jsr     LINGET
        lda     LINNUM+1
        bne     L4106
        lda     LINNUM
        cmp     #$10
        bcc     L4106
L2829:
        sta     Z17
L4129:
  .ifdef AIM65
        sbc     #$0A
  .else
        sbc     #$0E
  .endif
        bcs     L4129
        eor     #$FF
  .ifdef AIM65
        sbc     #$08
  .else
        sbc     #$0C
  .endif
        clc
        adc     Z17
        sta     Z18
.endif
L4136:

        ldx     #<RAMSTART2
        ldy     #>RAMSTART2

        stx     TXTTAB
        sty     TXTTAB+1
        ldy     #$00
        tya
        sta     (TXTTAB),y
        inc     TXTTAB

        lda     TXTTAB
        ldy     TXTTAB+1
        jsr     REASON

        lda     #<QT_BASIC
        ldy     #>QT_BASIC
        jsr     STROUT


        lda     MEMSIZ
        sec
        sbc     TXTTAB
        tax
        lda     MEMSIZ+1
        sbc     TXTTAB+1
        jsr     LINPRT
        lda     #<QT_BYTES_FREE
        ldy     #>QT_BYTES_FREE
        jsr     STROUT
        
        jsr     SCRTCH
        jmp     RESTART


QT_MEMORY_SIZE:
        .byte   "MEMORY SIZE"
        .byte   0
  .endif
QT_BYTES_FREE:
        .byte   " BYTES FREE"
        .byte   CR, LF, 0
QT_BASIC:
        .byte CR, LF
        .byte   "         -=[ CERBERUS BASIC ]=-"
        .byte   CR, LF, CR, LF
        .byte   "       BASED ON MICROSOFT BASIC V2"
        .byte  CR, LF, CR, LF
        .byte "       64K SYSTEM "
        .byte 0

