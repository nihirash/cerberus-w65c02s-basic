;; Directory call stub
dos_dir:
    lda #<DOS_DIR_EMPTY
    ldx #>DOS_DIR_EMPTY
    jmp kprint
