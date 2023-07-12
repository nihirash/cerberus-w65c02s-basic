;; Tables and vars

;; Temp vars in free space of vram
.segment "VRAMVARS"
filestart:
    .res 2
filesize:
    .res 2
filename:
    .res 13

dir_entry:
    .res 4
dir_filename:
    .res 13

error_code:
    .res 1
.segment "KERNEL"