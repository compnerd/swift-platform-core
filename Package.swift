// swift-tools-version: 6.2

import PackageDescription

let _ = Package(name: "swift-platform-core",
                platforms: [
                  .macOS(.v26),
                ],
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
                            .enableExperimentalFeature("AccessLevelOnImport"),
                            .enableExperimentalFeature("ImportMacroAliases"),
                            .unsafeFlags(["-static"]),
                          ]),
                  .target(name: "POSIXCore"),
                ])
