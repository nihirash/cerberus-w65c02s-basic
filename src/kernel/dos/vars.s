;; Tables and vars

;; Temp vars in free space of vram
.segment "VRAMVARS"
filestart:
    .res 2
filesize:
    .res 2
filename:
    .res 40

.segment "KERNEL"