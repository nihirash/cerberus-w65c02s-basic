    .pc02
    .segment "HEADER"
TOKEN_SYS=$AA
;; Start of Basic program
    .word next_line     ;; Link to next line
    .word 0              ;; Line number
    .byte TOKEN_SYS, 32  ;; "SYS" token and space 
    .byte "12044" ;; Address of code start
    .byte 0              ;; END of line
next_line:
    .word 00             ;; No link
    .byte 0              ;; No code
basic_end: