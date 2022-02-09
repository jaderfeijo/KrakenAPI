import XCTest
@testable import KrakenAPI

final class SystemStatusTests: XCTestCase {

	typealias SystemStatus = WebSocketAPI.SystemStatus

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
}

final class StatusTests: XCTestCase {

	typealias Status = WebSocketAPI.SystemStatus.Status

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
		let statuses: [Status] = Status.allCases
		let objects: [JSONObject] = statuses.map { .init(status: $0) }
		let data = try encoder.encode(objects)
		let encoded = String(decoding: data, as: UTF8.self)

		XCTAssertEqual(
			encoded,
			"""
			[
			  {
			    "status" : "online"
			  },
			  {
			    "status" : "maintenance"
			  },
			  {
			    "status" : "cancel_only"
			  },
			  {
			    "status" : "limit_only"
			  },
			  {
			    "status" : "post_only"
			  }
			]
			"""
		)
	}

	func testDecoding() throws {
		let data = """
		[
			{"status" : "online"},
			{"status" : "maintenance"},
			{"status" : "cancel_only"},
			{"status" : "limit_only"},
			{"status" : "post_only"}
		]
		""".data(using: .utf8)!
		let decoded = try decoder.decode([JSONObject].self, from: data)

		XCTAssertEqual(
			decoded,
			[
				.init(status: .online),
				.init(status: .maintenance),
				.init(status: .cancelOnly),
				.init(status: .limitOnly),
				.init(status: .postOnly)
			]
		)
	}

	func testDecodingInvalid() throws {
		let data = """
		{
			"status": "invalid_case"
		}
		""".data(using: .utf8)!

		do {
			_ = try decoder.decode(JSONObject.self, from: data)
		} catch is DecodingError {
			// success
		} catch {
			XCTFail("Expected DecodingError, got '\(error)' instead")
		}
	}
}

// MARK: - Private -

private extension StatusTests {
	struct JSONObject: Equatable, Codable {
		let status: Status
	}
}
