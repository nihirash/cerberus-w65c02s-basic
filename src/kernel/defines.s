LINE = $FE ; and $FF       ; ADDR (2 bytes), store a LINE ADDR
ROW = LINE - 1 
COL = ROW - 1

LINE_START = $FA

VRAM = $F800
MAILFLAG = $0200
MAILBOX  = $0201

MAX_ROW = 30
MAX_COL = 40
SPACE   = ' '

KBD_RET  = $0D  ; Return
KBD_BACK = 127  ; Backspace

KBD_UP = 23
KBD_DN = 19
KBD_LF = 1
KBD_RT = 4

APP_START = COLD_START