// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "SRUI",
    platforms: [.macOS(.v26)],
    products: [
        .library(name: "SRUI", targets: ["SRUI"]),
    ],
    dependencies: [
        .package(path: "../SRCore"),
    ],
    targets: [
        .target(
            name: "SRUI",
            dependencies: ["SRCore"]
        ),
    ]
)
