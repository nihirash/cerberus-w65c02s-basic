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
ld65 -C cerberus.cfg tmp/cerberus.o -o out/b65.bin -Ln out/b65.lbl -vm -m out/b65.map --dbgfile out/b65.dbg 

# Run emulator if it placed here
if [ -e cerberus ]; then
    ./cerberus out/b65.bin run
fi
