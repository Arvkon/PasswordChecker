// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "PasswordChecker",
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", .upToNextMinor(from: "3.1.0")),
        // 🍁 A template renderer.
        .package(url: "https://github.com/vapor/leaf.git", .upToNextMinor(from: "3.0.0")),
        // 📧 An email service.
        .package(url: "https://github.com/twof/VaporMailgunService.git", from: "1.5.0"),
        // 🌳 Environment extensions.
        .package(url: "https://github.com/vapor-community/vapor-ext.git", from: "0.1.0"),
    ],
    targets: [
        .target(name: "App", dependencies: ["Vapor", "Leaf", "Mailgun", "VaporExt"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"]),
    ]
)

