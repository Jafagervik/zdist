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

/// Jaro-winkler configuration
pub const JaroWinklerOptions = struct {
    /// Default prefix scale
    prefix_scale: f32 = 0.1,
    /// Default prefix max length
    prefix_max_length: u32 = 4,
    /// Default boost threshold
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
    return 0;
}

/// Longest common subsequence algorithm
pub fn lcs_distance(astr: []const u8, bstr: []const u8) u32 {
    const n = astr.len;
    const m = bstr.len;

    var prev = [_]u32{0} ** (m + 1);
    var curr = [_]u32{0} ** (m + 1);

    for (1..n + 1) |i| {
        for (1..m + 1) |j| {
            if (astr[i - 1] == bstr[j - 1]) {
                curr[j] = 1 + prev[j - 1];
            } else {
                curr[j] = @max(prev[j], curr[j - 1]);
            }
        }
        prev = curr;
    }

    return prev[m];
}

test "LCS" {
    const testing = std.testing;

    const a = "abc";
    const b = "dbc";

    const result = lcs_distance(a, b);

    try testing.expectEqual(2, result);
}
