; A - cmd
; XY - ADDR
bios_request:
    stx BIOS_PTR
    sty BIOS_PTR+1
    sta BIOS_FLAG
wait_bios_result:
    lda BIOS_FLAG
    beq @ok
    bmi @ok
    bra wait_bios_result
@ok:
    rts

    