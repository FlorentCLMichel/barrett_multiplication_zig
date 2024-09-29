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
            const log_2_q: T1 = log2(T1, q);
            return .{
                .q = q,
                .q2 = @intCast(q),
                .k = compute_k(T1, T2, q, log_2_q),
                .log_2_q = log_2_q,
            };
        }

        pub fn mul(self: @This(), x: T1, y: T1) T1 {
            const x2: T2 = x;
            const y2: T2 = y;
            const z1: T2 = x2 * y2;
            const z2: T2 = z1 >> @truncate(self.log_2_q);
            const z3: T2 = z2 * self.k;
            const z4: T2 = z3 >> @truncate(self.log_2_q + 2);
            const z5: T2 = z1 - z4 * self.q;
            const c1: u2 = @as(u1, @bitCast(z5 >= self.q));
            const c2: u2 = @as(u1, @bitCast(z5 >= 2*self.q));
            return @truncate(z5 - (c1 + c2) * self.q);
        }
    };
}

// Floor logarithm of a non-negative intereg in base 2
fn log2(comptime T: type, x: T) T {
    var x_copy: T = x;
    var log_x: T = 0;
    while (x_copy > 1) {
        log_x += 1;
        x_copy >>= 1;
    }
    return log_x;
}

fn compute_k(comptime T1: type, comptime T2: type, q: T1, log_2_q: T1) T2 {
    const q_t2: T2 = @intCast(q);
    const one: T2 = 1;
    return (one << @truncate(2 * log_2_q + 2)) / q_t2;
}

export fn add(a: i32, b: i32) i32 {
    return a + b;
}

test "basic add functionality" {
    try testing.expect(add(3, 7) == 10);
}
