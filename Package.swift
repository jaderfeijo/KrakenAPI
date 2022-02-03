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
		.package(url: "https://github.com/tesseract-one/WebSocket.swift.git", from: "0.1.0")
	],
	targets: [
		.target(
			name: "KrakenAPI",
			dependencies: [.product(name: "WebSocket", package: "WebSocket.swift")]
		),
		.testTarget(
			name: "KrakenAPITests",
			dependencies: ["KrakenAPI"]
		)
	]
)
