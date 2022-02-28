import XCTest
@testable import KrakenAPI

class StringEncodingDecodingTests: XCTestCase {

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
}

extension StringEncodingDecodingTests {
	func testDecodeAsString() throws {
		let data = """
		["1.101"]
		""".data(using: .utf8)!
		let decoded = try decoder.decode(Value<Double>.self, from: data)

		XCTAssertEqual(decoded, .init(value: 1.101))
	}

	func testDecodeAsStringError() throws {
		let data = """
		["invalid"]
		""".data(using: .utf8)!

		do {
			_ = try decoder.decode(Value<Double>.self, from: data)
			XCTFail("Expected failure")
		} catch StringDecodingError<Double>.invalidValue(let invalidString) {
			XCTAssertEqual(invalidString, "invalid")
		} catch {
			XCTFail("Unexpected error '\(error)'")
		}
	}
}

extension StringEncodingDecodingTests {
	func testEncodeAsString() throws {
		let value = Value(value: 1.101)
		let data = try encoder.encode(value)
		let json = String(decoding: data, as: UTF8.self)

		XCTAssertEqual(json, "[\"1.101\"]")
	}
}

// MARK: - Private -

private extension StringEncodingDecodingTests {
	struct Value<T>: Equatable where T: Equatable, T: Codable, T: StringParsable, T: CustomStringConvertible {
		let value: T
	}
}

extension StringEncodingDecodingTests.Value: Codable {
	init(from decoder: Decoder) throws {
		var container = try decoder.unkeyedContainer()
		self.value = try container.decodeStringAs(T.self)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.unkeyedContainer()
		try container.encodeAsString(value)
	}
}
