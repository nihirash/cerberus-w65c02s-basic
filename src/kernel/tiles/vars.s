
udg_table:
    .byte $20, $08, $09, $0A, $0B, $0C, $0D, $0E, $0F, $10, $11, $12, $13, $14, $15, $16
    .byte $17, $18, $19, $1A, $1B, $1C, $1D, $1E, $1F, $8A, $8B, $8C, $8D, $8E, $8F, $90
    .byte $91, $92, $93, $94, $95, $96, $97, $98, $99, $9A, $9B, $9C, $9D, $9E, $9F, $00
udg_table_end:

udg_count = udg_table_end - udg_table


.segment "VRAMVARS"
udg_data:
    .res 8

.segment "KERNEL"