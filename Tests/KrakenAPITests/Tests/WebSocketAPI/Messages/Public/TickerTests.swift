import XCTest
@testable import KrakenAPI

class TickerTests: XCTestCase {

	typealias Ticker = WebSocketAPI.Messages.Public.Ticker

	var encoder: JSONEncoder!
	var decoder: JSONDecoder!

	override func setUpWithError() throws {
		try super.setUpWithError()

		encoder = JSONEncoder()
		decoder = JSONDecoder()

		encoder.outputFormatting = [
			.sortedKeys,
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
		let ticker = Ticker(
			channelID: 0,
			pricing: .init(
				ask: .init(
					price: 5525.40001,
					wholeLotVolume: 1,
					lotVolume: 1.001),
				bid: .init(
					price: 5525.10001,
					wholeLotVolume: 1,
					lotVolume: 1.001),
				close: .init(
					price: 5525.10001,
					lotVolume: 0.00398963),
				volume: .init(
					today: 2634.11501494,
					last24Hours: 3591.17907851),
				averagePrice: .init(
					today: 5631.44067,
					last24Hours: 5653.78939),
				numberOfTrades: .init(
					today: 11493,
					last24Hours: 16267),
				low: .init(
					today: 5505.00001,
					last24Hours: 5505.00001),
				high: .init(
					today: 5783.00001,
					last24Hours: 5783.00001),
				open: .init(
					today: 5760.70001,
					last24Hours: 5763.40001)
			),
			channelName: "ticker",
			pair: .init(a: "XBT", b: "USD")
		)
		let data = try encoder.encode(ticker)
		let json = String(decoding: data, as: UTF8.self)

		XCTAssertEqual(
			json,
			"""
			[
			  0,
			  {
			    "a" : [
			      "5525.40001",
			      1,
			      "1.001"
			    ],
			    "b" : [
			      "5525.10001",
			      1,
			      "1.001"
			    ],
			    "c" : [
			      "5525.10001",
			      "0.00398963"
			    ],
			    "h" : [
			      "5783.00001",
			      "5783.00001"
			    ],
			    "l" : [
			      "5505.00001",
			      "5505.00001"
			    ],
			    "o" : [
			      "5760.70001",
			      "5763.40001"
			    ],
			    "p" : [
			      "5631.44067",
			      "5653.78939"
			    ],
			    "t" : [
			      11493,
			      16267
			    ],
			    "v" : [
			      "2634.11501494",
			      "3591.17907851"
			    ]
			  },
			  "ticker",
			  "XBT/USD"
			]
			"""
		)
	}

	func testDecoding() throws {
		let data = """
		[
			0,
			{
				"a" : [
					"5525.40001",
					1,
					"1.001"
				],
				"b" : [
					"5525.10001",
					1,
					"1.001"
				],
				"c" : [
					"5525.10001",
					"0.00398963"
				],
				"h" : [
					"5783.00001",
					"5783.00001"
				],
				"l" : [
					"5505.00001",
					"5505.00001"
				],
				"o" : [
					"5760.70001",
					"5763.40001"
				],
				"p" : [
					"5631.44067",
					"5653.78939"
				],
				"t" : [
					11493,
					16267
				],
				"v" : [
					"2634.11501494",
					"3591.17907851"
				]
			},
			"ticker",
			"XBT/USD"
		]
		""".data(using: .utf8)!
		let decoded = try decoder.decode(Ticker.self, from: data)

		XCTAssertEqual(
			decoded,
			Ticker(
				channelID: 0,
				pricing: .init(
					ask: .init(
						price: 5525.40001,
						wholeLotVolume: 1,
						lotVolume: 1.001),
					bid: .init(
						price: 5525.10001,
						wholeLotVolume: 1,
						lotVolume: 1.001),
					close: .init(
						price: 5525.10001,
						lotVolume: 0.00398963),
					volume: .init(
						today: 2634.11501494,
						last24Hours: 3591.17907851),
					averagePrice: .init(
						today: 5631.44067,
						last24Hours: 5653.78939),
					numberOfTrades: .init(
						today: 11493,
						last24Hours: 16267),
					low: .init(
						today: 5505.00001,
						last24Hours: 5505.00001),
					high: .init(
						today: 5783.00001,
						last24Hours: 5783.00001),
					open: .init(
						today: 5760.70001,
						last24Hours: 5763.40001)
				),
				channelName: "ticker",
				pair: .init(a: "XBT", b: "USD")
			)
		)
	}
}

// MARK: - Pricing -

class PricingTests: XCTestCase {

	typealias Pricing = WebSocketAPI.Messages.Public.Ticker.Pricing

	var encoder: JSONEncoder!
	var decoder: JSONDecoder!

	override func setUpWithError() throws {
		try super.setUpWithError()

		encoder = JSONEncoder()
		decoder = JSONDecoder()

		encoder.outputFormatting = [
			.sortedKeys,
			.prettyPrinted
		]
	}

	override func tearDownWithError() throws {
		encoder = nil
		decoder = nil

		try super.tearDownWithError()
	}

	func testEncoding() throws {
		let pricing = Pricing(
			ask: .init(
				price: 5525.40001,
				wholeLotVolume: 1,
				lotVolume: 1.001),
			bid: .init(
				price: 5525.10001,
				wholeLotVolume: 1,
				lotVolume: 1.001),
			close: .init(
				price: 5525.10001,
				lotVolume: 0.00398963),
			volume: .init(
				today: 2634.11501494,
				last24Hours: 3591.17907851),
			averagePrice: .init(
				today: 5631.44067,
				last24Hours: 5653.78939),
			numberOfTrades: .init(
				today: 11493,
				last24Hours: 16267),
			low: .init(
				today: 5505.00001,
				last24Hours: 5505.00001),
			high: .init(
				today: 5783.00001,
				last24Hours: 5783.00001),
			open: .init(
				today: 5760.70001,
				last24Hours: 5763.40001)
		)
		let data = try encoder.encode(pricing)
		let json = String(decoding: data, as: UTF8.self)

		XCTAssertEqual(
			json,
			"""
			{
			  "a" : [
			    "5525.40001",
			    1,
			    "1.001"
			  ],
			  "b" : [
			    "5525.10001",
			    1,
			    "1.001"
			  ],
			  "c" : [
			    "5525.10001",
			    "0.00398963"
			  ],
			  "h" : [
			    "5783.00001",
			    "5783.00001"
			  ],
			  "l" : [
			    "5505.00001",
			    "5505.00001"
			  ],
			  "o" : [
			    "5760.70001",
			    "5763.40001"
			  ],
			  "p" : [
			    "5631.44067",
			    "5653.78939"
			  ],
			  "t" : [
			    11493,
			    16267
			  ],
			  "v" : [
			    "2634.11501494",
			    "3591.17907851"
			  ]
			}
			"""
		)
	}

	func testDecoding() throws {
		let data = """
		{
			"a" : [
				"5525.40001",
				1,
				"1.001"
			],
			"b" : [
				"5525.10001",
				1,
				"1.001"
			],
			"c" : [
				"5525.10001",
				"0.00398963"
			],
			"h" : [
				"5783.00001",
				"5783.00001"
			],
			"l" : [
				"5505.00001",
				"5505.00001"
			],
			"o" : [
				"5760.70001",
				"5763.40001"
			],
			"p" : [
				"5631.44067",
				"5653.78939"
			],
			"t" : [
				11493,
				16267
			],
			"v" : [
				"2634.11501494",
				"3591.17907851"
			]
		}
		""".data(using: .utf8)!
		let decoded = try decoder.decode(Pricing.self, from: data)

		XCTAssertEqual(
			decoded,
			Pricing(
				ask: .init(
					price: 5525.40001,
					wholeLotVolume: 1,
					lotVolume: 1.001),
				bid: .init(
					price: 5525.10001,
					wholeLotVolume: 1,
					lotVolume: 1.001),
				close: .init(
					price: 5525.10001,
					lotVolume: 0.00398963),
				volume: .init(
					today: 2634.11501494,
					last24Hours: 3591.17907851),
				averagePrice: .init(
					today: 5631.44067,
					last24Hours: 5653.78939),
				numberOfTrades: .init(
					today: 11493,
					last24Hours: 16267),
				low: .init(
					today: 5505.00001,
					last24Hours: 5505.00001),
				high: .init(
					today: 5783.00001,
					last24Hours: 5783.00001),
				open: .init(
					today: 5760.70001,
					last24Hours: 5763.40001)
			)
		)
	}
}

// MARK: - PriceWholeVolume -

class PriceWholeVolumeTests: XCTestCase {

	typealias PriceWholeVolume = WebSocketAPI.Messages.Public.Ticker.Pricing.PriceWholeVolume

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
		let price = PriceWholeVolume(
			price: 5525.40001,
			wholeLotVolume: 1,
			lotVolume: 1.001)
		let data = try encoder.encode(price)
		let json = String(decoding: data, as: UTF8.self)

		XCTAssertEqual(
			json,
			"""
			[
			  "5525.40001",
			  1,
			  "1.001"
			]
			"""
		)
	}

	func testDecoding() throws {
		let data = """
		[
		  "5525.10001",
		  1,
		  "1.001"
		]
		""".data(using: .utf8)!
		let decoded = try decoder.decode(PriceWholeVolume.self, from: data)

		XCTAssertEqual(
			decoded,
			PriceWholeVolume(
				price: 5525.10001,
				wholeLotVolume: 1,
				lotVolume: 1.001
			)
		)
	}

	func testDecodingErrorInvalidPrice() throws {
		let data = """
		[
		  "invalidPrice",
		  1,
		  "1.001"
		]
		""".data(using: .utf8)!

		do {
			_ = try decoder.decode(PriceWholeVolume.self, from: data)
			XCTFail("Expected failure")
		} catch StringDecodingError<Double>.invalidValue(let invalidString) {
			XCTAssertEqual(invalidString, "invalidPrice")
		} catch {
			XCTFail("Unexpected error '\(error)'")
		}
	}

	func testDecodingErrorInvalidLotVolume() throws {
		let data = """
		[
		  "5525.10001",
		  1,
		  "invalidLotVolume"
		]
		""".data(using: .utf8)!

		do {
			_ = try decoder.decode(PriceWholeVolume.self, from: data)
			XCTFail("Expected failure")
		} catch StringDecodingError<Double>.invalidValue(let invalidString) {
			XCTAssertEqual(invalidString, "invalidLotVolume")
		} catch {
			XCTFail("Unexpected error '\(error)'")
		}
	}
}

// MARK: - PriceVolume -

class PriceVolumeTests: XCTestCase {

	typealias PriceVolume = WebSocketAPI.Messages.Public.Ticker.Pricing.PriceVolume

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
		let price = PriceVolume(
			price: 5525.10001,
			lotVolume: 0.00398963)
		let data = try encoder.encode(price)
		let json = String(decoding: data, as: UTF8.self)

		XCTAssertEqual(
			json,
			"""
			[
			  "5525.10001",
			  "0.00398963"
			]
			"""
		)
	}

	func testDecoding() throws {
		let data = """
		[
			"5525.10001",
			"0.00398963"
		]
		""".data(using: .utf8)!
		let decoded = try decoder.decode(PriceVolume.self, from: data)

		XCTAssertEqual(
			decoded,
			PriceVolume(
				price: 5525.10001,
				lotVolume: 0.00398963
			)
		)
	}

	func testDecodingErrorInvalidPrice() throws {
		let data = """
		[
			"invalidPrice",
			"3591.17907851"
		]
		""".data(using: .utf8)!

		do {
			_ = try decoder.decode(PriceVolume.self, from: data)
			XCTFail("Expected failure")
		} catch StringDecodingError<Double>.invalidValue(let invalidString) {
			XCTAssertEqual(invalidString, "invalidPrice")
		} catch {
			XCTFail("Unexpected error '\(error)'")
		}
	}

	func testDecodingErrorInvalidLotVolume() throws {
		let data = """
		[
			"5525.10001",
			"invalidLotVolume"
		]
		""".data(using: .utf8)!

		do {
			_ = try decoder.decode(PriceVolume.self, from: data)
			XCTFail("Expected failure")
		} catch StringDecodingError<Double>.invalidValue(let invalidString) {
			XCTAssertEqual(invalidString, "invalidLotVolume")
		} catch {
			XCTFail("Unexpected error '\(error)'")
		}
	}
}

// MARK: - IntegerValuePair -

class IntegerValuePairTests: XCTestCase {

	typealias IntegerValuePair = WebSocketAPI.Messages.Public.Ticker.Pricing.IntegerValuePair

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
		let value = IntegerValuePair(
			today: 11493,
			last24Hours: 16267)
		let data = try encoder.encode(value)
		let json = String(decoding: data, as: UTF8.self)

		XCTAssertEqual(
			json,
			"""
			[
			  11493,
			  16267
			]
			"""
		)
	}

	func testDecoding() throws {
		let data = """
		[
			11493,
			16267
		]
		""".data(using: .utf8)!
		let decoded = try decoder.decode(IntegerValuePair.self, from: data)

		XCTAssertEqual(
			decoded,
			IntegerValuePair(
				today: 11493,
				last24Hours: 16267
			)
		)
	}
}

// MARK: - DecimalValuePair -

class DecimalValuePairTests: XCTestCase {

	typealias DecimalValuePair = WebSocketAPI.Messages.Public.Ticker.Pricing.DecimalValuePair

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
		let value = DecimalValuePair(
			today: 2634.11501494,
			last24Hours: 3591.17907851)
		let data = try encoder.encode(value)
		let json = String(decoding: data, as: UTF8.self)

		XCTAssertEqual(
			json,
			"""
			[
			  "2634.11501494",
			  "3591.17907851"
			]
			"""
		)
	}

	func testDecoding() throws {
		let data = """
		[
			"2634.11501494",
			"3591.17907851"
		]
		""".data(using: .utf8)!
		let decoded = try decoder.decode(DecimalValuePair.self, from: data)

		XCTAssertEqual(
			decoded,
			DecimalValuePair(
				today: 2634.11501494,
				last24Hours: 3591.17907851
			)
		)
	}

	func testDecodingErrorInvalidToday() throws {
		let data = """
		[
			"invalidToday",
			"3591.17907851"
		]
		""".data(using: .utf8)!

		do {
			_ = try decoder.decode(DecimalValuePair.self, from: data)
			XCTFail("Expected failure")
		} catch StringDecodingError<Double>.invalidValue(let invalidString) {
			XCTAssertEqual(invalidString, "invalidToday")
		} catch {
			XCTFail("Unexpected error '\(error)'")
		}
	}

	func testDecodingErrorInvalidLast24Hours() throws {
		let data = """
		[
			"2634.11501494",
			"invalid24Hours"
		]
		""".data(using: .utf8)!

		do {
			_ = try decoder.decode(DecimalValuePair.self, from: data)
			XCTFail("Expected failure")
		} catch StringDecodingError<Double>.invalidValue(let invalidString) {
			XCTAssertEqual(invalidString, "invalid24Hours")
		} catch {
			XCTFail("Unexpected error '\(error)'")
		}
	}
}
