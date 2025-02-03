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

test "Hamming distance" {
    const testing = std.testing;

    try testing.expectEqual(@as(u32, 3), try hamming_distance("karolin", "kathrin"));
    try testing.expectEqual(@as(u32, 0), try hamming_distance("same", "same"));
    try testing.expectError(error.UnequalLength, hamming_distance("short", "longer"));
}

pub const JaroWinklerOptions = struct {
    prefix_scale: f32 = 0.1,
    prefix_max_length: u32 = 4,
    boost_threshold: f32 = 0.7,
};

/// Jaro-winkler distance between two strings with options
pub fn jaro_winkler_distance(astr: []const u8, bstr: []const u8, options: JaroWinklerOptions) f32 {
    _ = astr;
    _ = bstr;
    return options.boost_threshold * options.prefix_scale * @as(f32, @floatFromInt(options.prefix_max_length));
}

test "Jaro winkler" {
    const testing = std.testing;

    const a = "abc";
    const b = "def";

    const result = jaro_winkler_distance(a, b, .{});

    try testing.expectEqual(0.28, result);
}

/// Levenshtein distance between two strings
pub fn levenshtein_distance(astr: []const u8, bstr: []const u8) u32 {
    _ = astr;
    _ = bstr;
    // if (mem.eql(u8, astr, bstr)) return 0;
    //
    // const m = astr.len;
    // const n = bstr.len;
    //
    // var matrix = [_][n]u32{[_]u32{0} ** n} ** m;
    //
    // for (astr, 0..) |a, i| {
    //     for (bstr, 0..) |b, j| {
    //         _ = matrix;
    //     }
    // }
    //
    // return matrix[m - 1][n - 1];
}

/// Longest common subsequence algorithm
pub fn lcs_distance(astr: []const u8, bstr: []const u8) u32 {
    _ = astr;
    _ = bstr;

    return 0;
}
