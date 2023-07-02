;; Tables and vars

;; Point drawing vars
character_table:
    .byte $00, $01, $02, $03, $04, $05, $06, $07, $87, $86, $85, $84, $83, $82, $81, $80
pixels_table:
    .byte $01, $02, $04, $08
tile_number:
    .byte 0
lgr_y:
    .byte 0

;; Line drawing vars
line_x1:    .byte 0
line_y1:    .byte 0
line_x2:    .byte 0
line_y2:    .byte 0

;; Runtime line drawing vars
line_dx:    .byte 0
line_dy:    .byte 0
line_xi:    .byte 0
line_yi:    .byte 0
line_ai:    .byte 0
line_bi:    .byte 0
line_d:     .byte 0