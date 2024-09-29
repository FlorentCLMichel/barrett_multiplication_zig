const std = @import("std");
const root = @import("root.zig");

pub fn main() !void {
    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();
    try stdout.print("Simple Barrett multiplication example.\n", .{});
    try bw.flush();

    // Initialize the Barrett multiplier
    const q: u32 = 65537;
    const multiplier = root.BarrettMultiplier(u32, u64).init(q);

    // Run one multiplication
    const a: u32 = 1000;
    const b: u32 = 10000;
    const c: u32 = 50000;
    const z = multiplier.mul(multiplier.mul(a, b), c);

    // Print the result
    try stdout.print("{d} × {d} × {d} = {d} mod {d}\n", .{ a, b, c, z, q });
    try bw.flush();
}
