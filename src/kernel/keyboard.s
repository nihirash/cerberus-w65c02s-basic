;; Non blocking reading key
inkey:
    lda MAILFLAG
    beq @exit

    stz MAILFLAG
    lda MAILBOX

    CMP #'a'
    bcc @exit
    cmp #'z'+1
    bcs @exit
    and #$DF
@exit:
    rts
