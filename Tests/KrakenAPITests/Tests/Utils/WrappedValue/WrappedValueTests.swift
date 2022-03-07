import XCTest
@testable import KrakenAPI

final class WrappedValueTests: XCTestCase {

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

extension WrappedValueTests {
	func testDecodeAsString() throws {
		let data = """
		["1.101"]
		""".data(using: .utf8)!
		let decoded = try decoder.decode(Value.self, from: data)

		XCTAssertEqual(decoded, .init(wrappedValue: .init(value: 1.101)))
	}

	func testDecodeAsStringError() throws {
		let data = """
		["invalid"]
		""".data(using: .utf8)!

		do {
			_ = try decoder.decode(Value.self, from: data)
			XCTFail("Expected failure")
		} catch StringWrapped<Double>.ParsingError.invalidValue(let invalidString) {
			XCTAssertEqual(invalidString, "invalid")
		} catch {
			XCTFail("Unexpected error '\(error)'")
		}
	}
}

extension WrappedValueTests {
	func testEncodeAsString() throws {
		let value = Value(wrappedValue: .init(value: 1.101))
		let data = try encoder.encode(value)
		let json = String(decoding: data, as: UTF8.self)

		XCTAssertEqual(json, "[\"1.101\"]")
	}
}

// MARK: - Private -

private extension WrappedValueTests {
	struct Value: Equatable {
		let wrappedValue: WrappedValue<Double, String>
	}
}

extension WrappedValueTests.Value: Codable {
	init(from decoder: Decoder) throws {
		var container = try decoder.unkeyedContainer()
		self.wrappedValue = try container.decode(WrappedValue<Double, String>.self)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.unkeyedContainer()
		try container.encode(wrappedValue)
	}
}
