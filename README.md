# Barrett multiplication in Zig

This is a very simple implementation of the [Barrett modular muliplication algorithm](https://en.wikipedia.org/wiki/Barrett_reduction) in [Zig](https://ziglang.org/). It is designed for simplicity rather than performance; in particular, it does not use vectorised operations which could significantly increase the throughput.

## Requirements

* [Zig](https://ziglang.org/) version 0.13.0
* Optionally Make

## Build

1. Ensure the Zig compiler is in your `PATH`
2. Run `zig build` (or `make build`)
