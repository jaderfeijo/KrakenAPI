import XCTest
@testable import KrakenAPI

final class AccessInternalTests: XCTestCase {

	typealias Configuration = Kraken.Configuration
	
	let productionPublicConfiguration = Configuration(
		environment: .production,
		access: .public)
	let productionAuthenticatedConfiguration = Configuration(
		environment: .production,
		access: .authenticated(key: ""))
	let betaPublicConfiguration = Configuration(
		environment: .beta,
		access: .public)
	let betaAuthenticatedConfiguration = Configuration(
		environment: .beta,
		access: .authenticated(key: ""))

	func testWebsocketHostname() throws {
		XCTAssertEqual(productionPublicConfiguration.websocketHostname, "ws.kraken.com")
		XCTAssertEqual(productionAuthenticatedConfiguration.websocketHostname, "ws-auth.kraken.com")
		XCTAssertEqual(betaPublicConfiguration.websocketHostname, "beta-ws.kraken.com")
		XCTAssertEqual(betaAuthenticatedConfiguration.websocketHostname, "beta-ws-auth.kraken.com")
	}
}
