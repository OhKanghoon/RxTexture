// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "RxTexture",
    platforms: [
      .macOS(.v10_11), .iOS(.v9), .tvOS(.v9)
    ],
    products: [
        .library(name: "RxTexture", targets: ["RxTexture"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "5.0.0")),
    ],
    targets: [
        .target(name: "RxTexture", dependencies: ["RxSwift", "RxCocoa"]),
        .testTarget(name: "RxTextureTests", dependencies: ["RxTexture"]),
    ]
)
