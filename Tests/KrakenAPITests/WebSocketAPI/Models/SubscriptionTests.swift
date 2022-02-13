import XCTest
@testable import KrakenAPI

class SubscriptionTests: XCTestCase {
	override func setUpWithError() throws {
		try super.setUpWithError()
	}

	override func tearDownWithError() throws {
		try super.tearDownWithError()
	}
}

// MARK: - Depth Tests

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
