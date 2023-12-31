#!/bin/bash -e

if [ ! -d tmp ]; then
	mkdir tmp
fi

if [ ! -d out ]; then
	mkdir out
fi


git log -1 --pretty=format:".byte \"%h\",CR, LF," >basic_ver.s
echo "\"Build date: `date -I`\", CR, LF, CR, LF, 0">>basic_ver.s
ca65 --cpu 65C02 -t none -D cerberus msbasic.s -o tmp/cerberus.o -l tmp/cerberus.lst -g  --list-bytes 0
ld65 -C cerberus.cfg tmp/cerberus.o -o out/basic65.bin -Ln out/basic65.lbl -vm -m out/basic65.map --dbgfile out/basic65.dbg 

./send.py out/basic65.bin /dev/cu.usbserial-A50285BI