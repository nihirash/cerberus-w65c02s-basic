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

;; Read key
MONRDKEY:
    jsr put_cursor
@loop:
    lda MAILFLAG
    beq @loop

    stz MAILFLAG
    lda MAILBOX
;; Replacements
    CMP     #$0A
    bne     @del
    LDA     #$0D
    jmp     @noout
@del:
    CMP     #KBD_BACK
    bne     @exit
    LDA     #$08
    jmp     @exit
@exit:
  cmp #$0D
  beq @noout
  ;; Echo
  jsr MONCOUT
@noout:
  rts