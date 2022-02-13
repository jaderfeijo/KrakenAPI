import XCTest
@testable import KrakenAPI

final class TradingPairTests: XCTestCase {

	typealias TradingPair = WebSocketAPI.TradingPair
	
	var encoder: JSONEncoder!
	var decoder: JSONDecoder!

	override func setUpWithError() throws {
		try super.setUpWithError()

		encoder = JSONEncoder()
		decoder = JSONDecoder()

		encoder.outputFormatting = .withoutEscapingSlashes
	}

	override func tearDownWithError() throws {
		encoder = nil
		decoder = nil

		try super.tearDownWithError()
	}

	func testEncoding() throws {
		let pair = TradingPair(a: "USD", b: "BTC")
		let object = JsonValue<TradingPair>(value: pair)
		let data = try encoder.encode(object)
		let encoded = String(decoding: data, as: UTF8.self)

		XCTAssertEqual(encoded, "{\"value\":\"USD/BTC\"}")
	}

	func testDecoding() throws {
		let pair = "{\"value\":\"USD/BTC\"}"
		let data = pair.data(using: .utf8)!
		let decoded = try decoder.decode(JsonValue<TradingPair>.self, from: data)

		XCTAssertEqual(decoded.value.a, "USD")
		XCTAssertEqual(decoded.value.b, "BTC")
	}

	func testDecodingInvalidFormat() throws {
		let pair = "{\"value\":\"USD-BTC\"}"
		let data = pair.data(using: .utf8)!

		do {
			_ = try decoder.decode(JsonValue<TradingPair>.self, from: data)
			XCTFail("Expected exception to be thrown")
		} catch WebSocketAPI.TradingPair.DecodingError.invalidFormat(let value) {
			XCTAssertEqual(value, "USD-BTC")
		} catch {
			XCTFail("Unexpected error '\(error)'")
		}
	}
}
