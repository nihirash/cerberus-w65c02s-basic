.pc02
;; KEY$() keyword
KEYSTR:
        jsr     CONINT
        txa
        beq     @nowait
@wait:
        lda MAILFLAG
        beq @wait
@nowait:
        lda MAILFLAG
        bne @store
        lda     #$00
        jsr     STRSPA
        pla
        pla
        jmp     PUTNEW
@store:
        lda     #$01
        jsr     STRSPA
        
        jsr     inkey
        
        ldy     #$00
        sta     (FAC+1),y
        pla
        pla
        jmp     PUTNEW


;; Print kernel and basic versions
VER:
        jsr KERNEL_VER
        lda     #<commit
        ldy     #>commit
        jmp     GOSTROUT2

;; TODO: Implement
LOAD:
	RTS

;; TODO: Implement	
SAVE:
	RTS