const std = @import("std");

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = &arena.allocator;

    var in = std.io.getStdIn().reader();
    var out = std.io.getStdOut().writer();

    try out.print("How many times do you want to commit? \n", .{});
    const ip = try in.readInt(u32, 10);
    
    try out.print("Auto git push when commited? (y/n) \n", .{});
    var autoPush: [2]u8 = undefined;
    try in.readUntilDelimiterOrEof(&autoPush, '\n');

    var i: u32 = 0;
    while (i < ip) : (i += 1) {
        const commit_cmd = try std.fmt.allocPrint(allocator, "git commit --allow-empty -m \"Commit {} of {}\"\n", .{ i, ip });
        defer allocator.free(commit_cmd);

        const commit_res = try std.os.system(commit_cmd);
        if (commit_res != 0) {
            std.debug.warn("Commit command failed with exit code {}\n", .{commit_res});
        }
    }

    try out.print("Commited {} times\n", .{ip});

    if (autoPush[0] == 'y') {
        const push_res = try std.os.system("git push");
        if (push_res != 0) {
            std.debug.warn("Push command failed with exit code {}\n", .{push_res});
        }
    }
}
