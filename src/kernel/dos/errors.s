dos_print_error:
    lda DOS_FLAG
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
    .byte 3, CR, LF, "UNKNOWN COMMAND", CR, LF, 0
    .byte 4, CR, LF, "FILE NOT EXISTS", CR, LF, 0
    .byte 5, CR, LF, "CAN'T OPEN FILE", CR, LF, 0
    .byte 8, CR, LF, "FILE ALREADY EXISTS", CR, LF, 0
    .byte 9, CR, LF, "ADDRESS ERROR", CR, LF, 0
    .byte $ff
