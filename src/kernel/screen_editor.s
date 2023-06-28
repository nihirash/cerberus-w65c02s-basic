;; This file contains very simple screen editor for BASIC

;; Entry point for screen editor
;; As result you'll got filled INPUTBUFFER
screen_editor:
    jmp @store_line_start
@loop:
    jsr editor_rdkey
    
    cmp #$0D
    beq send_line

    cmp #KBD_UP
    beq @store_line_start

    cmp #KBD_DN
    beq @store_line_start

    jmp @loop
@store_line_start:
    lda LINE
    sta LINE_START

    lda LINE+1
    sta LINE_START+1
    jmp @loop

;; Return key pressed - we should copy line from screen to inputbuffer
send_line:
    jsr erase_cursor ;; To prevent inverted symbols after editing line

    lda LINE
    cmp LINE_START ;; If address of line start did equal - two lines 
    beq @one_line

    lda #79       ;; 2 Lines command
    jmp @get_len
@one_line:
    lda #39       ;; single line command

;; Trying filter only effective data from screen - removing tailing
;; spaces. Without filtering you'll have no possibility remove line
@get_len:
    tay
@get_len_loop:
    lda (LINE_START), y
    cmp #SPACE
    bne @len_found
    dey
    bne @get_len_loop
;; If line empty no need for copying 
    beq @exit
;; When we found first significant symbol(not space) - stop here
@len_found:
    tya     ;; A - contains command lenght 
    ina     ;; Last character won't be lost
@start_copy:
    ldy #0
    ldx #0
@loop:
    pha
    lda (LINE_START), y     ;; Copy byte by byte from screen to 
    sta INPUTBUFFER, x      ;; INPUTBUFFER
    iny
    inx
    pla
    dea 
    bne @loop
@exit:
    jmp L29B9

MONRDKEY:
;; Read key for editor
editor_rdkey:
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