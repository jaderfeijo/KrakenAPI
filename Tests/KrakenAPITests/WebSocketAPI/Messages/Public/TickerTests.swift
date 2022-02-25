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
	}

	override func tearDownWithError() throws {
		encoder = nil
		decoder = nil

		try super.tearDownWithError()
	}

	func testEncoding() throws {
		XCTFail("Not yet implemented")
	}

	func testDecoding() throws {
		XCTFail("Not yet implemented")
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
	}

	override func tearDownWithError() throws {
		encoder = nil
		decoder = nil

		try super.tearDownWithError()
	}

	func testEncoding() throws {
		XCTFail("Not yet implemented")
	}

	func testDecoding() throws {
		XCTFail("Not yet implemented")
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
	}

	override func tearDownWithError() throws {
		encoder = nil
		decoder = nil

		try super.tearDownWithError()
	}

	func testEncoding() throws {
		XCTFail("Not yet implemented")
	}

	func testDecoding() throws {
		XCTFail("Not yet implemented")
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
	}

	override func tearDownWithError() throws {
		encoder = nil
		decoder = nil

		try super.tearDownWithError()
	}

	func testEncoding() throws {
		XCTFail("Not yet implemented")
	}

	func testDecoding() throws {
		XCTFail("Not yet implemented")
	}
}

// MARK: - Value -

class ValueTests: XCTestCase {

	typealias Value = WebSocketAPI.Messages.Public.Ticker.Pricing.Value

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
		let value = Value(
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
		let decoded = try decoder.decode(Value.self, from: data)

		XCTAssertEqual(
			decoded,
			Value(
				today: 2634.11501494,
				last24Hours: 3591.17907851
			)
		)
	}
}
