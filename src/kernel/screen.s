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
