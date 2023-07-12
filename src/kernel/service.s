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

  lda #CMD_LOAD
  ldx #<font_load
  ldy #>font_load
  jsr bios_request

  JMP APP_START

font_load:
  .word $F000
  .word $0000
  .byte "capitan.fnt",0

; Interrupts routines
IRQ_vec:
NMI_vec:
	RTI
