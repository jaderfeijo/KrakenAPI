import XCTest
@testable import KrakenAPI

class PingTests: XCTestCase {

	typealias Ping = WebSocketAPI.Messages.General.Ping

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
		let ping = Ping(requestId: 42)
		let data = try encoder.encode(ping)
		let json = String(decoding: data, as: UTF8.self)

		XCTAssertEqual(
			json,
			"""
			{
			  "event" : "ping",
			  "reqid" : 42
			}
			"""
		)
	}

	func testEncodingNoRequestId() throws {
		let ping = Ping(requestId: nil)
		let data = try encoder.encode(ping)
		let json = String(decoding: data, as: UTF8.self)

		XCTAssertEqual(
			json,
			"""
			{
			  "event" : "ping"
			}
			"""
		)
	}

	func testDecoding() throws {
		let data = """
		{
			"event" : "ping",
			"reqid" : 42
		}
		""".data(using: .utf8)!
		let decoded = try decoder.decode(Ping.self, from: data)

		XCTAssertEqual(decoded, Ping(requestId: 42))
	}

	func testDecodingNoRequestId() throws {
		let data = """
		{
			"event" : "ping"
		}
		""".data(using: .utf8)!
		let decoded = try decoder.decode(Ping.self, from: data)

		XCTAssertEqual(decoded, Ping(requestId: nil))
	}
}
