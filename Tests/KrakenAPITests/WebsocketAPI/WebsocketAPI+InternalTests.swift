import XCTest
@testable import KrakenAPI

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
