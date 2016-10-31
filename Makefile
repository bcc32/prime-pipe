PKGS := core,async
TARGETS := main.native

.PHONY: all clean always

all: $(TARGETS)

clean:
	rm -rf _build $(TARGETS)

main.native: always
	corebuild $@ -pkgs $(PKGS)
