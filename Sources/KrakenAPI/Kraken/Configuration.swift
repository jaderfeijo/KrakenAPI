import Foundation

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
