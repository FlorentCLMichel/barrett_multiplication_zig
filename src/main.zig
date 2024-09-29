const std = @import("std");
const root = @import("root.zig");

pub fn main() !void {
    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();
    try stdout.print("Simple Barrett multiplication example.\n", .{});
    try bw.flush();

    // Initialize the Barrett multiplier
    const q: u32 = (1 << 30) - (1 << 18) + 1;
    const multiplier = root.BarrettMultiplier(u32, u64).init(q);

    // Evaluate (q-1)! modulo q
    var y: u32 = 1;
    for (2 .. q) |i| {
        y = multiplier.mul(y, @truncate(i));
    }

    // Print the result
    try stdout.print("{d}! = {d} mod {d}\n", .{ q-1, y, q });
    try bw.flush();
}
