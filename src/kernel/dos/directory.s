;; Directory
dos_dir:
    stz list_cnt

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
    lda BIOS_FLAG
    bmi @exit
    
    jsr check_scroll
    
    lda MAILBOX
    cmp #KBD_BRK
    beq @exit

    lda #<@str
    ldx #>@str
    jsr kprint

    lda #<dir_filename
    ldx #>dir_filename
    jsr kprint

    lda #'"'
    jsr putc

    lda #26
    sta COL

    lda #<@size
    ldx #>@size
    jsr kprint

    lda dir_entry+1
    jsr print_hex

    lda dir_entry
    jsr print_hex

    lda #<crlf
    ldx #>crlf
    jsr kprint

    bra @loop
@exit:
    rts
@str:
    .byte "     ",$22,0
@size:
    .byte ":REM ", 0
crlf:
    .byte CR, LF, 0