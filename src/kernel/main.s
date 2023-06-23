.pc02


LINE = $FE ; and $FF       ; ADDR (2 bytes), store a LINE ADDR
ROW = LINE - 1 
COL = ROW - 1

VRAM = $F800
MAILFLAG = $0200
MAILBOX  = $0201

MAX_ROW = 30
MAX_COL = 40
CURSOR  = ' ' + $80
SPACE   = ' '

KBD_RET  = $0D  ; Return
KBD_BACK = $08  ; Backspace


Reset:
  lda #<NMI_vec
  sta $FFFA
  lda #>NMI_vec
  sta $FFFB
  lda #<IRQ_vec
  sta $FFFE
  lda #>IRQ_vec
  sta $FFFF
  CLD             ; clear decimal mode
  LDX #$FF
  TXS             ; set the stack pointer
  CLI


  ; store addr of line 0
  lda #<VRAM
  sta LINE
  lda #>VRAM
  sta LINE+1

  jsr clear_screen

  stz MAILFLAG
  jsr put_cursor
	JMP	COLD_START	; BASIC cold start

MONCOUT:
    phy
    pha
    jsr putc
    jsr put_cursor
    pla
    ply
    rts
putc:
  cmp #8
  beq @backspace

  cmp #13
  beq @curdn

  cmp #10
  beq @home

  ldy COL
  sta (LINE),y
  inc COL
  sty POSX
  
  cpy #MAX_COL-1
  beq @return
  rts
@home:
  jsr erase_cursor
  stz COL
  rts

@return:
  jsr erase_cursor
  stz COL
  jmp @skipe
@curdn:
  jsr erase_cursor
@skipe:
; last row?
  lda ROW
  cmp #MAX_ROW-1
  bne @not_last_row
; yes last row --> don't inc ROW, scroll everything up

  jsr scroll_up
  rts

; else (not last row)
@not_last_row:  
  ; LINE<-LINE+MAX_COL
  clc
  lda LINE
  adc #MAX_COL
  sta LINE
  lda LINE+1
  adc #0
  sta LINE+1
  ; ROW++
  inc ROW   
  rts

@backspace:
  jsr erase_cursor
  ; dey only if not 0
  cpy #0
  bne @goleft1col
  ; we are at the beginning of a line:
  ; if first line: can't do anything
  lda ROW
  cmp #0
  beq @erase
  ; otherwise: move up 1 line:
  dea
  sta ROW
  ; LINE -= MAX_COL
  sec 
  lda LINE
  sbc #MAX_COL
  sta LINE
  lda LINE+1
  sbc #0
  sta LINE+1
  ; place cursor on the last col
  ldy #MAX_COL-1
  sty COL

  bra @erase
@goleft1col:
  dey
  sty COL
@erase:
  lda #SPACE
  sta (LINE),y

  rts



;--------------------------------------

erase_cursor:
  pha
  lda #SPACE
  ldy COL
  sta (LINE),y
  pla
  rts

put_cursor:
  lda #CURSOR
  ldy COL
  sta (LINE),y
  rts


;--------------------------------------

clear_screen:
  pha
  phy
  
  lda #<VRAM
  sta LINE
  lda #>VRAM
  sta LINE+1

  stz ROW
  stz COL

  lda #SPACE

  ldy #$00
next:
  sta VRAM,y
  sta VRAM+$100,y
  sta VRAM+$200,y
  sta VRAM+$300,y

  dey
  bne next

  ldy #$af
next2:
  sta VRAM+$400,y

  dey
  bne next2
  sta VRAM+$400,y
  ply
  pla
  RTS
  


scroll_up:
  ; Scroll screen UP (and clears last line), long... ¿fast?
  phy
  ldy #00
@next:
  lda $F828,y
  sta $F800,y
  lda $F850,y 
  sta $F828,y
  lda $F878,y 
  sta $F850,y
  lda $F8A0,y 
  sta $F878,y
  lda $F8C8,y 
  sta $F8A0,y
  lda $F8F0,y 
  sta $F8C8,y
  lda $F918,y 
  sta $F8F0,y
  lda $F940,y 
  sta $F918,y
  lda $F968,y 
  sta $F940,y
  lda $F990,y 
  sta $F968,y
  lda $F9B8,y 
  sta $F990,y
  lda $F9E0,y 
  sta $F9B8,y
  lda $FA08,y 
  sta $F9E0,y
  lda $FA30,y 
  sta $FA08,y
  lda $FA58,y 
  sta $FA30,y
  lda $FA80,y 
  sta $FA58,y
  lda $FAA8,y 
  sta $FA80,y
  lda $FAD0,y 
  sta $FAA8,y
  lda $FAF8,y 
  sta $FAD0,y
  lda $FB20,y 
  sta $FAF8,y
  lda $FB48,y 
  sta $FB20,y
  lda $FB70,y 
  sta $FB48,y
  lda $FB98,y 
  sta $FB70,y
  lda $FBC0,y 
  sta $FB98,y
  lda $FBE8,y 
  sta $FBC0,y
  lda $FC10,y 
  sta $FBE8,y
  lda $FC38,y 
  sta $FC10,y
  lda $FC60,y 
  sta $FC38,y
  lda $FC88,y 
  sta $FC60,y
  lda #SPACE
  sta $FC88,y
  iny
  cpy #$28
  beq @end
  jmp @next
@end:
  ply
  rts


;; Read key
MONRDKEY:
    LDA     MAILFLAG
    BEQ     MONRDKEY
    
    STZ     MAILFLAG
    LDA     MAILBOX
    
    CMP     #$0A
    bne     @del
    LDA     #$0D
    jmp     @noout
@del:
    CMP     #KBD_BACK
    bne     @uppercase
    LDA     #$08
    jmp     @exit
@uppercase:
  CMP #'a'
  bcc @exit
  cmp #'z'+1
  bcs @exit
  and #$DF
@exit:
  cmp #$0D
  beq @noout

  jsr MONCOUT
@noout:
  RTS


ISCNTC:
  lda MAILBOX
  cmp #$3
  bne do_nothing
  stz MAILFLAG
  jmp STOP
do_nothing:
	CLC		; Carry clear if control C not pressed
	RTS
  
LOAD:
	RTS
	
SAVE:
	RTS
	
; Interrupts routines
IRQ_vec:
NMI_vec:
	RTI

