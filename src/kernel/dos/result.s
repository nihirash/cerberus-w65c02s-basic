; A - cmd
; XY - ADDR
bios_request:
    stx DOS_DATA
    sty DOS_DATA+1
    sta DOS_FLAG
wait_bios_result:
    lda DOS_FLAG
    beq @ok
    bmi @ok
    bra wait_bios_result
@ok:
    rts

    