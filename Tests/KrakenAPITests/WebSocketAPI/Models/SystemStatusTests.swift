import XCTest
@testable import KrakenAPI

final class SystemStatusTests: XCTestCase {
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
			    \"status\" : \"online\"
			  },
			  {
			    \"status\" : \"maintenance\"
			  },
			  {
			    \"status\" : \"cancel_only\"
			  },
			  {
			    \"status\" : \"limit_only\"
			  },
			  {
			    \"status\" : \"post_only\"
			  }
			]
			"""
		)
	}

	func testDecoding() throws {
		let data = """
		[
			{\"status\" : \"online\"},
			{\"status\" : \"maintenance\"},
			{\"status\" : \"cancel_only\"},
			{\"status\" : \"limit_only\"},
			{\"status\" : \"post_only\"}
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
}

// MARK: - Private -

private extension StatusTests {
	struct JSONObject: Equatable, Codable {
		let status: Status
	}
}
