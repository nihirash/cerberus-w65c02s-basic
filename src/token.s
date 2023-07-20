		init_token_tables 

		keyword_rts "END", END, TOKEN_END
		keyword_rts "FOR", FOR, TOKEN_FOR
		keyword_rts "NEXT", NEXT, TOKEN_NEXT
		keyword_rts "DATA", DATA, TOKEN_DATA
		keyword_rts "INPUT", INPUT, TOKEN_INPUT
		keyword_rts "DIM", DIM, TOKEN_DIM
		keyword_rts "READ", READ, TOKEN_READ
		keyword_rts "LET", LET, TOKEN_LET
		keyword_rts "GOTO", GOTO, TOKEN_GOTO
		keyword_rts "RUN", RUN, TOKEN_RUN
		keyword_rts "IF", IF, TOKEN_IF
		keyword_rts "RESTORE", RESTORE, TOKEN_RESTORE
		keyword_rts "GOSUB", GOSUB, TOKEN_GOSUB
		keyword_rts "RETURN", POP, TOKEN_RETURN
		keyword_rts "REM", REM, TOKEN_REM
		keyword_rts "STOP", STOP, TOKEN_STOP
		keyword_rts "ON", ON, TOKEN_ON
		keyword_rts "WAIT", WAIT, TOKEN_WAIT
		keyword_rts "LOAD", LOAD, TOKEN_LOAD
		keyword_rts "SAVE", SAVE, TOKEN_SAVE
		keyword_rts "DEF", DEF, TOKEN_DEF
		keyword_rts "POKE", POKE, TOKEN_POKE
		keyword_rts "PRINT", PRINT, TOKEN_PRINT
		keyword_rts "CONT", CONT, TOKEN_CONT
		keyword_rts "LIST", LIST, TOKEN_LIST
		keyword_rts "CLEAR", CLEAR, TOKEN_CLEAR
		keyword_rts "VER", VER, TOKEN_VER
		keyword_rts "NEW", NEW, TOKEN_NEW
		keyword_rts "CLS", clear_screen, TOKEN_CLS
		keyword_rts "LOCATE", LOCATE, TOKEN_LOCATE
		keyword_rts "PSET", PSET, TOKEN_PSET
		keyword_rts "LINE", DRAW_LINE, TOKEN_LINE
		keyword_rts "CIRCLE", CIRCLE, TOKEN_CIRCLE
		keyword_rts "TILEDEF", DEF_TILE, TOKEN_TILEDEF
		keyword_rts "TILE", TILE, TOKEN_TILE
		keyword_rts "FILES", dos_dir, TOKEN_FILES
		keyword_rts "PAUSE", PAUSE, TOKEN_PAUSE
		keyword_rts "RESET", RESET_CPU, TOKEN_RESET
		keyword_rts "KILL", KILL, TOKEN_KILL
		keyword_rts "BLOAD", BLOAD, TOKEN_BLOAD
		keyword_rts "BSAVE", BSAVE, TOKEN_BSAVE
		keyword_rts "SOUND", SOUND, TOKEN_SOUND
		keyword_rts "SYS", SYS, TOKEN_SYS
		count_tokens

		keyword	"TAB(", TOKEN_TAB
		keyword	"TO", TOKEN_TO
		keyword	"FN", TOKEN_FN
		keyword	"SPC(", TOKEN_SPC
		keyword	"THEN", TOKEN_THEN
		keyword	"NOT", TOKEN_NOT
		keyword	"STEP", TOKEN_STEP
		keyword	"+", TOKEN_PLUS
		keyword	"-", TOKEN_MINUS
		keyword	"*", TOKEN_MUL
		keyword	"/", TOKEN_DIV
		keyword	"^", TOKEN_POW
		keyword	"AND", TOKEN_AND
		keyword	"OR", TOKEN_OR
		keyword	">", TOKEN_GREATER
		keyword	"=", TOKEN_EQUAL
		keyword	"<", TOKEN_LESS

        .segment "VECTORS"
UNFNC:

		keyword_addr "SGN", SGN, TOKEN_SGN
		keyword_addr "INT", INT, TOKEN_INT
		keyword_addr "ABS", ABS, TOKEN_ABS
		keyword_addr "KEY$", KEYSTR, TOKEN_KEY
		keyword_addr "FRE", FRE, TOKEN_FRE
		keyword_addr "POS", POS, TOKEN_POS
		keyword_addr "SQR", SQR, TOKEN_SQR
		keyword_addr "RND", RND, TOKEN_RND
		keyword_addr "LOG", LOG, TOKEN_LOG
		keyword_addr "EXP", EXP, TOKEN_EXP
.segment "VECTORS"
UNFNC_COS:
		keyword_addr "COS", COS, TOKEN_COS
.segment "VECTORS"
UNFNC_SIN:
		keyword_addr "SIN", SIN, TOKEN_SIN
.segment "VECTORS"
UNFNC_TAN:
		keyword_addr "TAN", TAN, TOKEN_TAN
.segment "VECTORS"
UNFNC_ATN:
		keyword_addr "ATN", ATN, TOKEN_ATN
		keyword_addr "PEEK", PEEK, TOKEN_PEEK
		keyword_addr "LEN", LEN, TOKEN_LEN
		keyword_addr "STR$", STR, TOKEN_STR
		keyword_addr "VAL", VAL, TOKEN_VAL
		keyword_addr "ASC", ASC, TOKEN_ASC
		keyword_addr "CHR$", CHRSTR, TOKEN_CHR
		keyword_addr "LEFT$", LEFTSTR, TOKEN_LEFTSTR
		keyword_addr "RIGHT$", RIGHTSTR, TOKEN_RIGHTSTR
		keyword_addr "MID$", MIDSTR, TOKEN_MIDSTR
		keyword	"GO", TOKEN_GO
        .segment "KEYWORDS"
		.byte   0

        .segment "VECTORS"
MATHTBL:
        .byte   $79
        .word   FADDT-1
        .byte   $79
        .word   FSUBT-1
        .byte   $7B
        .word   FMULTT-1
        .byte   $7B
        .word   FDIVT-1
        .byte   $7F
        .word   FPWRT-1
        .byte   $50
        .word   TAND-1
        .byte   $46
        .word   OR-1
        .byte   $7D
        .word   NEGOP-1
        .byte   $5A
        .word   EQUOP-1
        .byte   $64
        .word   RELOPS-1
