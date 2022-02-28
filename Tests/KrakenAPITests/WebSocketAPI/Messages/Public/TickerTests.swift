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
	typealias DecodingError = PriceWholeVolume.DecodingError

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
		} catch DecodingError.invalidDoubleString(let invalidString) {
			XCTAssertEqual(invalidString, "invalidPrice")
		} catch {
			XCTFail("Expected DecodingError, got '\(error)' instead")
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
		} catch DecodingError.invalidDoubleString(let invalidString) {
			XCTAssertEqual(invalidString, "invalidLotVolume")
		} catch {
			XCTFail("Expected DecodingError, got '\(error)' instead")
		}
	}
}

// MARK: - PriceVolume -

class PriceVolumeTests: XCTestCase {

	typealias PriceVolume = WebSocketAPI.Messages.Public.Ticker.Pricing.PriceVolume
	typealias DecodingError = WebSocketAPI.Messages.Internal.ValueCodable.DecodingError

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
		} catch DecodingError.invalidDoubleString(let invalidString) {
			XCTAssertEqual(invalidString, "invalidPrice")
		} catch {
			XCTFail("Expected DecodingError, got '\(error)' instead")
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
		} catch DecodingError.invalidDoubleString(let invalidString) {
			XCTAssertEqual(invalidString, "invalidLotVolume")
		} catch {
			XCTFail("Expected DecodingError, got '\(error)' instead")
		}
	}
}

// MARK: - Value -

class ValueTests: XCTestCase {

	typealias Value = WebSocketAPI.Messages.Public.Ticker.Pricing.Value
	typealias DecodingError = WebSocketAPI.Messages.Internal.ValueCodable.DecodingError

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

	func testDecodingErrorInvalidToday() throws {
		let data = """
		[
			"invalidToday",
			"3591.17907851"
		]
		""".data(using: .utf8)!

		do {
			_ = try decoder.decode(Value.self, from: data)
			XCTFail("Expected failure")
		} catch DecodingError.invalidDoubleString(let invalidString) {
			XCTAssertEqual(invalidString, "invalidToday")
		} catch {
			XCTFail("Expected DecodingError, got '\(error)' instead")
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
			_ = try decoder.decode(Value.self, from: data)
			XCTFail("Expected failure")
		} catch DecodingError.invalidDoubleString(let invalidString) {
			XCTAssertEqual(invalidString, "invalid24Hours")
		} catch {
			XCTFail("Expected DecodingError, got '\(error)' instead")
		}
	}
}
