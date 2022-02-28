import XCTest
@testable import KrakenAPI

class EventTests: XCTestCase {

	typealias Event = WebSocketAPI.Messages.General.Event

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
		let data = try encoder.encode(
			Event.allCases.map {
				JsonValue<Event>(value: $0)
			}
		)
		let json = String(decoding: data, as: UTF8.self)

		XCTAssertEqual(
			json,
			"""
			[
			  {
			    "value" : "ping"
			  },
			  {
			    "value" : "pong"
			  },
			  {
			    "value" : "heartbeat"
			  },
			  {
			    "value" : "systemStatus"
			  },
			  {
			    "value" : "subscribe"
			  },
			  {
			    "value" : "unsubscribe"
			  },
			  {
			    "value" : "subscriptionStatus"
			  }
			]
			"""
		)
	}

	func testDecoding() throws {
		let data = """
		[
			{"value": "ping"},
			{"value": "pong"},
			{"value": "heartbeat"},
			{"value": "systemStatus"},
			{"value": "subscribe"},
			{"value": "unsubscribe"},
			{"value": "subscriptionStatus"}
		]
		""".data(using: .utf8)!
		let decoded = try decoder.decode([JsonValue<Event>].self, from: data)

		XCTAssertEqual(
			decoded,
			Event.allCases.map { .init(value: $0) }
		)
	}

	func testDecodingInvalid() throws {
		let data = """
		{
			"value": "invalid"
		}
		""".data(using: .utf8)!

		do {
			_ = try decoder.decode(Event.self, from: data)
			XCTFail("Expected failure!")
		} catch is DecodingError {
			// success
		} catch {
			XCTFail("Unexpected error '\(error)'")
		}
	}
}
