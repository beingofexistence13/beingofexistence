const std = @import("std");

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    var allocator = &arena.allocator;

    var args = [_][]const u8{ "git", "commit", "--allow-empty", "-m" };

    for (std.range.iota(usize, 0, 1000000)) |i| {
        const message = try std.fmt.allocPrint(allocator, "commit number {}", .{i});
        defer allocator.free(message);

        args[3] = message;

        var child = try std.ChildProcess.init(args, allocator);
        defer child.deinit();

        try child.spawn();
        const exit_code = try child.wait();

        if (exit_code != 0) {
            std.debug.print("Commit failed with exit code {}\n", .{exit_code});
            return;
        }
    }
}
