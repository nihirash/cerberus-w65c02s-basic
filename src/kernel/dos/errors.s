dos_print_error:
    lda BIOS_FLAG
    beq @ret
    and #$7f
    sta error_code
    ldy #$00
@search:
    lda dos_errors, y
    cmp #$ff
    beq @exit
    cmp error_code
    beq @show
@skip:
    iny
    lda dos_errors, y
    bne @skip
    iny
    bra @search
@show:
    iny
    lda dos_errors, y
    beq @exit
    jsr putc
    bra @show
@exit:
    jmp L2351
@ret:
    rts


dos_errors:
    .byte 3, CR, LF, "BIOS ERROR: UNKNOWN COMMAND ", 9, CR, LF, 0
    .byte 4, CR, LF, "BIOS ERROR: FILE NOT EXISTS ", 9, CR, LF, 0
    .byte 5, CR, LF, "BIOS ERROR: CAN'T OPEN FILE ", 9, CR, LF, 0
    .byte 8, CR, LF, "BIOS ERROR: FILE ALREADY EXISTS ", 9, CR, LF, 0
    .byte 9, CR, LF, "BIOS ERROR: ADDRESS ERROR ", 9, CR, LF, 0
    .byte $ff
