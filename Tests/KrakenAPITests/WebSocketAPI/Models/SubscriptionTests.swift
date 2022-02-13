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

extension SubscriptionTests {
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
			let objects = Interval.allCases.map(JsonObject<Interval>.init)
			let data = try encoder.encode(objects)
			let json = String(decoding: data, as: UTF8.self)

			XCTAssertEqual(
				json,
				"""
				[
				  {
				    "object" : 1
				  },
				  {
				    "object" : 5
				  },
				  {
				    "object" : 15
				  },
				  {
				    "object" : 30
				  },
				  {
				    "object" : 60
				  },
				  {
				    "object" : 240
				  },
				  {
				    "object" : 1440
				  },
				  {
				    "object" : 10080
				  },
				  {
				    "object" : 21600
				  }
				]
				"""
			)
		}

		func testDecode() throws {
			let data = """
			[
				{"object": 1},
				{"object": 5},
				{"object": 15},
				{"object": 30},
				{"object": 60},
				{"object": 240},
				{"object": 1440},
				{"object": 10080},
				{"object": 21600}
			]
			""".data(using: .utf8)!
			let decoded = try decoder.decode([JsonObject<Interval>].self, from: data)

			XCTAssertEqual(decoded.map(\.object), Interval.allCases)
		}

		func testDecodeInvalid() throws {
			let data = """
			{
				"object": 3
			}
			""".data(using: .utf8)!

			do {
				_ = try decoder.decode(JsonObject<Interval>.self, from: data)
				XCTFail("Expected failure")
			} catch is DecodingError {
				// success
			} catch {
				XCTFail("Unexpected error '\(error)'")
			}
		}
	}
}

// MARK: - Private -

extension SubscriptionTests {
	struct JsonObject<T: Codable>: Codable {
		let object: T
	}
}
