;; User definable graphics

def_udg:
    lda udg_table, x

    ldx #<FRAM
    stx KERN_PTR

    ldx #>FRAM
    stx KERN_PTR + 1
@count_loop:
    pha
    lda KERN_PTR
    clc
    adc #8
    sta KERN_PTR
    lda KERN_PTR + 1
    adc #0
    sta KERN_PTR + 1
    pla
    dea
    bne @count_loop

    ldy #0
    ldx #8
@copy:
    lda udg_data, y
    sta (KERN_PTR), y
    iny
    dex
    bne @copy
    rts

draw_tile:
    lda udg_table, x
    sta (KERN_PTR), y
    rts
