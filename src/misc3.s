.segment "CODE"


; ----------------------------------------------------------------------------
GET_UPPER:
        lda     INPUTBUFFERX,x
LF430:
        cmp     #'a'
        bcc     LF43A
        cmp     #'z'+1
        bcs     LF43A
LF438:
        sbc     #$1F
LF43A:
        rts
