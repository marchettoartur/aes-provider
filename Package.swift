// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AES-Provider",
    platforms: [
      .iOS(.v11),
      .macOS(.v10_14),
   ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "AES-Provider",
            targets: ["AES-Provider"]),
    ],
    dependencies: [
         .package(
            url: "https://github.com/kishikawakatsumi/KeychainAccess.git",
            .branch("master")
         ),
         .package(
            url: "https://github.com/krzyzanowskim/CryptoSwift.git",
            .branch("master")
         ),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "AES-Provider",
            dependencies: ["KeychainAccess", "CryptoSwift"]),
        .testTarget(
            name: "AES-ProviderTests",
            dependencies: ["AES-Provider"]),
    ]
)
