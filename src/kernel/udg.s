;; User definable graphics

udg_table:
    .byte $0A, $0B, $0C, $0D, $0E, $0F, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19
    .byte $1A, $1B, $1C, $1D, $1E, $1F, $8A, $8B, $8C, $8D, $8E, $8F, $90, $91, $92, $93
    .byte $94, $95, $96, $97, $98, $99, $9A, $9B, $9C, $9D, $9E, $9F
udg_table_end:

udg_count = udg_table_end - udg_table

draw_tile:
    phy
    tay
    lda udg_table, y
    ply
    jmp qput_c
