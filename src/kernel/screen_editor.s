;; This file contains very simple screen editor

;; Entry point for screen editor
;; As result you'll got filled INPUTBUFFER
screen_editor:
    jmp @store_line_start
@loop:
    jsr MONRDKEY
    
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
    ina
@start_copy:
    ldy #0
    ldx #0
@loop:
    pha
@line_load:
    lda (LINE_START), y
    and #$7f
    sta INPUTBUFFER, x
    iny
    inx
    pla
    dea 
    bne @loop
@exit:
    jmp L29B9

