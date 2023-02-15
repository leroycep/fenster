const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addStaticLibrary(.{
        .name = "fenster",
        .target = target,
        .optimize = optimize,
    });
    lib.installHeader("fenster.h", "fenster.h");
    lib.addCSourceFile("fenster.h", &[_][]const u8{});
    if (lib.target.isDarwin()) {
        lib.linkFramework("Cocoa");
    } else if (lib.target.isWindows()) {
        lib.linkSystemLibrary("gdi32");
    } else {
        lib.linkSystemLibrary("X11");
    }
    lib.linkLibC();
    lib.install();
}
