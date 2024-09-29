const std = @import("std");
const testing = std.testing;

/// Defines the Barrett multiplier
pub fn BarrettMultiplier(
    /// Type for the inputs and output
    comptime T1: type,
    /// Type for intermediate results
    comptime T2: type,
) type {
    return struct {
        q: T1,
        q2: T2, // q cast as a T2
        k: T2,
        log_2_q: T1,

        pub fn init(q: T1) BarrettMultiplier(T1, T2) {
            return .{
                .q = q,
                .q2 = @intCast(q),
                .k = 0, // TODO: update
                .log_2_q = 0, // TODO: update
            };
        }

        // TODO: update
        pub fn mul(self: @This(), x: T1, y: T1) T1 {
            const x2: T2 = @intCast(x);
            const y2: T2 = @intCast(y);
            return @intCast((x2 * y2) % self.q2);
        }
    };
}

export fn add(a: i32, b: i32) i32 {
    return a + b;
}

test "basic add functionality" {
    try testing.expect(add(3, 7) == 10);
}
