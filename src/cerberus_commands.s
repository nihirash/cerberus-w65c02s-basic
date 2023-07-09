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

iq_error:
        jmp IQERR

get_two_bytes:
        jsr GETBYT
        stx LINNUM
        jsr CHKCOM
        jsr GETBYT
        txa
        ldx LINNUM
        rts

;; TILE n - draws tile on current cursor position
;; A lot faster than PRINT CHR$(n);
TILE:
        jsr get_two_bytes
        
        cmp #MAX_ROW
        bcs iq_error

        cpx #MAX_COL
        bcs iq_error
        
        phx
        jsr get_line_address

        sta KERN_PTR
        stx KERN_PTR+1

        jsr CHKCOM
        jsr GETBYT
        ply
        cpx #udg_count
        bcs iq_error
        
        jmp draw_tile

DEF_TILE:
        jsr GETBYT
        cpx #0
        beq @ro
        cpx #udg_count
        phx
        bcs @err
        ldy #0
@loop:
        phy
        jsr CHKCOM
        jsr GETBYT
        ply
        txa
        sta udg_data, y
        iny
        cpy #8
        bne @loop
        plx
        jmp def_udg
@err:
        plx
        jmp IQERR
@ro:
        ldx #ERR_RO
        jmp ERROR

CIRCLE:
;; X
        jsr GETBYT
        cpx #LGR_COLS
        bcs iq_error
        stx circle_x
;; ,
        jsr CHKCOM
;; Y
        jsr GETBYT
        cpx #LGR_ROWS
        bcs iq_error
        stx circle_y
;; ,
        jsr CHKCOM
;; R
        jsr GETBYT
        cpx #LGR_ROWS
        bcs iq_error
        stx circle_r

        jmp circle

;; TODO: Implement
LOAD:
	RTS

;; SAVE "FILENAME"
SAVE:
;; Store data from TXTTAB
;; Lenght should be (VARTAB)-(TXTTAB)
        cmp #'"'
        bne syn_err

        ldy #$FF
@name:     
        iny   
        jsr CHRGET
        beq @noquota
        cmp #'"'
        beq @done
        sta filename, y
        
        bra @name
@done:
        jsr CHRGET
@noquota:       
        lda #0
        sta filename, y
;; Code start address
        lda TXTTAB
        sta filestart
        lda TXTTAB + 1
        sta filestart + 1
;; Code lenght
        lda VARTAB
        sec
        sbc TXTTAB
        sta filesize
        lda VARTAB + 1
        sec
        sbc TXTTAB + 1
        sta filesize + 1
;; Save code
        jmp file_save

;; Syntax error        
syn_err:
        jmp SYNERR
