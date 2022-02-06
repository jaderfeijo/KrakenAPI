import XCTest
@testable import KrakenAPI

final class WebSocketAPITests: XCTestCase {

	var config: Configuration!
	var sut: WebSocketAPI!

	override func setUpWithError() throws {
		try super.setUpWithError()

		config = .init(
			environment: .beta,
			access: .public)
		sut = .init(
			configuration: config)
	}

	override func tearDownWithError() throws {
		config = nil
		sut = nil

		try super.tearDownWithError()
	}

	func testInit() throws {
		XCTAssertNotNil(sut)
	}
}
