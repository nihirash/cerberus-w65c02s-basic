circle:
    lda circle_r
    bne @c1 ; If not single point continue usual routine
    lda circle_y
    ldx circle_x
    jmp plot
@c1:
    stz circle_py

    lda circle_r
    sta circle_px
@loop:
    jsr circle_plots
    inc circle_py

    lda circle_t1
    clc
    adc circle_py
    sta circle_t1

    lda circle_t1
    sec
    sbc circle_px
    sta circle_t2

    lda circle_t2
    bmi @skip
    sta circle_t1
    dec circle_px

@skip:
    lda circle_px
    sec
    sbc circle_py
    bvc @skipeor
    eor #$80
@skipeor:
    bpl @loop

    rts

circle_plots:

;; X, Y
    lda circle_x
    clc
    adc circle_px
    tax 

    lda circle_y
    clc
    adc circle_py

    jsr plot
;; Y, X
    lda circle_x
    clc
    adc circle_py
    tax 
    
    lda circle_y
    clc
    adc circle_px

    jsr plot
;; Y, -X
    lda circle_x
    clc
    adc circle_py
    tax 
    
    lda circle_y
    sec
    sbc circle_px

    jsr plot
;; -X, Y
    lda circle_x
    sec
    sbc circle_px
    tax 
    
    lda circle_y
    clc
    adc circle_py

    jsr plot
;; X, -Y
    lda circle_x
    clc
    adc circle_px
    tax 
    
    lda circle_y
    sec
    sbc circle_py
    jsr plot
;; -Y, X
    lda circle_x
    sec
    sbc circle_py
    tax 
    
    lda circle_y
    clc
    adc circle_px
    jsr plot
;; -X, -Y 
    lda circle_x
    sec
    sbc circle_px
    tax 
    
    lda circle_y
    sec
    sbc circle_py
    jsr plot
;; -Y, -X
    lda circle_x
    sec
    sbc circle_py
    tax 
    
    lda circle_y
    sec
    sbc circle_px
    jmp plot