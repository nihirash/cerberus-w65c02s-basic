LINE = $FE ; and $FF       ; ADDR (2 bytes), store a LINE ADDR
ROW = LINE - 1 
COL = ROW - 1

VRAM = $F800
MAILFLAG = $0200
MAILBOX  = $0201

MAX_ROW = 30
MAX_COL = 40
SPACE   = ' '

KBD_RET  = $0D  ; Return
KBD_BACK = 127  ; Backspace

APP_START = COLD_START