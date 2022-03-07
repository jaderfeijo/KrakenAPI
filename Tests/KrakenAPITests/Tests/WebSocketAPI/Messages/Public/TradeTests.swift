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
	}

	override func tearDownWithError() throws {
		encoder = nil
		decoder = nil

		try super.tearDownWithError()
	}

	func testEncoding() throws {
		XCTFail()
	}

	func testDecoding() throws {
		XCTFail()
	}
}

final class TradeInfoTests: XCTestCase {
	typealias Info = WebSocketAPI.Messages.Public.Trade.Info

	var encoder: JSONEncoder!
	var decoder: JSONDecoder!

	override func setUpWithError() throws {
		try super.setUpWithError()

		encoder = JSONEncoder()
		decoder = JSONDecoder()
	}

	override func tearDownWithError() throws {
		encoder = nil
		decoder = nil

		try super.tearDownWithError()
	}

	func testEncoding() throws {
		XCTFail()
	}

	func testDecoding() throws {
		XCTFail()
	}
}

final class SideTests: XCTestCase {
	typealias Side = WebSocketAPI.Messages.Public.Trade.Info.Side

	var encoder: JSONEncoder!
	var decoder: JSONDecoder!

	override func setUpWithError() throws {
		try super.setUpWithError()

		encoder = JSONEncoder()
		decoder = JSONDecoder()
	}

	override func tearDownWithError() throws {
		encoder = nil
		decoder = nil

		try super.tearDownWithError()
	}

	func testEncoding() throws {
		XCTFail()
	}

	func testDecoding() throws {
		XCTFail()
	}
}

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
