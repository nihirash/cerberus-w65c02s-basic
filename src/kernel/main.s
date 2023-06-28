.pc02
.segment "KERNEL"

.include "defines.s"
.include "service.s"
.include "screen.s"
.include "keyboard.s"

putc:
  phy
  cmp #8
  beq @backspace

  cmp #13
  beq @curdn

  cmp #10
  beq @home

  ldy COL
  sta (LINE),y
  inc COL
  
  cpy #MAX_COL-1
  beq @return
  
  ply
  rts
@home:
  stz COL
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
  ply
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
  ply
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
  ply
  rts

	

