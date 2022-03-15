import XCTest
@testable import KrakenAPI

final class TradeTests: XCTestCase {
	typealias Trade = WebSocketAPI.Messages.Public.Trade

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
		let trade = Trade(
			channelID: 0,
			info: [
				.init(
					price: 5541.20001,
					volume: 0.15850568,
					time: 1534614057.321597,
					side: .sell,
					orderType: .limit,
					misc: ""),
				.init(
					price: 6060.00001,
					volume: 0.02455001,
					time: 1534614057.324998,
					side: .buy,
					orderType: .limit,
					misc: "")
			],
			channelName: "trade",
			pair: .init(a: "XBT", b: "USD")
		)
		let data = try encoder.encode(trade)
		let json = String(decoding: data, as: UTF8.self)

		XCTAssertEqual(
			json,
			"""
			[
			  0,
			  [
			    [
			      "5541.20001",
			      "0.15850568",
			      "1534614057.321597",
			      "s",
			      "l",
			      ""
			    ],
			    [
			      "6060.00001",
			      "0.02455001",
			      "1534614057.324998",
			      "b",
			      "l",
			      ""
			    ]
			  ],
			  "trade",
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
				[
					"5541.20001",
					"0.15850568",
					"1534614057.321597",
					"s",
					"l",
					""
				],
				[
					"6060.00001",
					"0.02455001",
					"1534614057.324998",
					"b",
					"l",
					""
				]
			],
			"trade",
			"XBT/USD"
		]
		""".data(using: .utf8)!
		let decoded = try decoder.decode(Trade.self, from: data)

		XCTAssertEqual(
			decoded,
			Trade(
				channelID: 0,
				info: [
					.init(
						price: 5541.20001,
						volume: 0.15850568,
						time: 1534614057.321597,
						side: .sell,
						orderType: .limit,
						misc: ""),
					.init(
						price: 6060.00001,
						volume: 0.02455001,
						time: 1534614057.324998,
						side: .buy,
						orderType: .limit,
						misc: "")
				],
				channelName: "trade",
				pair: .init(a: "XBT", b: "USD")
			)
		)
	}
}

// MARK: - Info -

final class TradeInfoTests: XCTestCase {
	typealias Info = WebSocketAPI.Messages.Public.Trade.Info

	var encoder: JSONEncoder!
	var decoder: JSONDecoder!

	override func setUpWithError() throws {
		try super.setUpWithError()

		encoder = JSONEncoder()
		decoder = JSONDecoder()

		encoder.outputFormatting = .prettyPrinted
	}

	override func tearDownWithError() throws {
		encoder = nil
		decoder = nil

		try super.tearDownWithError()
	}

	func testEncoding() throws {
		let info = Info(
			price: 5541.20001,
			volume: 0.15850568,
			time: 1534614057.321597,
			side: .sell,
			orderType: .limit,
			misc: "")
		let data = try encoder.encode(info)
		let json = String(decoding: data, as: UTF8.self)

		XCTAssertEqual(
			json,
			"""
			[
			  "5541.20001",
			  "0.15850568",
			  "1534614057.321597",
			  "s",
			  "l",
			  ""
			]
			"""
		)
	}

	func testDecoding() throws {
		let data = """
		[
		  "6060.00001",
		  "0.02455001",
		  "1534614057.324998",
		  "b",
		  "m",
		  ""
		]
		""".data(using: .utf8)!
		let decoded = try decoder.decode(Info.self, from: data)

		XCTAssertEqual(
			decoded,
			Info(
				price: 6060.00001,
				volume: 0.02455001,
				time: 1534614057.324998,
				side: .buy,
				orderType: .market,
				misc: "")
		)
	}
}

// MARK: - Side -

final class SideTests: XCTestCase {
	typealias Side = WebSocketAPI.Messages.Public.Trade.Info.Side

	var encoder: JSONEncoder!
	var decoder: JSONDecoder!

	override func setUpWithError() throws {
		try super.setUpWithError()

		encoder = JSONEncoder()
		decoder = JSONDecoder()

		encoder.outputFormatting = .prettyPrinted
	}

	override func tearDownWithError() throws {
		encoder = nil
		decoder = nil

		try super.tearDownWithError()
	}

	func testEncoding() throws {
		let objects: [JsonValue<Side>] = Side.allCases.map { .init(value: $0) }
		let data = try encoder.encode(objects)
		let encoded = String(decoding: data, as: UTF8.self)

		XCTAssertEqual(
			encoded,
			"""
			[
			  {
			    "value" : "b"
			  },
			  {
			    "value" : "s"
			  }
			]
			"""
		)
	}

	func testDecoding() throws {
		let data = """
		[
			{"value" : "b"},
			{"value" : "s"}
		]
		""".data(using: .utf8)!
		let decoded = try decoder.decode([JsonValue<Side>].self, from: data)

		XCTAssertEqual(
			decoded,
			Side.allCases.map { .init(value: $0) }
		)
	}

	func testDecodingInvalid() throws {
		let data = """
		{
			"value" : "invalid"
		}
		""".data(using: .utf8)!

		do {
			_ = try decoder.decode(JsonValue<Side>.self, from: data)
			XCTFail("Expected failure")
		} catch is DecodingError {
			// success
		} catch {
			XCTFail("Expected DecodingError, got '\(error)' instead")
		}
	}
}

// MARK: - OrderType -

final class OrderTypeTests: XCTestCase {
	typealias OrderType = WebSocketAPI.Messages.Public.Trade.Info.OrderType

	var encoder: JSONEncoder!
	var decoder: JSONDecoder!

	override func setUpWithError() throws {
		try super.setUpWithError()

		encoder = JSONEncoder()
		decoder = JSONDecoder()

		encoder.outputFormatting = .prettyPrinted
	}

	override func tearDownWithError() throws {
		encoder = nil
		decoder = nil

		try super.tearDownWithError()
	}

	func testEncoding() throws {
		let objects: [JsonValue<OrderType>] = OrderType.allCases.map { .init(value: $0) }
		let data = try encoder.encode(objects)
		let encoded = String(decoding: data, as: UTF8.self)

		XCTAssertEqual(
			encoded,
			"""
			[
			  {
			    "value" : "m"
			  },
			  {
			    "value" : "l"
			  }
			]
			"""
		)
	}

	func testDecoding() throws {
		let data = """
		[
			{"value" : "m"},
			{"value" : "l"}
		]
		""".data(using: .utf8)!
		let decoded = try decoder.decode([JsonValue<OrderType>].self, from: data)

		XCTAssertEqual(
			decoded,
			OrderType.allCases.map { .init(value: $0) }
		)
	}

	func testDecodingInvalid() throws {
		let data = """
		{
			"value" : "invalid"
		}
		""".data(using: .utf8)!

		do {
			_ = try decoder.decode(JsonValue<OrderType>.self, from: data)
			XCTFail("Expected failure")
		} catch is DecodingError {
			// success
		} catch {
			XCTFail("Expected DecodingError, got '\(error)' instead")
		}
	}
}
