;; User definable graphics

udg_table:
    .byte $20, $0A, $0B, $0C, $0D, $0E, $0F, $10, $11, $12, $13, $14, $15, $16, $17, $18
    .byte $19, $1A, $1B, $1C, $1D, $1E, $1F, $8A, $8B, $8C, $8D, $8E, $8F, $90, $91, $92
    .byte $93, $94, $95, $96, $97, $98, $99, $9A, $9B, $9C, $9D, $9E, $9F
udg_table_end:

udg_count = udg_table_end - udg_table

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
    lda UDG_DATA, y
    sta (KERN_PTR), y
    iny
    dex
    bne @copy
    rts

draw_tile:
    lda udg_table, x
    sta (KERN_PTR), y
    rts
