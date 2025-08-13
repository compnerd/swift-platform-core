// swift-tools-version:6.1

import PackageDescription

let _ = Package(name: "swift-platform-core",
                platforms: [
                  .macOS(.v15),
                ],
                products: [
                  .library(name: "WindowsCore", targets: ["WindowsCore"]),
                  .library(name: "POSIXCore", targets: ["POSIXCore"]),
                ],
                targets: [
                  .target(name: "WindowsCore",
                          swiftSettings: [
                            .unsafeFlags(["-static"]),
                          ]),
                  .target(name: "POSIXCore"),
                ])
