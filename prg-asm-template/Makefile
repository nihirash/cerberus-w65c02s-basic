TARGETS := test.prg

ASM := ca65
LINK := ld65

ASMFLAGS := -t none --cpu 65C02
LDFLAGS := -C prg.cfg 

all: $(TARGETS)

.PHONY: all

%.o: %.s header.i
		$(ASM) $(ASMFLAGS) $< -o $@

%.prg: %.o prg.cfg
		$(LINK) $(LDFLAGS) $< -o $@

clean:
		rm -rf *.o *.prg
