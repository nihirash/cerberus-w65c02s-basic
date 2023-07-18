.segment "EXTRA"

.include "cerberus_commands.s"

; CTRL-C handler
ISCNTC:
  lda MAILBOX
  cmp #KBD_BRK
  bne do_nothing
  stz MAILFLAG
  jmp STOP
do_nothing:
	CLC		; Carry clear if control C not pressed
	RTS

commit:
.byte "Basic built from commit: "
.include "basic_ver.s"