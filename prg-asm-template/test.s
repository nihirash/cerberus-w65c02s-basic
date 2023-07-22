    .include "header.i"
.segment "CODE"
    lda #0
    ldy #0
@loop:
    sta $f900, y
    iny
    ina
    bne @loop

    rts