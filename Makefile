PKGS := core,async

.PHONY: all clean

all: main.native

main.native:
	corebuild $@ -pkgs $(PKGS)
