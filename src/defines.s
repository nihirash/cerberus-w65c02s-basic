
; zero page
ZP_START1 = $00
ZP_START2 = $15
ZP_START3 = $0A
ZP_START4 = $63

; extra/override ZP variables
CURDVC			:= $000E
TISTR			:= $008D
Z96				:= $0096
TXPSV			:= LASTOP
USR				:= GORESTART ; XXX

;; Extra tokens table flag
EXTRA_TABLE_FLAG := $FCB0

RAMEND      := $EFFF

; constants
SPACE_FOR_GOSUB := $3E
STACK_TOP		:= $FE
WIDTH			:= 80
WIDTH2			:= 70

; magic memory locations
ENTROPY = $F821

; monitor functions
MONRDKEY        := line_rdkey
MONCOUT         := putc
CLALL           := do_nothing

BYTES_FP		:= 5
BYTES_PER_ELEMENT := BYTES_FP
BYTES_PER_VARIABLE := BYTES_FP+2
MANTISSA_BYTES	:= BYTES_FP-1
BYTES_PER_FRAME := 2*BYTES_FP+8
FOR_STACK1		:= 2*BYTES_FP+5
FOR_STACK2		:= BYTES_FP+4

MAX_EXPON = 10

STACK           := $0100
STACK2          := STACK
INPUTBUFFERX = INPUTBUFFER & $FF00

CR=13
LF=10

CRLF_1 := CR
CRLF_2 := LF



