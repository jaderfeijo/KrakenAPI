import Foundation

public extension Kraken.Configuration {
	enum Access {
		case authenticated(key: String)
		case `public`
	}
}

