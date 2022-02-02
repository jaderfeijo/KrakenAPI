// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "KrakenAPI",
	products: [
		.library(
			name: "KrakenAPI",
			targets: ["KrakenAPI"]
		)
	],
	dependencies: [
		.package(url: "https://github.com/vapor/websocket-kit.git", from: "2.3.0")
	],
	targets: [
		.target(
			name: "KrakenAPI",
			dependencies: [.product(name: "WebSocketKit", package: "websocket-kit")]
		),
		.testTarget(
			name: "KrakenAPITests",
			dependencies: ["KrakenAPI"]
		)
	]
)
