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
  
  JMP APP_START

ISCNTC:
  lda MAILBOX
  cmp #$6 
  bne do_nothing
  stz MAILFLAG
  jmp STOP
do_nothing:
	CLC		; Carry clear if control C not pressed
	RTS

; Interrupts routines
IRQ_vec:
NMI_vec:
	RTI
