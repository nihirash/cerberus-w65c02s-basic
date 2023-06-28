    jmp Reset

kernel_ver:
.byte CR, LF
.byte "KITTY Kernel by Nihirash"
.byte CR, LF
.byte 0

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
;; Install our font
copy_font:
  stz 0
  lda #>FRAM
  sta 1

  stz 2
  lda #>RAMSTART2
  sta 3
  
  lda #8
@loop:
  pha
  lda #0
  ldy #0
@copyblock:
  lda (2), y
  sta (0), y
  iny
  bne @copyblock
  
  inc 1
  inc 3
  pla 
  dea 
  bne @loop

  JMP APP_START

; Interrupts routines
IRQ_vec:
NMI_vec:
	RTI
