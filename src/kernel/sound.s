beep:
    lda #CMD_BEEP
    ldx #<beep_freq
    ldy #>beep_freq
    jmp bios_request