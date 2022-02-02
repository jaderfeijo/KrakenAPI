import Foundation

extension Kraken.Configuration.Access {
	func websocketHostname(for environment: Kraken.Configuration.Environment) -> String {
		switch (environment, self) {
		case (.production, .public):
			return "ws.kraken.com"
		case (.production, .authenticated):
			return "ws-auth.kraken.com"
		case (.beta, .public):
			return "beta-ws.kraken.com"
		case (.beta, .authenticated):
			return "beta-ws-auth.kraken.com"
		}
	}
}
