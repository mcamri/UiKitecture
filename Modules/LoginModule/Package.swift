// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LoginModule",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "LoginModule",
            targets: ["LoginModule"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
      .package(name: "LoginService", path: "../LoginService"),
      .package(name: "BaseModule", path: "../BaseModule"),
      .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.0.1")),
      .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "6.5.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "LoginModule",
            dependencies: ["LoginService", "BaseModule", "SnapKit", "RxSwift", .product(name: "RxCocoa", package: "RxSwift")]),
        .testTarget(
            name: "LoginModuleTests",
            dependencies: ["LoginModule"]),
    ]
)
