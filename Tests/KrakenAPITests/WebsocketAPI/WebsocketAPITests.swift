import XCTest
@testable import KrakenAPI

final class WebsocketAPITests: XCTestCase {

	var config: Kraken.Configuration!
	var sut: Kraken.WebsocketAPI!

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

final class KrakenConfigurationAccessExtensionTests: XCTestCase {

	let publicAccess: Kraken.Configuration.Access = .public
	let authenticatedAccess: Kraken.Configuration.Access = .authenticated(key: "none")

	func testWebsocketHostname() throws {
		XCTAssertEqual(
			publicAccess.websocketHostname(for: .production),
			"ws.kraken.com"
		)
		XCTAssertEqual(
			publicAccess.websocketHostname(for: .beta),
			"beta-ws.kraken.com"
		)
		XCTAssertEqual(
			authenticatedAccess.websocketHostname(for: .production),
			"ws-auth.kraken.com"
		)
		XCTAssertEqual(
			authenticatedAccess.websocketHostname(for: .beta),
			"beta-ws-auth.kraken.com"
		)
	}
}
