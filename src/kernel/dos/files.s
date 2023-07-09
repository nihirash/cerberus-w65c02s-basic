file_save:
;; Just printing about what and where will be saved
    lda #<@message1
    ldx #>@message1
    jsr kprint
    
    lda #<filename
    ldx #>filename
    jsr kprint

    lda #<@message2
    ldx #>@message2
    jsr kprint

    lda filestart + 1
    jsr print_hex

    lda filestart
    jsr print_hex

    lda #<@message3
    ldx #>@message3
    jsr kprint

    lda filesize + 1
    jsr print_hex

    lda filesize
    jsr print_hex
    
    rts

@message1:
    .byte CR, LF, "File ", 0
@message2:
    .byte CR,LF, "From 0x", 0
@message3:
    .byte CR,LF,"With size 0x", 0