// swift-tools-version:5.5

import PackageDescription

let package = Package(
  name: "RequestBuilder",
  platforms: [
    .iOS(.v13),
    .macOS(.v10_15),
    .tvOS(.v13),
    .watchOS(.v6)
  ],
  products: [
    .library(
      name: "RequestBuilder",
      type: .static,
      targets: ["RequestBuilder"]
    ),
  ],
  targets: [
    .target(
      name: "RequestBuilder",
      dependencies: []
    )
  ]
)
