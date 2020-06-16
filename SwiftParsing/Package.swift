// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftParsing",
    products: [
        .executable(name: "SwiftParsing", targets: ["SwiftParsing"]),
    ],
    dependencies: [
        .package(name: "SwiftSyntax", url: "https://github.com/apple/swift-syntax.git", .exact("0.50200.0")),
        .package(name: "SwiftSemantics", url: "https://github.com/SwiftDocOrg/SwiftSemantics", .exact("0.1.0")),
    ],
    targets: [
        .target(name: "SwiftParsing", dependencies: ["SwiftSyntax", "SwiftSemantics"], linkerSettings: specialLinkerSettings()),
    ]
)

private func specialLinkerSettings() -> [LinkerSetting] {
    return [
        .linkedLibrary("_InternalSwiftSyntaxParser"),
        /// - Note:
        ///     If this flags passed to linker, `-Xlinker` flag should not be here.
        ///     But in reality, command line `swift test` doesn't work without `-Xlinker` flag.
        ///     This means these flags are passed to compiler (`swiftc`) instead of linker (`ld`).
        ///     Therefore, `-Xlinker` flag is required here.
        ///     I'm not sure how this gonna be changed in future version of SPM.
        .unsafeFlags([
            "-Xlinker", "-F",
            "-Xlinker", "/Applications/Xcode.app/Contents/Frameworks",
            "-Xlinker", "-rpath",
            "-Xlinker", "/Applications/Xcode.app/Contents/Frameworks",
        ])
    ]
}
    

