import XCTest
@testable import KrakenAPI

final class SpreadTests: XCTestCase {
	typealias Spread = WebSocketAPI.Messages.Public.Spread

	var encoder: JSONEncoder!
	var decoder: JSONDecoder!

	override func setUpWithError() throws {
		try super.setUpWithError()

		encoder = JSONEncoder()
		decoder = JSONDecoder()

		encoder.outputFormatting = [
			.prettyPrinted,
			.withoutEscapingSlashes
		]
	}

	func testEncoding() throws {
		let spread = Spread(
			channelID: 0,
			bid: .init(
				bid: 5698.40001,
				ask: 5700.00001,
				timestamp: 1542057299.545897,
				bidVolume: 1.01234567,
				askVolume: 0.98765432),
			channelName: "spread",
			pair: .init(a: "XBT", b: "USD")
		)
		let data = try encoder.encode(spread)
		let json = String(decoding: data, as: UTF8.self)

		XCTAssertEqual(
			json,
			"""
			[
			  0,
			  [
			    "5698.40001",
			    "5700.00001",
			    "1542057299.545897",
			    "1.01234567",
			    "0.98765432"
			  ],
			  "spread",
			  "XBT/USD"
			]
			"""
		)
	}

	func testDecoding() throws {
		let data = """
		[
			0,
			[
				"5698.40001",
				"5700.00001",
				"1542057299.545897",
				"1.01234567",
				"0.98765432"
			],
			"spread",
			"XBT/USD"
		]
		""".data(using: .utf8)!
		let decoded = try decoder.decode(Spread.self, from: data)

		XCTAssertEqual(
			decoded,
			Spread(
				channelID: 0,
				bid: .init(
					bid: 5698.40001,
					ask: 5700.00001,
					timestamp: 1542057299.545897,
					bidVolume: 1.01234567,
					askVolume: 0.98765432),
				channelName: "spread",
				pair: .init(a: "XBT", b: "USD")
			)
		)
	}
}

// MARK: - Bid -

final class BidTests: XCTestCase {
	typealias Bid = WebSocketAPI.Messages.Public.Spread.Bid

	var encoder: JSONEncoder!
	var decoder: JSONDecoder!

	override func setUpWithError() throws {
		try super.setUpWithError()

		encoder = JSONEncoder()
		decoder = JSONDecoder()

		encoder.outputFormatting = .prettyPrinted
	}

	func testEncoding() throws {
		let value = Bid(
			bid: 5698.40001,
			ask: 5700.00001,
			timestamp: 1542057299.545897,
			bidVolume: 1.01234567,
			askVolume: 0.98765432)
		let data = try encoder.encode(value)
		let json = String(decoding: data, as: UTF8.self)

		XCTAssertEqual(
			json,
			"""
			[
			  "5698.40001",
			  "5700.00001",
			  "1542057299.545897",
			  "1.01234567",
			  "0.98765432"
			]
			"""
		)
	}

	func testDecoding() throws {
		let data = """
		[
			"5698.40001",
			"5700.00001",
			"1542057299.545897",
			"1.01234567",
			"0.98765432"
		]
		""".data(using: .utf8)!
		let decoded = try decoder.decode(Bid.self, from: data)

		XCTAssertEqual(
			decoded,
			Bid(
				bid: 5698.40001,
				ask: 5700.00001,
				timestamp: 1542057299.545897,
				bidVolume: 1.01234567,
				askVolume: 0.98765432)
		)
	}
}
