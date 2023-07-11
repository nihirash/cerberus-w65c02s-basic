
file_save:
    lda #CMD_SAVE
    ldx #<filestart
    ldy #>filestart
    jsr bios_request
    
    lda DOS_FLAG
    beq @ok
    
    lda #<@err
    ldx #>@err
    jsr kprint
    rts

@ok:
    lda #<@save_ok
    ldx #>@save_ok
    jsr kprint
    rts
@save_ok:
    .byte "FILE SAVED", CR, LF, 0
@err:
    .byte "SAVE ERROR", CR, LF, 0