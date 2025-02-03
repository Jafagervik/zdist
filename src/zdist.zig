const std = @import("std");
const mem = std.mem;

/// Hamming distance between two strings
pub fn hamming_distance(astr: []const u8, bstr: []const u8) !u32 {
    if (astr.len != bstr.len) return error.UnequalLength;

    if (mem.eql(u8, astr, bstr)) return 0;

    var dist: u32 = 0;

    for (astr, bstr) |a, b| {
        if (a != b) dist += 1;
    }

    return dist;
}

test "hamming_distance" {
    const testing = std.testing;

    try testing.expectEqual(@as(u32, 3), try hamming_distance("karolin", "kathrin"));
    try testing.expectEqual(@as(u32, 0), try hamming_distance("same", "same"));
    try testing.expectError(error.UnequalLength, hamming_distance("short", "longer"));
}
