// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "RxTexture",
    platforms: [
      .iOS(.v9)
    ],
    products: [
        .library(name: "RxTexture", targets: ["RxTexture"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "5.0.0")),
        .package(url: "https://github.com/devxoul/RxExpect.git", .upToNextMajor(from: "2.0.0")),
    ],
    targets: [
        .target(name: "RxTexture", dependencies: ["RxSwift", "RxCocoa"]),
        .testTarget(name: "RxTextureTests", dependencies: ["RxTexture", "RxExpect"]),
    ]
)
