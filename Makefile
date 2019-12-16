TARGET:=gametunes
SRCS=$(wildcard src/*.asm)
INCS=$(wildcard src/*.inc)
PNGS=$(wildcard data/*.png)
OBJS=$(patsubst src/%.asm, build/%.o, $(SRCS))
GFXS=$(patsubst data/%.png, data/%.bin, $(PNGS))

.SECONDARY: $(OBJS) $(GFXS)
.PHONY: all gfx run debug

all: build/$(TARGET).gbc

gfx: $(GFXS)

run: build/$(TARGET).gbc
	mgba -2 $<

debug: build/$(TARGET).gbc
	mgba -2 -d $<

data/%.bin: data/%.png
	rgbgfx -o $@ $<


build/%.o: src/%.asm $(GFXS) $(INCS)
	@mkdir -p build/
	rgbasm -i src/ -i data/ -p 0xff -o $@ $<

build/%.gbc: $(OBJS)
	@mkdir -p build/
	rgblink -p 0xff -n build/$*.sym -m build/$*.map -o $@ $(OBJS)
	rgbfix -Cjv -i XXXX -k XX -l 0x33 -m 0x1A -r 0x04 -p 0 -r 1 -t $(TARGET) $@

clean:
	rm -r build/
