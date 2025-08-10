// swift-tools-version:6.1

import PackageDescription

let _ = Package(name: "swift-platform-core",
                products: [
                  .library(name: "WindowsCore", targets: ["WindowsCore"]),
                  .library(name: "POSIXCore", targets: ["POSIXCore"]),
                ],
                traits: [
                  .trait(name: "GNU", description: "GNU C Library")
                ],
                targets: [
                  .target(name: "WindowsCore",
                          swiftSettings: [
                            .unsafeFlags(["-static"]),
                          ]),
                  .target(name: "POSIXCore"),
                ])
