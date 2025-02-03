# Zdist

String distance library written in zig

## Algorithms

- [x] Hamming distance
- [ ] Levenshtein distance
- [ ] Longest common subsequence (LCS) distance
- [ ] Jaro-Winkler distance

## Usage

```zig
const std = @import("std");
const zdist =  @import("zdist");

pub fn main() !void {
    const a_str = "abcdef";
    const b_str = "cdefgh";

    const distance = zdist.lcs_distance(a_str, b_str);

    std.debug.println("Distance between {s} and {s} is: {d}\n", .{a_str, b_str, distance});
}
```

## Install (Per 0.14 beta)

Run this command in the parent directory of your project

```sh
zig fetch --save https://github.com/Jafagervik/zdist/tarball/v0.1.0
```

Or alternatively use master or another version

Then add these lines to build.zig before b.installArtifact(exe)

```zig
const zdist = b.dependency("zdist", .{});

exe.root_module.addImport("zdist", zdist.module("zdist"));

```
