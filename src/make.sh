if [ ! -d tmp ]; then
	mkdir tmp
fi

i=cerberus

ca65 --cpu 65C02 -t none -D $i msbasic.s -o tmp/$i.o -l tmp/$i.lst -g  --list-bytes 0 &&
ld65 -C $i.cfg tmp/$i.o -o tmp/$i.bin -Ln tmp/$i.lbl -vm -m tmp/$i.map --dbgfile tmp/$i.dbg

