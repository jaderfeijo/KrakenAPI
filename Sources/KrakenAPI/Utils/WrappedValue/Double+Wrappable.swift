import Foundation

extension Double: Wrappable {
	init?(unwrapping wrapped: String) {
		self.init(wrapped)
	}

	func wrapped() -> String {
		description
	}
}
