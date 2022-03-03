import XCTest
@testable import KrakenAPI

class CandleTests: XCTestCase {
	typealias Candle = WebSocketAPI.Messages.Public.Candle

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

	override func tearDownWithError() throws {
		encoder = nil
		decoder = nil

		try super.tearDownWithError()
	}

	func testEncoding() throws {
		let candle = Candle(
			channelID: 42,
			data: .init(
				time: 1542057314.748456,
				endTime: 1542057360.435743,
				open: 3586.70001,
				high: 3586.70001,
				low: 3586.60001,
				close: 3586.60001,
				averagePrice: 3586.68894,
				volume: 0.03373001,
				count: 2),
			channelName: "ohlc-5",
			pair: .init(a: "XBT", b: "USD")
		)
		let data = try encoder.encode(candle)
		let json = String(decoding: data, as: UTF8.self)

		XCTAssertEqual(
			json,
			"""
			[
			  42,
			  [
			    "1542057314.748456",
			    "1542057360.435743",
			    "3586.70001",
			    "3586.70001",
			    "3586.60001",
			    "3586.60001",
			    "3586.68894",
			    "0.03373001",
			    2
			  ],
			  "ohlc-5",
			  "XBT/USD"
			]
			"""
		)
	}

	func testDecoding() throws {
		let data = """
		[
			42,
			[
				"1542057314.748456",
				"1542057360.435743",
				"3586.70001",
				"3586.70001",
				"3586.60001",
				"3586.60001",
				"3586.68894",
				"0.03373001",
				2
			],
			"ohlc-5",
			"XBT/USD"
		]
		""".data(using: .utf8)!
		let decoded = try decoder.decode(Candle.self, from: data)

		XCTAssertEqual(
			decoded,
			Candle(
				channelID: 42,
				data: .init(
					time: 1542057314.748456,
					endTime: 1542057360.435743,
					open: 3586.70001,
					high: 3586.70001,
					low: 3586.60001,
					close: 3586.60001,
					averagePrice: 3586.68894,
					volume: 0.03373001,
					count: 2),
				channelName: "ohlc-5",
				pair: .init(a: "XBT", b: "USD")
			)
		)
	}
}

class CandleDataTests: XCTestCase {
	typealias CandleData = WebSocketAPI.Messages.Public.Candle.Data

	var encoder: JSONEncoder!
	var decoder: JSONDecoder!

	override func setUpWithError() throws {
		try super.setUpWithError()

		encoder = JSONEncoder()
		decoder = JSONDecoder()

		encoder.outputFormatting = [
			.prettyPrinted
		]
	}

	override func tearDownWithError() throws {
		encoder = nil
		decoder = nil

		try super.tearDownWithError()
	}

	func testEncoding() throws {
		let candleData = CandleData(
			time: 1542057314.748456,
			endTime: 1542057360.435743,
			open: 3586.70001,
			high: 3586.70001,
			low: 3586.60001,
			close: 3586.60001,
			averagePrice: 3586.68894,
			volume: 0.03373001,
			count: 2)
		let data = try encoder.encode(candleData)
		let json = String(decoding: data, as: UTF8.self)

		XCTAssertEqual(
			json,
			"""
			[
			  "1542057314.748456",
			  "1542057360.435743",
			  "3586.70001",
			  "3586.70001",
			  "3586.60001",
			  "3586.60001",
			  "3586.68894",
			  "0.03373001",
			  2
			]
			"""
		)
	}

	func testDecoding() throws {
		let data = """
		[
			"1542057314.748456",
			"1542057360.435743",
			"3586.70001",
			"3586.70001",
			"3586.60001",
			"3586.60001",
			"3586.68894",
			"0.03373001",
			2
		]
		""".data(using: .utf8)!
		let decoded = try decoder.decode(CandleData.self, from: data)

		XCTAssertEqual(
			decoded,
			CandleData(
				time: 1542057314.748456,
				endTime: 1542057360.435743,
				open: 3586.70001,
				high: 3586.70001,
				low: 3586.60001,
				close: 3586.60001,
				averagePrice: 3586.68894,
				volume: 0.03373001,
				count: 2)
		)
	}
}
