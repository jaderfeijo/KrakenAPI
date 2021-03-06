import Foundation
import ArgumentParser
import KrakenAPI

struct SelfTest: ParsableCommand {
	
	public static let configuration = CommandConfiguration(
		abstract: "Performs various tests against the public Kraken API"
	)
	
	func run() throws {
		exitOnCtrlC()

		let configuration = Configuration(
			environment: .production,
			access: .public)
		let wsapi = WebSocketAPI(
			configuration: configuration)
		
		wsapi.connect()
		
		RunLoop.main.run()
	}

	func exitOnCtrlC() {
		signal(SIGINT) { _ in SelfTest.exit() }
	}
}
