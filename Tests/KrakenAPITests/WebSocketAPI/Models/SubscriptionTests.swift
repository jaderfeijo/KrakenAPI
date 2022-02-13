import XCTest
@testable import KrakenAPI

final class SubscriptionTests: XCTestCase {
	override func setUpWithError() throws {
		try super.setUpWithError()
	}

	override func tearDownWithError() throws {
		try super.tearDownWithError()
	}
}

// MARK: - Name Tests -

final class NameTests: XCTestCase {

	typealias Name = WebSocketAPI.Subscription.Options.Name

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
		let data = try encoder.encode(
			Name.allCases.map {
				JsonValue<Name>(value: $0)
			}
		)
		let json = String(decoding: data, as: UTF8.self)

		XCTAssertEqual(
			json,
			"""
			[
			  {
			    "value" : "book"
			  },
			  {
			    "value" : "ohlc"
			  },
			  {
			    "value" : "openOrders"
			  },
			  {
			    "value" : "ownTrades"
			  },
			  {
			    "value" : "spread"
			  },
			  {
			    "value" : "ticker"
			  },
			  {
			    "value" : "trade"
			  },
			  {
			    "value" : "*"
			  }
			]
			"""
		)
	}

	func testDecoding() throws {
		let data = """
		[
			{"value": "book"},
			{"value": "ohlc"},
			{"value": "openOrders"},
			{"value": "ownTrades"},
			{"value": "spread"},
			{"value": "ticker"},
			{"value": "trade"},
			{"value": "*"}
		]
		""".data(using: .utf8)!
		let decoded = try decoder.decode([JsonValue<Name>].self, from: data)

		XCTAssertEqual(
			decoded,
			Name.allCases.map { JsonValue<Name>(value: $0) }
		)
	}

	func testDecodingInvalid() throws {
		let data = """
		{
			"value": "invalid"
		}
		""".data(using: .utf8)!

		do {
			_ = try decoder.decode(JsonValue<Name>.self, from: data)
			XCTFail("Expected failure!")
		} catch is DecodingError {
			// success
		} catch {
			XCTFail("Unexpected exception thrown '\(error)'")
		}
	}
}

// MARK: - Depth Tests

final class DepthTests: XCTestCase {

	typealias Depth = WebSocketAPI.Subscription.Options.Depth

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
		let data = try encoder.encode(
			Depth.allCases.map {
				JsonValue<Depth>(value: $0)
			}
		)
		let json = String(decoding: data, as: UTF8.self)

		XCTAssertEqual(
			json,
			"""
			[
			  {
			    "value" : 10
			  },
			  {
			    "value" : 25
			  },
			  {
			    "value" : 100
			  },
			  {
			    "value" : 500
			  },
			  {
			    "value" : 1000
			  }
			]
			"""
		)
	}

	func testDecoding() throws {
		let data = """
		[
			{"value": 10},
			{"value": 25},
			{"value": 100},
			{"value": 500},
			{"value": 1000}
		]
		""".data(using: .utf8)!
		let decoded = try decoder.decode([JsonValue<Depth>].self, from: data)

		XCTAssertEqual(
			decoded,
			Depth.allCases.map { .init(value: $0) }
		)
	}

	func testDecodingInvalid() throws {
		let data = """
		{
			"value": 5
		}
		""".data(using: .utf8)!

		do {
			_ = try decoder.decode(Depth.self, from: data)
			XCTFail("Expected failure!")
		} catch is DecodingError {
			// success
		} catch {
			XCTFail("Unexpected error '\(error)'")
		}
	}
}

// MARK: - Interval Tests -

final class IntervalTests: XCTestCase {

	typealias Interval = WebSocketAPI.Subscription.Options.Interval

	var decoder: JSONDecoder!
	var encoder: JSONEncoder!

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

	func testEncode() throws {
		let objects = Interval.allCases.map(JsonValue<Interval>.init)
		let data = try encoder.encode(objects)
		let json = String(decoding: data, as: UTF8.self)

		XCTAssertEqual(
			json,
			"""
			[
			  {
			    "value" : 1
			  },
			  {
			    "value" : 5
			  },
			  {
			    "value" : 15
			  },
			  {
			    "value" : 30
			  },
			  {
			    "value" : 60
			  },
			  {
			    "value" : 240
			  },
			  {
			    "value" : 1440
			  },
			  {
			    "value" : 10080
			  },
			  {
			    "value" : 21600
			  }
			]
			"""
		)
	}

	func testDecode() throws {
		let data = """
		[
			{"value": 1},
			{"value": 5},
			{"value": 15},
			{"value": 30},
			{"value": 60},
			{"value": 240},
			{"value": 1440},
			{"value": 10080},
			{"value": 21600}
		]
		""".data(using: .utf8)!
		let decoded = try decoder.decode([JsonValue<Interval>].self, from: data)

		XCTAssertEqual(decoded.map(\.value), Interval.allCases)
	}

	func testDecodeInvalid() throws {
		let data = """
		{
			"object": 3
		}
		""".data(using: .utf8)!

		do {
			_ = try decoder.decode(JsonValue<Interval>.self, from: data)
			XCTFail("Expected failure")
		} catch is DecodingError {
			// success
		} catch {
			XCTFail("Unexpected error '\(error)'")
		}
	}
}
