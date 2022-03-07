import XCTest
@testable import KrakenAPI

final class SystemStatusTests: XCTestCase {

	typealias SystemStatus = WebSocketAPI.Messages.General.SystemStatus

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
		let status = SystemStatus(
			status: .online,
			version: "1.0",
			connectionID: 8628615390848610000)
		let data = try encoder.encode(status)
		let json = String(decoding: data, as: UTF8.self)

		XCTAssertEqual(
			json,
			"""
			{
			  "connectionID" : 8628615390848610000,
			  "status" : "online",
			  "version" : "1.0"
			}
			"""
		)
	}

	func testEncodingWithoutOptionalValue() throws {
		let status = SystemStatus(
			status: .online,
			version: "1.0")
		let data = try encoder.encode(status)
		let json = String(decoding: data, as: UTF8.self)

		XCTAssertEqual(
			json,
			"""
			{
			  "status" : "online",
			  "version" : "1.0"
			}
			"""
		)
	}

	func testDecoding() throws {
		let data = """
		{
			"connectionID" : 8628615390848610000,
			"status" : "online",
			"version" : "1.0"
		}
		""".data(using: .utf8)!
		let decoded = try decoder.decode(SystemStatus.self, from: data)

		XCTAssertEqual(
			decoded,
			.init(
				status: .online,
				version: "1.0",
				connectionID: 8628615390848610000
			)
		)
	}

	func testDecodingWithoutOptionalValue() throws {
		let data = """
		{
			"status" : "online",
			"version" : "1.0"
		}
		""".data(using: .utf8)!
		let decoded = try decoder.decode(SystemStatus.self, from: data)

		XCTAssertEqual(
			decoded,
			.init(
				status: .online,
				version: "1.0"
			)
		)
	}
}

// MARK: - Status -

final class StatusTests: XCTestCase {

	typealias Status = WebSocketAPI.Messages.General.SystemStatus.Status

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
		let objects: [JsonValue<Status>] = Status.allCases.map { .init(value: $0) }
		let data = try encoder.encode(objects)
		let encoded = String(decoding: data, as: UTF8.self)

		XCTAssertEqual(
			encoded,
			"""
			[
			  {
			    "value" : "online"
			  },
			  {
			    "value" : "maintenance"
			  },
			  {
			    "value" : "cancel_only"
			  },
			  {
			    "value" : "limit_only"
			  },
			  {
			    "value" : "post_only"
			  }
			]
			"""
		)
	}

	func testDecoding() throws {
		let data = """
		[
			{"value" : "online"},
			{"value" : "maintenance"},
			{"value" : "cancel_only"},
			{"value" : "limit_only"},
			{"value" : "post_only"}
		]
		""".data(using: .utf8)!
		let decoded = try decoder.decode([JsonValue<Status>].self, from: data)

		XCTAssertEqual(
			decoded,
			Status.allCases.map { .init(value: $0) }
		)
	}

	func testDecodingInvalid() throws {
		let data = """
		{
			"value": "invalid_case"
		}
		""".data(using: .utf8)!

		do {
			_ = try decoder.decode(JsonValue<Status>.self, from: data)
			XCTFail("Expected failure")
		} catch is DecodingError {
			// success
		} catch {
			XCTFail("Expected DecodingError, got '\(error)' instead")
		}
	}
}
