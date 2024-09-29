build:
	zig build

build-release:
	zig build --release=fast

build-help:
	zig build --help

clean: 
	rm -rf zig-out
	rm -rf .zig-cache
