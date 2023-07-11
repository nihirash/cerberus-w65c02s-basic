;; Directory
dos_dir:
    lda #CMD_CAT_OPEN
    ldx #<dir_entry
    ldy #>dir_entry
    jsr bios_request
@loop:
    lda #CMD_CAT_ENTRY
    ldx #<dir_entry
    ldy #>dir_entry
    jsr bios_request
@wait:
    lda DOS_FLAG
    bmi @exit

    lda #<@str
    ldx #>@str
    jsr kprint

    lda #<dir_filename
    ldx #>dir_filename
    jsr kprint

    lda #'"'
    jsr putc

    lda #20
    sta COL

    lda #<@size
    ldx #>@size
    jsr kprint

    lda dir_entry+1
    jsr print_hex

    lda dir_entry
    jsr print_hex

    bra @loop
@exit:
    rts
@str:
    .byte CR,LF,"     ",$22,0
@size:
    .byte ": REM size ", 0
crlf:
    .byte CR, LF, 0