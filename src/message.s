.segment "CODE"

QT_ERROR:
        .byte   " ERROR ", 9, CR, LF, 0
QT_IN:
        .byte   " IN ", 0
QT_OK:
        .byte   CR, LF,"READY ", 8,CR,LF, 0
QT_BREAK:
        .byte CR,LF,"BREAK", 0
