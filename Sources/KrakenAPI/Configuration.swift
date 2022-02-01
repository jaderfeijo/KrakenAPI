import Foundation

public extension Kraken.Configuration {
	typealias APIKey = String
}

public extension Kraken.Configuration {
	enum Environment {
		case production
		case beta
	}
}

public extension Kraken.Configuration {
	enum Access {
		case authenticated(key: APIKey)
		case `public`
	}
}

public extension Kraken {
	struct Configuration {
		public let environment: Environment
		public let access: Access

		public init(environment: Environment, access: Access) {
			self.environment = environment
			self.access = access
		}
	}
}

