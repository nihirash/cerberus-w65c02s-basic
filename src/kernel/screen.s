lines_table:
  .word $f800 ; 0
  .word $f828 ; 1
  .word $f850 ; 2
  .word $f878 ; 3
  .word $f8a0 ; 4
  .word $f8c8 ; 5
  .word $f8f0 ; 6
  .word $f918 ; 7
  .word $f940 ; 8 
  .word $f968 ; 9 
  .word $f990 ; 10
  .word $f9b8 ; 11
  .word $f9e0 ; 12
  .word $fa08 ; 13
  .word $fa30 ; 14
  .word $fa58 ; 15
  .word $fa80 ; 16
  .word $faa8 ; 17
  .word $fad0 ; 18
  .word $faf8 ; 19 
  .word $fb20 ; 20
  .word $fb48 ; 21
  .word $fb70 ; 22
  .word $fb98 ; 23
  .word $fbc0 ; 24
  .word $fbe8 ; 25
  .word $fc10 ; 26
  .word $fc38 ; 27
  .word $fc60 ; 28
  .word $fc88 ; 29

; A - line number
; AX - address of line start
get_line_address:
  phy
  clc
  rol ; * 2
  tay ; Y is offset in table
  ldx lines_table+1, y
  lda lines_table, y
  ply
  rts

;; Quick put char - without control codes
qput_c:
  phy
  ldy COL
  sta (LINE),y
  inc COL
  cpy #MAX_COL-1
  beq @return
  ply
  rts
@return:
  stz COL
  lda ROW
  cmp #MAX_ROW-1
  bne @not_last_row
  jsr scroll_up
  ply
  rts
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
  ply
  rts


putc:
  phy
  pha

  cmp #13
  beq @curdn

  cmp #KBD_DN
  beq @curdn

  cmp #KBD_LF
  beq @move_left

  cmp #KBD_RT
  beq @move_right

  cmp #10
  beq @home

  cmp #KBD_UP
  beq @move_up

  ldy COL
  sta (LINE),y
@mvy_next:
  inc COL
  
  cpy #MAX_COL-1
  beq @return

  pla
  ply
  rts
@move_right:
    jsr erase_cursor
    lda COL
    jmp @mvy_next
@move_left:
    jsr erase_cursor
    lda COL
    beq @exit
    dea
    sta COL
    jmp @exit
@move_up:
    jsr erase_cursor
    lda ROW
    beq @exit
    
    lda LINE
    clc
    sbc #MAX_COL-1
    sta LINE

    lda LINE+1
    sbc #0
    sta LINE+1

    dec ROW
    jmp @exit

@home:
  stz COL
@exit:
  pla
  ply
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
  jmp @exit
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
  jmp @exit


erase_cursor:
  pha
  phy

  ldy COL
  lda (LINE), y
  and #$7f
  sta (LINE),y
  
  ply
  pla
  rts

put_cursor:
  pha
  phy
  ldy COL
  lda (LINE), y
  ora #$80
  sta (LINE),y
  ply
  pla
  rts

;; Set cursor position A, X
gotoxy:
  cmp #MAX_ROW
  bcc @cont1
  rts
@cont1:
  cpx #MAX_COL
  bcc @cont2
  rts
@cont2:
  phx
  pha

  pla
  sta ROW
  jsr get_line_address
  sta LINE
  stx LINE + 1

  pla
  sta COL
  rts

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
  rts

scroll_up:
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
