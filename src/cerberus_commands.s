.pc02
;; KEY$() keyword
KEYSTR:
        jsr     CONINT
        txa
        beq     @nowait
@wait:
        lda MAILFLAG
        beq @wait
@nowait:
        lda MAILFLAG
        bne @store
        lda     #$00
        jsr     STRSPA
        pla
        pla
        jmp     PUTNEW
@store:
        lda     #$01
        jsr     STRSPA
        
        jsr     inkey
        
        ldy     #$00
        sta     (FAC+1),y
        pla
        pla
        jmp     PUTNEW


;; Print kernel and basic versions
VER:
        jsr KERNEL_VER
        lda     #<commit
        ldy     #>commit
        jmp     GOSTROUT2

;; LOCATE <COL>, <ROW>
LOCATE:
        jsr get_two_bytes
        
        cmp #MAX_COL
        bcs iq_error

        cpx #MAX_ROW
        bcs iq_error

        jmp gotoxy
iq_error:
        jmp IQERR

POS:
        jsr CONINT
        txa
        bne @y
        ldy COL
        jmp @result
@y:
        ldy ROW
@result:
        jmp SNGFLT

;; PSET x,y
PSET:
        jsr get_two_bytes

        cmp #LGR_ROWS
        bcs iq_error

        cpx #LGR_COLS
        bcs iq_error

        jmp plot

;; LINE x1,y1,x2,y2
DRAW_LINE:
        jsr GETBYT
        stx line_x1

        cpx #LGR_COLS
        bcs iq_error
        
        jsr CHKCOM
        
        jsr GETBYT
        stx line_y1

        cpx #LGR_ROWS
        bcs iq_error

        jsr CHKCOM

        jsr GETBYT
        stx line_x2

        cpx #LGR_COLS
        bcs iq_error
        
        jsr CHKCOM
        
        jsr GETBYT
        stx line_y2
        
        cpx #LGR_ROWS
        bcs iq_error

        jmp draw_line


get_two_bytes:
        jsr GETBYT
        stx LINNUM
        jsr CHKCOM
        jsr GETBYT
        txa
        ldx LINNUM
        rts

;; TODO: Implement
LOAD:
	RTS

;; TODO: Implement	
SAVE:
	RTS