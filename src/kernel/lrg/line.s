;; Bresenham's line drawing algorithm 
;; All arguments should be stored in vars
draw_line:
    lda line_x1
    cmp line_x2
    bcc @x1mx2_
    jmp @x1wx2
 @x1mx2_:
    lda #1
    sta line_xi

    lda line_x2
    sec
    sbc line_x1
    sta line_dx

    jmp @y1my2
@x1wx2:
    lda #255
    sta line_xi

    lda line_x1
    sec
    sbc line_x2
    sta line_dx
@y1my2:
    lda line_y1
    cmp line_y2
    bcc @y1my2_
    jmp @y1wy2
@y1my2_:
    lda #1
    sta line_yi

    lda line_y2
    sec 
    sbc line_y1
    sta line_dy
    jmp @skok
@y1wy2:
    lda #255
    sta line_yi

    lda line_y1
    sec
    sbc line_y2
    sta line_dy
@skok:
    lda line_y1
    ldx line_x1
    jsr plot

    lda line_dx
    cmp line_dy
    bcc @wiod_oy
@wiod_ox:
    lda line_dy
    sec
    sbc line_dx
    clc
    rol
    sta line_ai

    lda line_dy
    clc
    rol 
    sta line_bi

    sec
    sbc line_dx
    sta line_d
@whx1rx2:
    lda line_x1
    cmp line_x2
    beq @end

    lda line_d
    cmp #$00
    beq @a
    bpl @else
@a:
    clc
    adc line_bi
    sta line_d
    jmp @reszta
@end:
    rts
@else:
    lda line_y1
    clc
    adc line_yi
    sta line_y1

    lda line_d
    clc
    adc line_ai
    sta line_d
@reszta:
    lda line_x1
    clc
    adc line_xi
    sta line_x1

    lda line_y1
    ldx line_x1
    jsr plot
    
    jmp @whx1rx2
@wiod_oy:
    lda line_dx
    sec
    sbc line_dy
    clc
    rol
    sta line_ai

    lda line_dx
    clc
    rol 
    sta line_bi

    sec
    sbc line_dy
    sta line_d
@why1ry2:
    lda line_y1
    cmp line_y2
    beq @end
    
    lda line_d
    cmp #$00
    beq @b
    bpl @elsey
@b:
    lda line_d
    clc
    adc line_bi
    sta line_d
    jmp @resztay

@elsey:
    lda line_x1
    clc
    adc line_xi
    sta line_x1

    lda line_d
    clc
    adc line_ai
    sta line_d
@resztay:
    lda line_y1
    clc
    adc line_yi
    sta line_y1

    ldx line_x1
    jsr plot
    jmp @why1ry2
