;; Deletes file
file_kill:
    lda #CMD_DEL
    ldx #<filename
    ldy #>filename
    jsr bios_request
    jmp dos_print_error

file_load:
    lda #CMD_LOAD
    ldx #<filestart
    ldy #>filestart
    jsr bios_request
    lda BIOS_FLAG

    beq @ok
    jmp dos_print_error
@ok:
    rts

;; Stores file on disk
file_save:
    lda #CMD_SAVE
    ldx #<filestart
    ldy #>filestart
    jsr bios_request
    
    lda BIOS_FLAG
    beq @ok
    jmp dos_print_error

@ok:
    rts