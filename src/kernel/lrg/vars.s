;; Tables and vars

;; Point drawing vars
character_table:
    .byte $00, $01, $02, $03, $04, $05, $06, $07, $87, $86, $85, $84, $83, $82, $81, $80
pixels_table:
    .byte $01, $02, $04, $08

;; Temp vars in free space of vram
.segment "VRAMVARS"
tile_number:
    .res 1
lgr_y:
    .res 1
;; Line drawing vars
line_x1:    .res 1
line_y1:    .res 1
line_x2:    .res 1
line_y2:    .res 1

;; Runtime line drawing vars
line_dx:    .res 1
line_dy:    .res 1
line_xi:    .res 1
line_yi:    .res 1
line_ai:    .res 1
line_bi:    .res 1
line_d:     .res 1

;; Circle drawing vars
circle_x:   .res 1
circle_y:   .res 1
circle_r:   .res 1

circle_d:   .res 1
circle_px:  .res 1
circle_py:  .res 1
circle_t1:  .res 1
circle_t2:  .res 1

.segment "KERNEL"