// swift-tools-version:6.0

import PackageDescription

let _ = Package(name: "swift-platform-core",
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
