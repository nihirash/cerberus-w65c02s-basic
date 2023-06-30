; configuration
CONFIG_2C := 1


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

RAMEND      := $EFFF

; constants
SPACE_FOR_GOSUB := $3E
STACK_TOP		:= $FC
WIDTH			:= 80
WIDTH2			:= 70

; magic memory locations
ENTROPY = $F821

; monitor functions
MONRDKEY        := line_rdkey
MONCOUT         := putc
;CHKIN           := do_nothing
;CHKOUT          := do_nothing
CLALL           := do_nothing
;CHRIN           := do_nothing
;CLRCH           := do_nothing
;CLOSE           := do_nothing
;OPEN            := do_nothing
;SYS             := do_nothing
VERIFY          := do_nothing
;LE7F3           := do_nothing
;LOAD            := eb_load
;SAVE            := eb_save
;L2420           := MONCOUT
;L2423           := MONCOUT